import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/dtos/categories_widget_dto.dart';

abstract class CategoriesWidgetStates {}

class CategoriesWidgetInitialState extends CategoriesWidgetStates {}

class CategoriesWidgetLoadingState extends CategoriesWidgetStates {}

class CategoriesWidgetSuccessState extends CategoriesWidgetStates {
  final List<CategoryEntityDto> categories;
  final BannerDTO? banner;
  final bool isFromCache;

  CategoriesWidgetSuccessState(this.categories, this.banner, {this.isFromCache = false});
}

class CategoriesWidgetErrorState extends CategoriesWidgetStates {
  final String message;

  CategoriesWidgetErrorState(this.message);
}
