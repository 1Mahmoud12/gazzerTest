import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing;
import 'package:gazzer/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        final selectedMethod = cubit.selectedPaymentMethod;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.tr().choosePaymentMethod,
              style: TStyle.primaryBold(18),
            ),
            const VerticalSpacing(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Co.purple.withOpacityNew(0.05),
              ),
              child: Column(
                children: [
                  _PaymentMethodItem(
                    method: PaymentMethod.cashOnDelivery,
                    title: L10n.tr().cashOnDelivery,
                    icon: Assets.cashOnDelivery,
                    isSelected: selectedMethod == PaymentMethod.cashOnDelivery,
                    onTap: () => cubit.selectPaymentMethod(PaymentMethod.cashOnDelivery),
                  ),
                  const SizedBox(height: 12),
                  _PaymentMethodItem(
                    method: PaymentMethod.creditDebitCard,
                    title: L10n.tr().creditCard,
                    icon: Assets.creditCard,
                    isSelected: selectedMethod == PaymentMethod.creditDebitCard,
                    onTap: () => cubit.selectPaymentMethod(PaymentMethod.creditDebitCard),
                  ),
                  const SizedBox(height: 12),
                  _PaymentMethodItem(
                    method: PaymentMethod.gazzerWallet,
                    title: L10n.tr().gazzarWallet,
                    icon: Assets.wallet,
                    isSelected: selectedMethod == PaymentMethod.gazzerWallet,
                    onTap: () => cubit.selectPaymentMethod(PaymentMethod.gazzerWallet),
                    balance: cubit.walletBalance,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PaymentMethodItem extends StatelessWidget {
  const _PaymentMethodItem({
    required this.method,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.balance,
  });

  final PaymentMethod method;
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? balance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Co.purple : Colors.transparent,
            width: 1,
          ),
          color: Co.bg,
        ),
        child: Row(
          children: [
            // Radio button
            GradientRadioBtn(
              isSelected: isSelected,
              size: 4,
            ),

            const SizedBox(width: 12),
            // Icon
            SvgPicture.asset(
              icon,
            ),
            const SizedBox(width: 12),
            // Title and balance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TStyle.blackBold(16),
                  ),
                  if (balance != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${L10n.tr().balance} ${Helpers.getProperPrice(balance!)}',
                      style: TStyle.greyRegular(12),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
