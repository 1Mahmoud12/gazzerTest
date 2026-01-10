import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class StoresOfCategoryStates {
  final List<ProductEntity> todaysDeals;
  final List<StoreEntity> stores;
  final StoreCategoryEntity subCategory;
  StoresOfCategoryStates({
    this.todaysDeals = const [],
    this.stores = const [],
    this.subCategory = Fakers.storeCat,
  });
}

class StoresOfCategoryInitial extends StoresOfCategoryStates {}

class StoresOfCategoryLoading extends StoresOfCategoryStates {
  StoresOfCategoryLoading({
    super.todaysDeals = Fakers.fakeProds,
    super.stores = Fakers.stores,
  });
}

class StoresOfCategoryLoaded extends StoresOfCategoryStates {
  StoresOfCategoryLoaded({
    required super.todaysDeals,
    required super.stores,
    required super.subCategory,
  });
}

class StoresOfCategoryError extends StoresOfCategoryStates {
  final String message;
  StoresOfCategoryError({required this.message});
}
