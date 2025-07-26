import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';

sealed class HomeStates {}

final class HomeInitialState extends HomeStates {}

/// Category states
sealed class CategoryStates extends HomeStates {
  final List<CategoryEntity> categories;
  CategoryStates({this.categories = const []});
}

final class CategoryLoadingState extends CategoryStates {
  CategoryLoadingState() : super(categories: Fakers().fakeCats);
}

final class CategorySuccessState extends CategoryStates {
  CategorySuccessState(List<CategoryEntity> categories) : super(categories: categories);
}

final class CategoryErrorState extends CategoryStates {
  final String msg;
  CategoryErrorState(this.msg);
}

/// Home states
sealed class HomeDataStates extends HomeStates {
  final HomeDataModel? homeResponse;
  HomeDataStates({this.homeResponse});
}

final class HomeDataLoadingState extends HomeDataStates {
  HomeDataLoadingState({super.homeResponse});
}

final class HomeDataSuccessState extends HomeDataStates {
  HomeDataSuccessState({required super.homeResponse});
}

final class HomeDataErrorState extends HomeDataStates {
  final String msg;
  HomeDataErrorState(this.msg, {super.homeResponse});
}
