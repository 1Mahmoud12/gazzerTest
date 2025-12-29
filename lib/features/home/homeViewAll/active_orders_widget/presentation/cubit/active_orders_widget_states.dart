import 'package:gazzer/features/orders/domain/entities/active_order_entity.dart';

abstract class ActiveOrdersWidgetStates {}

class ActiveOrdersWidgetInitialState extends ActiveOrdersWidgetStates {}

class ActiveOrdersWidgetLoadingState extends ActiveOrdersWidgetStates {}

class ActiveOrdersWidgetSuccessState extends ActiveOrdersWidgetStates {
  final List<ActiveOrderEntity> orders;
  final bool isFromCache;

  ActiveOrdersWidgetSuccessState(this.orders, {this.isFromCache = false});
}

class ActiveOrdersWidgetErrorState extends ActiveOrdersWidgetStates {
  final String message;

  ActiveOrdersWidgetErrorState(this.message);
}
