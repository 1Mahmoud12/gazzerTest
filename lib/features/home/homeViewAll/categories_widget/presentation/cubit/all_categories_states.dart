import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

abstract class AllCategoriesStates {}

class AllCategoriesInitialState extends AllCategoriesStates {}

class AllCategoriesLoadingState extends AllCategoriesStates {}

class AllCategoriesLoadingMoreState extends AllCategoriesStates {
  final List<MainCategoryEntity> categories;
  final PaginationInfo? pagination;

  AllCategoriesLoadingMoreState(this.categories, this.pagination);
}

class AllCategoriesSuccessState extends AllCategoriesStates {
  final List<MainCategoryEntity> categories;
  final PaginationInfo? pagination;

  AllCategoriesSuccessState(this.categories, {this.pagination});
}

class AllCategoriesErrorState extends AllCategoriesStates {
  final String error;

  AllCategoriesErrorState(this.error);
}
