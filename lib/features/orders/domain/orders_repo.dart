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
}
