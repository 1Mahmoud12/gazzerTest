import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  @override
  void emit(AddToCartStates state) {
    if (isClosed) return;
    super.emit(state.copyWith(totalPrice: _calculatePrice(state)));
  }

  final CartRepo _repo;
  CartItemEntity? cartItem;
  final GenericItemEntity item;
  final List<ItemOptionEntity> options;
  late final double basePrice;
  final CartBus _bus;
  AddToCartCubit(this.item, this.options, this._repo, this._bus, [this.cartItem])
    : basePrice = options.any((e) => e.controlsPrice) ? 0 : item.price,
      super(
        AddToCartStates(
          message: '',
          status: ApiStatus.initial,
          hasUserInteracted: false,
          hasAddedToCArt: false,
          note: cartItem?.notes,
          quantity: cartItem?.quantity ?? 1,
          totalPrice:
              cartItem?.totalPrice ??
              (options.any((e) => e.controlsPrice)
                  ? options.firstWhere((e) => e.controlsPrice).values.firstWhereOrNull((e) => e.isDefault)?.price ?? 0
                  : item.price),
          selectedOptions: () {
            if (cartItem != null) {
              final map = <int, Set<int>>{};
              for (var option in cartItem.options) {
                map[option.id] = option.values.map((e) => e.id).toSet();
              }
              return map;
            }
            final optionsWithDefault = options.where((e) => e.values.any((v) => v.isDefault));
            if (optionsWithDefault.isEmpty) return <int, Set<int>>{};
            final map = <int, Set<int>>{};
            for (var option in optionsWithDefault) {
              map[option.id] = {option.values.firstWhere((v) => v.isDefault).id};
            }
            return map;
          }(),
        ),
      ) {
    print("cart item is ${cartItem?.prod.name}");
    emit(state);
  }

  void increment() {
    emit(state.copyWith(qntity: state.quantity + 1, hasUserInteracted: true));
  }

  void decrement() {
    if (state.quantity > 1) {
      emit(state.copyWith(qntity: state.quantity - 1, hasUserInteracted: true));
    }
  }

  void setNote(String note) {
    emit(state.copyWith(note: note, hasUserInteracted: true));
  }

  void setOptionValue(int optionId, int valueId) {
    final isExist = state.selectedOptions.containsKey(optionId);
    if (!isExist) {
      _addNewOption(optionId, valueId);
    } else {
      final option = options.firstWhere((o) => o.id == optionId);
      if (option.type == OptionType.radio) {
        _setRadioOption(optionId, valueId);
      } else if (option.type == OptionType.checkbox) {
        _setCheckBoxOption(optionId, valueId);
      }
    }
  }

  void _addNewOption(int optionId, int valueId) {
    final newMap = Map<int, Set<int>>.from(state.selectedOptions);
    newMap.addAll({
      optionId: {valueId},
    });
    emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: true));
  }

  void _setRadioOption(int optionId, int valueId) {
    final newMap = Map<int, Set<int>>.from(state.selectedOptions);
    newMap[optionId] = {valueId};
    emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: true));
  }

  void _setCheckBoxOption(int optionId, int valueId) {
    final newMap = Map<int, Set<int>>.of(state.selectedOptions);
    if (newMap.containsKey(optionId)) {
      if (newMap[optionId]!.contains(valueId)) {
        newMap[optionId] = {...newMap[optionId]!.where((id) => id != valueId)};
        if (newMap[optionId]!.isEmpty) newMap.remove(optionId);
      } else {
        newMap[optionId] = {...newMap[optionId]!, valueId};
      }
    } else {
      newMap[optionId] = {valueId};
    }
    emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: true));
  }

  double _calculatePrice(AddToCartStates state) {
    double optionsCost = 0;
    for (var option in options) {
      if (state.selectedOptions.containsKey(option.id)) {
        final selectedValues = state.selectedOptions[option.id]!;
        for (var value in option.values) {
          if (selectedValues.contains(value.id)) {
            optionsCost += value.price;
          }
        }
      }
    }
    return (basePrice * state.quantity) + (optionsCost * state.quantity);
  }

  Future<void> addToCart() async {
    final msg = _validateCart();
    print('msg is $msg');
    if (msg != null) return emit(state.copyWith(message: msg, status: ApiStatus.error));
    final req = CartableItemRequest(
      cartItemId: cartItem?.cartId,
      id: item.id,
      quantity: state.quantity,
      note: state.note,
      options: state.selectedOptions,
      type: item is PlateEntity ? CartItemType.plate : CartItemType.product,
    );
    if (cartItem != null) {
      _updateCart(req);
    } else {
      _addCartToRemote(req);
    }
  }

  Future<void> _addCartToRemote(CartableItemRequest req) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final response = await _repo.addToCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _bus.cartResponseToValues(res.value);
        emit(state.copyWith(status: ApiStatus.success, message: res.value.message, hasUserInteracted: false));
      case Err err:
        emit(state.copyWith(status: ApiStatus.error, message: err.error.message, hasUserInteracted: false));
    }
  }

  Future<void> _updateCart(CartableItemRequest req) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final response = await _repo.updateCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _bus.cartResponseToValues(res.value);
        emit(state.copyWith(status: ApiStatus.success, message: res.value.message, hasUserInteracted: false));
      case Err err:
        emit(state.copyWith(status: ApiStatus.error, message: err.error.message, hasUserInteracted: false));
    }
  }

  String? _validateCart() {
    if (Session().client == null) return L10n.tr().pleaseLoginToUseCart;
    if (state.quantity < 1) return L10n.tr().quantityValidation;
    final requiredOptions = options.where((o) => o.isRequired);
    if (requiredOptions.isEmpty) return null;
    for (var opt in requiredOptions) {
      if (state.selectedOptions.containsKey(opt.id) && state.selectedOptions[opt.id]!.isNotEmpty) {
        continue;
      } else {
        return L10n.tr().pleaseSelectAtLeastOneValueOptionForName(opt.name);
      }
    }
    return null;
  }

  void userRequestClose() {
    emit(state.copyWith(hasUserInteracted: false));
  }

  void resetState() {
    emit(
      AddToCartStates(
        message: '',
        status: ApiStatus.initial,
        hasUserInteracted: false,
        hasAddedToCArt: false,
        note: null,
        quantity: 1,
        totalPrice: options.any((e) => e.controlsPrice)
            ? options.firstWhere((e) => e.controlsPrice).values.firstWhereOrNull((e) => e.isDefault)?.price ?? 0
            : item.price,
        selectedOptions: () {
          final optionsWithDefault = options.where((e) => e.values.any((v) => v.isDefault));
          if (optionsWithDefault.isEmpty) return <int, Set<int>>{};
          final map = <int, Set<int>>{};
          for (var option in optionsWithDefault) {
            map[option.id] = {option.values.firstWhere((v) => v.isDefault).id};
          }
          return map;
        }(),
      ),
    );
  }
}
