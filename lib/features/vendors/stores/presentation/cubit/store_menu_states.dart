import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

sealed class StoresMenuStates {
  late final MainCategoryEntity mainCategory;
  late final List<BannerEntity> banners;
  late final List<(StoreCategoryEntity, List<StoreEntity>)> categoryWithStores;

  StoresMenuStates({
    this.mainCategory = Fakers.mainCategory,
    this.banners = const [],
    this.categoryWithStores = const [],
  });
}

final class StoresMenuInit extends StoresMenuStates {}

///
/// screen data states
sealed class ScreenDataStates extends StoresMenuStates {
  ScreenDataStates({super.mainCategory, super.banners, super.categoryWithStores});
}

final class ScreenDataLoading extends ScreenDataStates {}

final class ScreenDataLoaded extends ScreenDataStates {
  ScreenDataLoaded({required super.mainCategory, required super.banners, required super.categoryWithStores});
}

final class ScreenDataError extends ScreenDataStates {
  final String error;
  ScreenDataError({required this.error});
}
