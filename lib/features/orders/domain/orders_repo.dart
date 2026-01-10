import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/domain/entities/active_order_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';

abstract class OrdersRepo extends BaseApiRepo {
  OrdersRepo(super.crashlyticsRepo);

  Future<Result<List<OrderItemEntity>>> getClientOrders({int page = 1, int perPage = 10});

  Future<List<OrderItemEntity>?> getCachedClientOrders();

  Future<Result<List<ActiveOrderEntity>>> getActiveOrders();

  Future<List<ActiveOrderEntity>?> getCachedActiveOrders();

  Future<Result<OrderDetailEntity>> getOrderDetail(int orderId);

  Future<OrderDetailEntity?> getCachedOrderDetail(int orderId);

  Future<Result<String>> reorder(int orderId, {bool? continueWithExisting, bool? addNewPouch});

  Future<Result<String>> submitOrderReview({
    required int orderId,
    required List<StoreReview> storeReviews,
    required List<DeliveryManReview> deliveryManReviews,
  });
}

class StoreReview {
  final int orderStoreId;
  final double rating;
  final String comment;

  StoreReview({required this.orderStoreId, required this.rating, this.comment = ''});

  Map<String, dynamic> toJson() => {'store_id': orderStoreId, 'rating': rating, 'comment': comment};
}

class DeliveryManReview {
  final int deliveryManId;
  final double rating;
  final String comment;

  DeliveryManReview({required this.deliveryManId, required this.rating, this.comment = ''});

  Map<String, dynamic> toJson() => {'delivery_man_id': deliveryManId, 'rating': rating, 'comment': comment};
}
