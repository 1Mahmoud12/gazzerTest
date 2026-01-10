import 'package:equatable/equatable.dart';

class ItemFastActionState extends Equatable {
  final bool isAdding;
  final bool isIncreasing;
  final bool isDecreasing;

  const ItemFastActionState({
    this.isAdding = false,
    this.isIncreasing = false,
    this.isDecreasing = false,
  });

  @override
  List<Object?> get props => [isAdding, isIncreasing, isDecreasing];
}
