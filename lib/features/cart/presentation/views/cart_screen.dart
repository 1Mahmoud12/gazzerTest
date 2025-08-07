import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_summary_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/vendor_cart_products_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const route = '/cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBus bus;
  @override
  void initState() {
    bus = di<CartBus>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bus.loadCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(isCartScreen: true),
      body: Column(
        children: [
          GradientText(
            text: L10n.tr().shippingCart,
            style: TStyle.blackBold(24),
            gradient: Grad().radialGradient.copyWith(radius: 2, center: Alignment.centerLeft),
          ),
          const VerticalSpacing(24),
          Expanded(
            child: StreamBuilder(
              stream: bus.getStream<GetCartEvents>(),
              builder: (context, snapshot) {
                if (snapshot.data is GetCartError) {
                  return FailureWidget(
                    message: "snapshot.data.data",
                    onRetry: () => bus.loadCart(),
                  );
                } else if (snapshot.data is GetCartLoading) {
                  return const Center(child: AdaptiveProgressIndicator());
                } else if (snapshot.data?.data.vendors.isNotEmpty != true) {
                  return Center(
                    child: Text(
                      L10n.tr().noData,
                      style: TStyle.primarySemi(16),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () {
                    return di<CartBus>().loadCart();
                  },
                  child: Skeletonizer(
                    enabled: snapshot.data is GetCartLoading,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: (snapshot.data?.data.vendors.length ?? 0),
                      separatorBuilder: (context, index) => const VerticalSpacing(24),
                      // const Divider(indent: 16, color: Colors.black38, endIndent: 16, height: 33),
                      itemBuilder: (context, index) {
                        return VendorCartProductsItem(cartVendor: snapshot.data!.data.vendors[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CartSummaryWidget(),
    );
  }
}
