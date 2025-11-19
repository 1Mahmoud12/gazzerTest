import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_state.dart';
import 'package:gazzer/features/orders/views/widgets/orders_list_widget.dart';

class OrdersContentWidget extends StatelessWidget {
  const OrdersContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(di.get())..loadOrders(),
      child: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            Alerts.showToast(state.message, error: true);
          }
        },
        child: const OrdersListWidget(),
      ),
    );
  }
}
