import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

abstract class ProductDetailsState {
  final ProductEntity product;
  ProductDetailsState({this.product = Fakers.favorite});
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  ProductDetailsLoaded({required super.product});
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}
