import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_state.dart';
import 'package:gazzer/features/orders/views/order_details_screen.dart';
import 'package:gazzer/features/orders/views/widgets/orders_list_widget.dart';
import 'package:go_router/go_router.dart';

class OrdersContentWidget extends StatefulWidget {
  const OrdersContentWidget({
    super.key,
    this.shouldRefreshAndOpenFirstOrder = false,
  });

  final bool shouldRefreshAndOpenFirstOrder;

  @override
  State<OrdersContentWidget> createState() => _OrdersContentWidgetState();
}

class _OrdersContentWidgetState extends State<OrdersContentWidget> {
  bool _hasNavigatedToFirstOrder = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(di.get()),
      child: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            Alerts.showToast(state.message, error: true);
          }

          // When orders are loaded and we need to open first order (only once)
          if (widget.shouldRefreshAndOpenFirstOrder && !_hasNavigatedToFirstOrder && state is OrdersLoaded) {
            final orders = state.orders;
            if (orders.isNotEmpty) {
              _hasNavigatedToFirstOrder = true;
              // Navigate to first order details
              final firstOrderId = int.tryParse(orders.first.orderId) ?? 0;
              if (firstOrderId > 0 && context.mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    context.push(OrderDetailsScreen.route, extra: firstOrderId);
                  }
                });
              }
            }
          }
        },
        child: OrdersContentWidgetChild(
          shouldRefreshAndOpenFirstOrder: widget.shouldRefreshAndOpenFirstOrder,
        ),
      ),
    );
  }
}

class OrdersContentWidgetChild extends StatefulWidget {
  const OrdersContentWidgetChild({
    super.key,
    required this.shouldRefreshAndOpenFirstOrder,
  });

  final bool shouldRefreshAndOpenFirstOrder;

  @override
  State<OrdersContentWidgetChild> createState() => _OrdersContentWidgetChildState();
}

class _OrdersContentWidgetChildState extends State<OrdersContentWidgetChild> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.shouldRefreshAndOpenFirstOrder) {
        // Refresh orders
        context.read<OrdersCubit>().loadOrders(refresh: true);
      } else {
        // Normal load
        context.read<OrdersCubit>().loadOrders();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const OrdersListWidget();
  }
}
