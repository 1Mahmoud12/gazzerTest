import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class StoreDetailsStates {
  final StoreEntity store;
  final List<(StoreCategoryEntity, List<StoreCategoryEntity> subcats, List<ProductEntity> prods)> catsWthSubatsAndProds;
  final List<ProductEntity> bestSellingItems;

  StoreDetailsStates({this.store = Fakers.store, this.catsWthSubatsAndProds = const [], this.bestSellingItems = const []});
}

class StoreDetailsInitial extends StoreDetailsStates {}

class StoreDetailsLoading extends StoreDetailsStates {
  StoreDetailsLoading({
    super.store = Fakers.store,
    super.catsWthSubatsAndProds = const [
      (Fakers.storeCat, [Fakers.storeCat], Fakers.fakeProds),
      (Fakers.storeCat, [Fakers.storeCat], Fakers.fakeProds),
      (Fakers.storeCat, [Fakers.storeCat], Fakers.fakeProds),
    ],
    super.bestSellingItems = const [],
  });
}

class StoreDetailsLoaded extends StoreDetailsStates {
  StoreDetailsLoaded({required super.store, required super.catsWthSubatsAndProds, super.bestSellingItems = const []});
}

class StoreDetailsError extends StoreDetailsStates {
  final String message;

  StoreDetailsError({required this.message, super.bestSellingItems = const []});
}
