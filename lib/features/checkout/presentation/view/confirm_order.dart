import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/order_summary_widget.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/payment_method_widget.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});
  static const route = '/order-confirm';

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> with AutomaticKeepAliveClientMixin<ConfirmOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckoutCubit>().loadCheckoutData();
      context.read<CartCubit>().loadCart();
      context.read<CheckoutCubit>().loadOrderSummary(voucher: context.read<CheckoutCubit>().voucherCode);
      context.read<CheckoutCubit>().selectCard(null);
      context.read<CheckoutCubit>().selectPaymentMethod(PaymentMethod.cashOnDelivery);
    });
  }

  @override
  bool get wantKeepAlive => true; // 👈 keeps state alive

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MainAppBar(title: L10n.tr().confirmOrder),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const OrderSummaryWidget(),
          const VerticalSpacing(16),
          const PaymentMethodWidget(),
          const VerticalSpacing(16), // Space for bottom button
          // Place Order Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              top: false,
              child: BlocBuilder<CheckoutCubit, CheckoutStates>(
                builder: (context, state) {
                  final cubit = context.read<CheckoutCubit>();
                  return MainBtn(
                    onPressed: () {
                      cubit.placeOrder(context);
                      // TODO: Navigate to success screen or show loading
                    },
                    text: L10n.tr().placeOrder,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
