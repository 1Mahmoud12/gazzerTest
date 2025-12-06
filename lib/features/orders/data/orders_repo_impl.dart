import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/data/dtos/order_detail_response_dto.dart';
import 'package:gazzer/features/orders/data/dtos/orders_response_dto.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kOrdersCache = 'client_orders_json';
const _kOrdersTs = 'client_orders_timestamp';
const _kOrderDetailCachePrefix = 'order_detail_';

class OrdersRepoImpl extends OrdersRepo {
  final ApiClient _apiClient;

  OrdersRepoImpl(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<OrderItemEntity>>> getClientOrders({
    int page = 1,
    int perPage = 10,
  }) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.clientOrders,
        queryParameters: {
          'is_paginated': 1,
          'page': page,
          'per_page': perPage,
        },
      ),
      parser: (response) {
        // Save to cache for first page only
        if (page == 1) {
          _saveToCache(response.data);
        }

        final responseDto = OrdersResponseDto.fromJson(response.data);
        return responseDto.data?.map((orderDto) => orderDto.toEntity()).toList() ?? [];
      },
    );
  }

  Future<void> _saveToCache(dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kOrdersCache, jsonEncode(responseData));
      await sp.setInt(_kOrdersTs, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {
      // ignore cache failures
    }
  }

  @override
  Future<List<OrderItemEntity>?> getCachedClientOrders() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final raw = sp.getString(_kOrdersCache);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final responseDto = OrdersResponseDto.fromJson(map);
      return responseDto.data?.map((orderDto) => orderDto.toEntity()).toList() ?? [];
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<OrderDetailEntity>> getOrderDetail(int orderId) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.orderDetail(orderId),
      ),
      parser: (response) {
        // Save to cache
        _saveOrderDetailToCache(orderId, response.data);

        final responseDto = OrderDetailResponseDto.fromJson(response.data);
        if (responseDto.data == null) {
          throw Exception('Order detail data is null');
        }
        return responseDto.data!.toEntity();
      },
    );
  }

  Future<void> _saveOrderDetailToCache(int orderId, dynamic responseData) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final cacheKey = '$_kOrderDetailCachePrefix$orderId';
      await sp.setString(cacheKey, jsonEncode(responseData));
    } catch (_) {
      // ignore cache failures
    }
  }

  @override
  Future<OrderDetailEntity?> getCachedOrderDetail(int orderId) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final cacheKey = '$_kOrderDetailCachePrefix$orderId';
      final raw = sp.getString(cacheKey);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final responseDto = OrderDetailResponseDto.fromJson(map);
      return responseDto.data?.toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<String>> reorder(int orderId, {bool? continueWithExisting, bool? addNewPouch}) {
    final requestBody = <String, dynamic>{};
    if (continueWithExisting != null) {
      requestBody['continue_with_existing'] = continueWithExisting;
    }
    if (addNewPouch != null) {
      requestBody['add_new_pouch'] = addNewPouch;
    }
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.reorder(orderId),
        requestBody: requestBody,
      ),
      parser: (response) {
        return response.data['message'] as String? ?? 'Order reordered successfully';
      },
    );
  }

  @override
  Future<Result<String>> submitOrderReview({
    required int orderId,
    required List<StoreReview> storeReviews,
    required DeliveryManReview deliveryManReview,
  }) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.submitOrderReview(orderId),
        requestBody: {
          'store_reviews': storeReviews.map((review) => review.toJson()).toList(),
          'delivery_man_review': deliveryManReview.toJson(),
        },
      ),
      parser: (response) {
        return response.data['message'] as String? ?? 'Review submitted successfully';
      },
    );
  }
}
