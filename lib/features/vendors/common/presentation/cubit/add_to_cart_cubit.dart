import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/cart_item.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  CartItem? cartItem;
  final GenericItemEntity item;
  final List<ItemOptionEntity> options;

  AddToCartCubit(this.item, this.options, {this.cartItem})
    : super(
        AddToCartStates(
          note: null,
          qntity: 1,
          totalPrice: item.price,
          options: () {
            if (cartItem != null) return cartItem.options;
            return options.map((e) {
              return CartItemOption.fromOption(
                e,
                e.values.where((v) => v.isDefault).map((v) => CartOptionValue.fromOptionValue(v)).toList(),
              );
            }).toList();
          }(),
        ),
      );

  void _initCartITem() => cartItem ??= CartItem.fromProduct(item);

  void increment() {
    _initCartITem();
    cartItem!.quantity++;
    emit(state.copyWith(qntity: cartItem!.quantity, totalPrice: cartItem!.totalPrice));
  }

  void decrement() {
    _initCartITem();
    if (cartItem!.quantity > 1) {
      cartItem!.quantity--;
      emit(state.copyWith(qntity: cartItem!.quantity, totalPrice: cartItem!.totalPrice));
    }
  }

  void setNote(String? note) {
    _initCartITem();
    cartItem!.notes = note;
    emit(state.copyWith(note: note));
  }

  void setOptionValue(int optionId, int valueId) {
    _initCartITem();
    final option = options.firstWhere((o) => o.id == optionId);
    final index = cartItem!.options.indexWhere((option) => option.id == optionId);
    if (index == -1) {
      _addNewOption(option, valueId);
    } else {
      if (option.type == OptionType.radio) {
        _setRadioOption(index, valueId);
      } else if (option.type == OptionType.checkbox) {
        _setCheckBoxOption(optionId, valueId);
      }
    }
    emit(state.copyWith(options: cartItem!.options, totalPrice: cartItem!.totalPrice));
  }

  void _addNewOption(ItemOptionEntity option, int valueId) {
    final value = option.values.firstWhere((v) => v.id == valueId);
    cartItem!.options.add(
      CartItemOption.fromOption(option, [CartOptionValue.fromOptionValue(value)]),
    );
  }

  void _setRadioOption(int index, int valueId) {
    cartItem!.options[index].values.clear();
    final value = options[index].values.firstWhere((v) => v.id == valueId);
    cartItem!.options[index].values.add(CartOptionValue.fromOptionValue(value));
  }

  void _setCheckBoxOption(int index, int valueId) {
    final option = cartItem!.options[index];
    if (option.values.any((v) => v.id == valueId)) {
      option.values.removeWhere((v) => v.id == valueId);
    } else {
      option.values.add(CartOptionValue.fromOptionValue(options[index].values.firstWhere((v) => v.id == valueId)));
    }
  }
}
