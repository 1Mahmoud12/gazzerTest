import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

class AddToCartStates extends Equatable {
  final int quantity;
  final String? note;
  final double totalPrice;
  final Map<String, Set<String>> selectedOptions;
  final String message;
  final bool hasUserInteracted;
  final bool hasAddedToCArt;
  final ApiStatus status;

  @override
  List<Object?> get props => [
    quantity,
    note,
    totalPrice,
    selectedOptions,
    message,
    hasUserInteracted,
    hasAddedToCArt,
    status,
  ];
  const AddToCartStates({
    required this.quantity,
    required this.note,
    required this.totalPrice,
    required this.selectedOptions,
    required this.hasUserInteracted,
    required this.hasAddedToCArt,
    required this.status,
    required this.message,
  });

  AddToCartStates copyWith({
    int? qntity,
    String? note,
    double? totalPrice,
    String? message,
    Map<String, Set<String>>? selectedOptions,
    bool? hasUserInteracted,
    bool? hasAddedToCArt,
    ApiStatus? status,
  }) {
    return AddToCartStates(
      status: status ?? this.status,
      quantity: qntity ?? quantity,
      hasAddedToCArt: hasAddedToCArt ?? this.hasAddedToCArt,
      note: note ?? this.note,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      // Create a new map to ensure state change detection
      hasUserInteracted: hasUserInteracted ?? this.hasUserInteracted,
      message: message ?? this.message, // error message wont be passed to other states by default
    );
  }
}
