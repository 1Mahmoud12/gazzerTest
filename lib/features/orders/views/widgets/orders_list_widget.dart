import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_state.dart';
import 'package:gazzer/features/orders/views/order_details_screen.dart';
import 'package:gazzer/features/orders/views/widgets/order_card_widget.dart';
import 'package:go_router/go_router.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({super.key, this.showGetHelpInsteadOfReorder = false});

  final bool showGetHelpInsteadOfReorder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrdersError) {
          // Error handling is done in parent
        }
      },
      builder: (context, state) {
        final orders = state is OrdersLoaded
            ? state.orders
            : state is OrdersLoading
            ? state.orders
            : state is OrdersError
            ? state.orders
            : <OrderItemEntity>[];

        if (orders.isEmpty && state is! OrdersLoading) {
          return Center(
            child: Text(L10n.tr().noData, style: context.style16400.copyWith(color: Co.purple)),
          );
        }

        if (orders.isEmpty && state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasMore = state is OrdersLoaded
            ? state.hasMore
            : state is OrdersLoading
            ? state.hasMore
            : false;
        final isLoadingMore = state is OrdersLoading;
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<OrdersCubit>().loadOrders(refresh: true);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),

            itemCount: orders.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              // Loading more indicator as last item
              if (index == orders.length) {
                // Trigger load more
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<OrdersCubit>().loadMore();
                });
                return _LoadingMoreItem(isLoading: isLoadingMore);
              }

              final order = orders[index];

              return OrderCardWidget(
                order: order,
                showGetHelpInsteadOfReorder: showGetHelpInsteadOfReorder,
                onViewDetails: () async {
                  final orderId = int.tryParse(order.orderId) ?? 0;
                  await context.push(OrderDetailsScreen.route, extra: orderId);
                  // Reload orders from current page when coming back
                  if (context.mounted) {
                    await context.read<OrdersCubit>().reloadCurrentPage();
                  }
                },
                onRatingChanged: (rating) {
                  // Handle rating submission
                  // TODO: Implement rating API call
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _LoadingMoreItem extends StatelessWidget {
  const _LoadingMoreItem({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    return const Center(
      child: Padding(padding: EdgeInsets.all(16.0), child: LoadingWidget()),
    );
  }
}
