import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/features/orders/views/widgets/orders_content_widget.dart';

part 'widgets/history_orders_widget.dart';
part 'widgets/recent_orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const route = '/orders';
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AppNavigator().initContext = context;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int exitApp = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        exitApp++;
        //Utils.showToast(title: 'swipe twice to exit', state: UtilState.success);
        Alerts.showToast(
          L10n.tr().swipeTwiceToExit,
          error: false,
          isInfo: true,
          toastGravity: ToastGravity.CENTER,
        );
        Future.delayed(const Duration(seconds: 5), () {
          exitApp = 0;
          setState(() {});
        });
        if (exitApp == 2) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          showCart: false,
          title: L10n.tr().orders,
        ),
        body: const OrdersContentWidget(),
        //  Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 24),
        //   child: Column(
        //     spacing: 12,
        //     children: [
        //       MainTextField(
        //         controller: controller,
        //         height: 80,
        //         borderRadius: 64,
        //         hintText: L10n.tr().searchForStoresItemsAndCAtegories,
        //         bgColor: Colors.transparent,
        //         prefix: const Icon(Icons.search, color: Co.purple, size: 24),
        //       ),

        //       const _RecentOrders(),
        //       const Expanded(child: _HistoryOrdersWidget()),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
