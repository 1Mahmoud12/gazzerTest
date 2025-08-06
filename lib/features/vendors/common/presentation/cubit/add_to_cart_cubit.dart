import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/features/cart/domain/cart_item_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  @override
  void emit(AddToCartStates state) {
    if (isClosed) return;
    super.emit(state.copyWith(totalPrice: _calculatePrice(state)));
  }

  // CartItem? cartItem;
  final GenericItemEntity item;
  final List<ItemOptionEntity> options;
  late final double basePrice;
  AddToCartCubit(this.item, this.options, [CartItemEntity? cartITem])
    : basePrice = options.any((e) => e.controlsPrice) ? 0 : item.price,
      super(
        AddToCartStates(
          hasUserInteracted: false,
          note: null,
          qntity: 1,
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
    emit(state.copyWith(qntity: state.qntity + 1, hasUserInteracted: true));
  }

  void decrement() {
    if (state.qntity > 1) {
      emit(state.copyWith(qntity: state.qntity - 1, hasUserInteracted: true));
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
    return (basePrice * state.qntity) + (optionsCost * state.qntity);
  }

  Future<void> addToCart() async {
    _validateCart();
  }

  String? _validateCart() {
    // if (cartItem!.quantity < 1) return "Quantity must be at least 1";
    // final requiredOptions = options.where((o) => o.isRequired);
    // if (requiredOptions.isEmpty) return null;
    // for (var opt in requiredOptions) {
    //   if (cartItem!.options.any((o) => o.id == opt.id && o.values.isNotEmpty)) {
    //     continue;
    //   } else {
    //     return 'Please select at least one value for the option: ${opt.name}';
    //   }
    // }
    // return null;
  }
}
