import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/features/orders/views/widgets/orders_content_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
    this.shouldRefreshAndOpenFirstOrder = false,
  });
  static const route = '/orders';

  final bool shouldRefreshAndOpenFirstOrder;

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
        body: OrdersContentWidget(
          shouldRefreshAndOpenFirstOrder: widget.shouldRefreshAndOpenFirstOrder,
        ),
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

        //       const Expanded(child: _HistoryOrdersWidget()),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
