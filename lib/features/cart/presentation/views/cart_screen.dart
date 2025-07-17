import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_summary_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/vendor_cart_products_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const route = '/cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: Fakers.fakeVendors.length + 1,
              separatorBuilder: (context, index) => const VerticalSpacing(24),
              // const Divider(indent: 16, color: Colors.black38, endIndent: 16, height: 33),
              itemBuilder: (context, index) {
                if (index == Fakers.fakeVendors.length) {
                  return const CartSummaryWidget();
                }
                return VendorCartProductsItem(vendor: Fakers.fakeVendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
