import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';

sealed class FaqStates {}

final class FaqInitialState extends FaqStates {}

final class FaqLoadingState extends FaqStates {}

final class FaqSuccessState extends FaqStates {
  final List<FaqCategoryEntity> categories;
  final bool isFromCache;

  FaqSuccessState(this.categories, {this.isFromCache = false});
}

final class FaqErrorState extends FaqStates {
  final String error;

  FaqErrorState(this.error);
}
