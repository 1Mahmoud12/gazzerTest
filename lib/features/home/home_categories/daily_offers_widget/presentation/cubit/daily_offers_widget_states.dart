import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

abstract class DailyOffersWidgetStates {}

class DailyOffersWidgetInitialState extends DailyOffersWidgetStates {}

class DailyOffersWidgetLoadingState extends DailyOffersWidgetStates {}

class DailyOffersWidgetSuccessState extends DailyOffersWidgetStates {
  final List<GenericItemEntity> entities;
  final BannerEntity? banner;
  final bool isFromCache;

  DailyOffersWidgetSuccessState(this.entities, this.banner, {this.isFromCache = false});
}

class DailyOffersWidgetErrorState extends DailyOffersWidgetStates {
  final String message;

  DailyOffersWidgetErrorState(this.message);
}
