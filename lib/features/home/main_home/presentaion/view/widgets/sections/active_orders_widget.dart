import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/home/homeViewAll/active_orders_widget/presentation/cubit/active_orders_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/active_orders_widget/presentation/cubit/active_orders_widget_states.dart';
import 'package:gazzer/features/orders/domain/entities/active_order_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/views/order_details_screen.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';
import 'package:gazzer/features/orders/views/widgets/order_card_widget.dart';
import 'package:go_router/go_router.dart';

class ActiveOrdersWidget extends StatelessWidget {
  const ActiveOrdersWidget({super.key});

  // Convert ActiveOrderEntity to OrderItemEntity for the card widget
  OrderItemEntity _convertToOrderItemEntity(ActiveOrderEntity activeOrder) {
    final vendors = activeOrder.vendorNames
        .map(
          (name) => OrderVendorEntity(
            id: 0, // Active orders API doesn't provide vendor IDs
            name: name,
            logo: '',
            image: '',
          ),
        )
        .toList();

    // Ensure there's always at least one vendor to prevent "No element" error
    if (vendors.isEmpty) {
      vendors.add(
        const OrderVendorEntity(
          id: 0,
          name: 'Vendor', // Default placeholder name
          logo: '',
          image: '',
        ),
      );
    }

    return OrderItemEntity(
      orderId: activeOrder.orderId,
      vendors: vendors,
      price: activeOrder.price,
      itemsCount: activeOrder.itemsCount,
      orderDate: activeOrder.arriveDate,
      status: activeOrder.status,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveOrdersWidgetCubit, ActiveOrdersWidgetStates>(
      buildWhen: (previous, current) {
        // Only rebuild if state type actually changed or orders changed
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is ActiveOrdersWidgetSuccessState && current is ActiveOrdersWidgetSuccessState) {
          return previous.orders != current.orders;
        }
        return false;
      },
      builder: (context, state) {
        if (state is ActiveOrdersWidgetSuccessState) {
          final activeOrders = state.orders;

          // Filter only active orders (not delivered or cancelled)
          final filteredOrders = activeOrders
              .where((order) => order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled)
              .toList();

          if (filteredOrders.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          return SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TitleWithMore(
                  title: L10n.tr().your_active_orders,
                  titleStyle: context.style20500.copyWith(color: Co.purple),
                  onPressed: () {
                    context.push(OrdersScreen.route);
                  },
                ),
              ),
              const VerticalSpacing(12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(filteredOrders.length, (index) {
                    final activeOrder = filteredOrders[index];
                    final order = _convertToOrderItemEntity(activeOrder);

                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * .9,
                      child: ActiveOrderCardWidget(
                        order: order,
                        estimatedTimeMinutes: activeOrder.remainingMinutes,
                        onViewDetails: () {
                          context.push(OrderDetailsScreen.route, extra: int.parse(activeOrder.orderId));
                        },
                        onTrackOrder: () {
                          context.push(OrderDetailsScreen.route, extra: int.parse(activeOrder.orderId));
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
        /* else if (state is ActiveOrdersWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is ActiveOrdersWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }*/
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
