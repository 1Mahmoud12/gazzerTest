import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';

sealed class SingleCatRestaurantStates {
  const SingleCatRestaurantStates();
}

class OrderedWithInitial extends SingleCatRestaurantStates {}

sealed class OrderedWithStates extends SingleCatRestaurantStates {
  final List<OrderedWithEntity> items;
  const OrderedWithStates({required this.items});
}

class OrderedWithLoading extends OrderedWithStates {
  OrderedWithLoading()
    : super(
        items: List.generate(
          3,
          (index) => OrderedWithEntity(
            id: index,
            name: 'Item index',
            image: 'Fakers._netWorkImage',
            price: 0,
            rate: 3,
            reviewCount: 0,
            outOfStock: false,
          ),
        ),
      );
}

class OrderedWithLoaded extends OrderedWithStates {
  OrderedWithLoaded({required super.items});
}

class OrderedWithError extends OrderedWithStates {
  final String message;
  OrderedWithError({required this.message}) : super(items: []);
}

sealed class PlateDetailsStates extends SingleCatRestaurantStates {
  final PlateEntity plate;
  final List<ItemOptionEntity> options;
  final List<OrderedWithEntity> orderedWith;

  const PlateDetailsStates({
    this.plate = Fakers.plate,
    this.options = const [],
    this.orderedWith = const [],
  });
}

class PlateDetailsInitial extends PlateDetailsStates {}

class PlateDetailsLoading extends PlateDetailsStates {
  PlateDetailsLoading()
    : super(
        plate: Fakers.plate,
        options: Fakers.plateOptions,
        orderedWith: Fakers.plateOrderedWith,
      );
}

class PlateDetailsLoaded extends PlateDetailsStates {
  const PlateDetailsLoaded({
    required super.plate,
    required super.options,
    required super.orderedWith,
  });
}

class PlateDetailsError extends PlateDetailsStates {
  final String message;
  const PlateDetailsError({required this.message});
}
