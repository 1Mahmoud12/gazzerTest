import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/models/cart_summary_model.dart';

sealed class CartStates {}

class CartInitial extends CartStates {}

///
sealed class UpdateVendorsStates extends CartStates {
  final List<CartVendorEntity> vendors;
  UpdateVendorsStates({this.vendors = const []});
}

class UpdateVendorsLoading extends UpdateVendorsStates {
  UpdateVendorsLoading() : super(vendors: Fakers.cartVendors);
}

class UpdateVendorsLoaded extends UpdateVendorsStates {
  UpdateVendorsLoaded({required super.vendors});
}

class UpdateVendorsError extends UpdateVendorsStates implements BaseErrorState {
  @override
  final String message;
  UpdateVendorsError({required this.message});
}

///
sealed class UpdateSummaryStates extends CartStates {
  final CartSummaryModel summary;
  UpdateSummaryStates({this.summary = Fakers.cartSummary});
}

class UpdateSummaryLoading extends UpdateSummaryStates {}

class UpdateSummaryLoaded extends UpdateSummaryStates {
  UpdateSummaryLoaded({required super.summary});
}

class UpdateSummaryError extends UpdateSummaryStates implements BaseErrorState {
  @override
  final String message;
  UpdateSummaryError({required this.message});
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
sealed class UpdateCartAddress extends CartStates {
  final AddressEntity? address;
  UpdateCartAddress({this.address});
}

class UpdateCartAddressLoading extends UpdateCartAddress {
  UpdateCartAddressLoading({super.address});
}

class UpdateCartAddressLoaded extends UpdateCartAddress {
  UpdateCartAddressLoaded({required super.address});
}

class UpdateCartAddressError extends UpdateCartAddress implements BaseErrorState {
  @override
  final String message;
  UpdateCartAddressError({required this.message, super.address});
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
