import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/views/widgets/order_card_widget.dart';

class ActiveOrdersWidget extends StatelessWidget {
  const ActiveOrdersWidget({super.key});

  // Static data for active orders
  static List<OrderItemEntity> _getStaticActiveOrders() {
    return [
      // Order with time < 5 minutes (will show map snippet)
      OrderItemEntity(
        orderId: '123456',
        vendors: [OrderVendorEntity(id: 1, name: 'Vendor name', logo: 'https://via.placeholder.com/56', image: 'https://via.placeholder.com/56')],
        price: 234.0,
        itemsCount: 20,
        orderDate: DateTime.now(),
        status: OrderStatus.preparing,
      ),
      // Order with time >= 5 minutes (will show regular card)
      OrderItemEntity(
        orderId: '123457',
        vendors: [OrderVendorEntity(id: 2, name: 'Vendor name', logo: 'https://via.placeholder.com/56', image: 'https://via.placeholder.com/56')],
        price: 150.0,
        itemsCount: 15,
        orderDate: DateTime.now(),
        status: OrderStatus.preparing,
      ),
      // Another order with time < 5 minutes
      OrderItemEntity(
        orderId: '123458',
        vendors: [OrderVendorEntity(id: 3, name: 'Vendor name', logo: 'https://via.placeholder.com/56', image: 'https://via.placeholder.com/56')],
        price: 320.0,
        itemsCount: 25,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
      ),
    ];
  }

  // Static estimated times for each order
  static List<int?> _getEstimatedTimes() {
    return [
      3, // First order: 3 minutes (will show map)
      25, // Second order: 25 minutes (regular card)
      2, // Third order: 2 minutes (will show map)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final activeOrders = _getStaticActiveOrders();
    final estimatedTimes = _getEstimatedTimes();

    // Filter only active orders (not delivered or cancelled)
    final filteredOrders = activeOrders.where((order) => order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled).toList();

    if (filteredOrders.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TitleWithMore(
            title: 'Your Active Orders',
            titleStyle: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
            onPressed: () {
              // Navigate to all orders screen if needed
              // context.push(OrdersScreen.route);
            },
          ),
        ),
        const VerticalSpacing(12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(filteredOrders.length, (index) {
              final order = filteredOrders[index];
              // Find the original index in activeOrders to get corresponding time
              final originalIndex = activeOrders.indexOf(order);
              final estimatedTime = originalIndex >= 0 && originalIndex < estimatedTimes.length ? estimatedTimes[originalIndex] : null;

              return SizedBox(
                width: MediaQuery.sizeOf(context).width * .9,
                child: ActiveOrderCardWidget(
                  order: order,
                  estimatedTimeMinutes: estimatedTime,
                  onViewDetails: () {
                    // Navigate to order details
                    // context.push(OrderDetailsRoute(orderId: int.parse(order.orderId)).location);
                  },
                  onTrackOrder: () {
                    // Navigate to track order
                    // context.push(OrderDetailsRoute(orderId: int.parse(order.orderId)).location);
                  },
                ),
              );
            }),
          ),
        ),
        const VerticalSpacing(24),
      ]),
    );
  }
}
