import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  @override
  void emit(AddToCartStates state) {
    if (isClosed) return;
    super.emit(state.copyWith(totalPrice: _calculatePrice(state)));
  }

  CartItemEntity? cartITem;
  final GenericItemEntity item;
  final List<ItemOptionEntity> options;
  late final double basePrice;
  AddToCartCubit(this.item, this.options, [this.cartITem])
    : basePrice = options.any((e) => e.controlsPrice) ? 0 : item.price,
      super(
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
    if (msg != null) return emit(state.copyWith(message: msg));
    final req = CartableItemRequest(
      id: item.id,
      quantity: state.quantity,
      note: state.note,
      options: state.selectedOptions,
      type: item is PlateEntity ? CartItemType.plate : CartItemType.product,
    );
    emit(state.copyWith(status: ApiStatus.loading));
    final result = await di<CartBus>().addToCart(req);
    if (result.$1) {
      emit(state.copyWith(status: ApiStatus.success, message: result.$2, hasUserInteracted: false));
    } else {
      emit(state.copyWith(status: ApiStatus.error, message: result.$2, hasUserInteracted: false));
    }
  }

  String? _validateCart() {
    if (state.quantity < 1) return "Quantity must be at least 1";
    final requiredOptions = options.where((o) => o.isRequired);
    if (requiredOptions.isEmpty) return null;
    for (var opt in requiredOptions) {
      if (state.selectedOptions.containsKey(opt.id) && state.selectedOptions[opt.id]!.isNotEmpty) {
        continue;
      } else {
        return 'Please select at least one value for the option: ${opt.name}';
      }
    }
    return null;
  }

  void userEquestClose() {
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
