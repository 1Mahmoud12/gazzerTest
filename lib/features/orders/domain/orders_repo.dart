import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';

abstract class OrdersRepo extends BaseApiRepo {
  OrdersRepo(super.crashlyticsRepo);

  Future<Result<List<OrderItemEntity>>> getClientOrders({
    int page = 1,
    int perPage = 10,
  });

  Future<List<OrderItemEntity>?> getCachedClientOrders();

  Future<Result<OrderDetailEntity>> getOrderDetail(int orderId);

  Future<OrderDetailEntity?> getCachedOrderDetail(int orderId);

  Future<Result<String>> reorder(int orderId, {bool? continueWithExisting});

  Future<Result<String>> submitOrderReview({
    required int orderId,
    required List<StoreReview> storeReviews,
    required DeliveryManReview deliveryManReview,
  });
}

class StoreReview {
  final int orderStoreId;
  final double rating;

  StoreReview({
    required this.orderStoreId,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
    'order_store_id': orderStoreId,
    'rating': rating,
    'comment': '',
  };
}

class DeliveryManReview {
  final double rating;

  DeliveryManReview({required this.rating});

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': '',
  };
}
