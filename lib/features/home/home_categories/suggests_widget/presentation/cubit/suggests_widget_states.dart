import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

abstract class SuggestsWidgetStates {}

class SuggestsWidgetInitialState extends SuggestsWidgetStates {}

class SuggestsWidgetLoadingState extends SuggestsWidgetStates {}

class SuggestsWidgetSuccessState extends SuggestsWidgetStates {
  final List<GenericItemEntity> entities;
  final BannerEntity? banner;
  final bool isFromCache;

  SuggestsWidgetSuccessState(this.entities, this.banner, {this.isFromCache = false});
}

class SuggestsWidgetErrorState extends SuggestsWidgetStates {
  final String message;

  SuggestsWidgetErrorState(this.message);
}
