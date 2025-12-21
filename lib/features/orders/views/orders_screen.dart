import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/orders/views/widgets/orders_content_widget.dart';
import 'package:gazzer/main.dart';
import 'package:go_router/go_router.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, this.shouldRefreshAndOpenFirstOrder = false, this.showGetHelpInsteadOfReorder = false});
  static const route = '/orders';

  final bool shouldRefreshAndOpenFirstOrder;
  final bool showGetHelpInsteadOfReorder;

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
    return Scaffold(
      appBar: MainAppBar(
        title: L10n.tr().orders,
        onBack: () {
          logger.d('asd');
          context.go(HomeScreen.route);
        },
      ),
      body: Session().client == null
          ? UnAuthComponent(msg: L10n.tr().pleaseLoginToUseFavorites)
          : OrdersContentWidget(
              shouldRefreshAndOpenFirstOrder: widget.shouldRefreshAndOpenFirstOrder,
              showGetHelpInsteadOfReorder: widget.showGetHelpInsteadOfReorder,
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
    );
  }
}
