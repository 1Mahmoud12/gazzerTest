import 'package:equatable/equatable.dart';

class AddToCartStates extends Equatable {
  final int quantity;
  final String? note;
  final double totalPrice;
  final Map<int, Set<int>> selectedOptions;
  final String? errorMessage;
  final bool hasUserInteracted;

  const AddToCartStates({
    required this.quantity,
    required this.note,
    required this.totalPrice,
    required this.selectedOptions,
    required this.hasUserInteracted,
    this.errorMessage,
  });

  AddToCartStates copyWith({int? qntity, String? note, double? totalPrice, String? message, Map<int, Set<int>>? selectedOptions, bool? hasUserInteracted}) {
    return AddToCartStates(
      quantity: qntity ?? this.quantity,
      note: note ?? this.note,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedOptions: selectedOptions ?? this.selectedOptions, // Create a new map to ensure state change detection
      hasUserInteracted: hasUserInteracted ?? this.hasUserInteracted,
      errorMessage: message, // error message wont be passed to other states by default
    );
  }

  @override
  List<Object?> get props => [quantity, note, totalPrice, selectedOptions, errorMessage];
}
