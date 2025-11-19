import 'dart:convert';

import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/data/dtos/orders_response_dto.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kOrdersCache = 'client_orders_json';
const _kOrdersTs = 'client_orders_timestamp';

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
}
