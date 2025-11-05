import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/order_summary_widget.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/payment_method_widget.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_widget.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});
  static const route = '/order-confirm';

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CheckoutCubit>().loadCheckoutData();
    context.read<CheckoutCubit>().applyVoucher(null);
    context.read<CheckoutCubit>().selectPaymentMethod(PaymentMethod.cashOnDelivery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          text: L10n.tr().confirmOrder,
          style: TStyle.blackBold(18),
        ),
      ),
      body: ListView(
        padding: AppConst.defaultPadding,
        children: [
          const VoucherWidget(),
          const VerticalSpacing(20),
          const OrderSummaryWidget(),
          const VerticalSpacing(20),
          const PaymentMethodWidget(),
          const VerticalSpacing(20), // Space for bottom button
          // Place Order Button
          SafeArea(
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
                  bgColor: Co.secondary,
                  textStyle: TStyle.blackBold(16),
                  width: double.infinity,
                  height: 50,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
