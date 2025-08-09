import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

sealed class CartStates {}

class CartInitial extends CartStates {}

///
sealed class FullCartStates extends CartStates {
  final List<CartVendorEntity> vendors;
  final CartSummaryModel summary;
  final AddressEntity? address;
  final bool isCartValid;

  FullCartStates({
    this.vendors = Fakers.cartVendors,
    this.summary = Fakers.cartSummary,
    this.address,
    this.isCartValid = false,
  });
}

class FullCartLoading extends FullCartStates {}

class FullCartLoaded extends FullCartStates {
  FullCartLoaded({required super.vendors, required super.summary, required super.address, required super.isCartValid});
}

class FullCartError extends FullCartStates implements BaseErrorState {
  @override
  final String message;
  FullCartError({required this.message});
}

///
sealed class TimeSlotsStates extends CartStates {
  final List<String> timeSlots;
  final String? selectedTime;
  TimeSlotsStates({this.timeSlots = Fakers.timeSlots, this.selectedTime});
}

class TimeSlotsLoading extends TimeSlotsStates {}

class TimeSlotsLoaded extends TimeSlotsStates {
  TimeSlotsLoaded({required super.timeSlots, required super.selectedTime});
}

class TimeSlotsError extends TimeSlotsStates implements BaseErrorState {
  @override
  final String message;
  TimeSlotsError({required this.message});
}

///
sealed class UpdateItemStates extends CartStates {
  final int cartId;
  final bool isAdding;
  final bool isRemoving;
  final bool isDeleting;
  final bool isEditNote;
  UpdateItemStates({
    required this.cartId,
    this.isAdding = false,
    this.isRemoving = false,
    this.isDeleting = false,
    this.isEditNote = false,
  });
}

class UpdateItemLoading extends UpdateItemStates {
  UpdateItemLoading({
    required super.cartId,
    super.isAdding,
    super.isRemoving,
    super.isDeleting,
    super.isEditNote,
  });
}

class UpdateItemSuccess extends UpdateItemStates {
  UpdateItemSuccess({
    required super.cartId,
    super.isAdding,
    super.isRemoving,
    super.isDeleting,
    super.isEditNote,
  });
}

class UpdateItemError extends UpdateItemStates implements BaseErrorState {
  @override
  final String message;
  UpdateItemError({
    required this.message,
    required super.cartId,
    super.isAdding,
    super.isRemoving,
    super.isDeleting,
    super.isEditNote,
  });
}
