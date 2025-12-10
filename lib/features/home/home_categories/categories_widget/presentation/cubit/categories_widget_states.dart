import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

abstract class CategoriesWidgetStates {}

class CategoriesWidgetInitialState extends CategoriesWidgetStates {}

class CategoriesWidgetLoadingState extends CategoriesWidgetStates {}

class CategoriesWidgetSuccessState extends CategoriesWidgetStates {
  final List<MainCategoryEntity> categories;
  final bool isFromCache;

  CategoriesWidgetSuccessState(this.categories, {this.isFromCache = false});
}

class CategoriesWidgetErrorState extends CategoriesWidgetStates {
  final String message;

  CategoriesWidgetErrorState(this.message);
}
