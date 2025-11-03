import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/view/card_details_screen.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_alert_widget.dart';
import 'package:go_router/go_router.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        final selectedMethod = cubit.selectedPaymentMethod;
        final walletBalance = cubit.walletBalance;
        final availablePoints = cubit.availablePoints;
        final cards = cubit.cards;

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
                    onTap: () => cubit.selectPaymentMethod(
                      PaymentMethod.creditDebitCard,
                    ),
                  ),
                  if (selectedMethod == PaymentMethod.creditDebitCard) ...[
                    const SizedBox(height: 12),
                    ...cards.map(
                      (card) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _CardItem(
                          card: card,
                          isSelected: (cubit.selectedCard == null) ? card.isDefault : cubit.selectedCard == card,
                          onTap: () {
                            cubit.selectCard(card);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _AddCardItem(
                      onTap: () async {
                        await context.push(CardDetailsScreen.route);
                        if (context.mounted) {
                          context.read<CheckoutCubit>().loadCheckoutData();
                        }
                      },
                    ),
                  ],
                  const SizedBox(height: 12),
                  _PaymentMethodItem(
                    method: PaymentMethod.gazzerWallet,
                    title: L10n.tr().gazzarWallet,
                    icon: Assets.wallet,
                    isSelected: selectedMethod == PaymentMethod.gazzerWallet,
                    onTap: () {
                      cubit.selectPaymentMethod(PaymentMethod.gazzerWallet);
                      if (walletBalance <= 0) {
                        voucherAlert(
                          title: L10n.tr().insufficientWalletBalance,
                          context: context,
                        );
                      }
                    },
                    balance: walletBalance,
                    availablePoints: availablePoints,
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
    this.availablePoints,
  });

  final PaymentMethod method;
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? balance;
  final int? availablePoints;

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
            GradientRadioBtn(
              isSelected: isSelected,
              size: 4,
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              icon,
            ),
            const SizedBox(width: 12),
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
                  if (availablePoints != null && availablePoints! >= 0) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${L10n.tr().availablePoints}: $availablePoints',
                            style: TStyle.greyRegular(12),
                          ),
                        ),
                        if (method == PaymentMethod.gazzerWallet && (availablePoints ?? 0) > 0)
                          TextButton(
                            onPressed: () => _showConvertPointsSheet(
                              context,
                              availablePoints!,
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              minimumSize: Size.zero,
                            ),
                            child: Text(
                              L10n.tr().convert,
                              style: TStyle.primaryBold(12),
                            ),
                          ),
                      ],
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

void _showConvertPointsSheet(BuildContext context, int availablePoints) {
  final controller = TextEditingController(text: availablePoints.toString());
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().convertPoints, style: TStyle.blackBold(16)),
            const SizedBox(height: 8),
            MainTextField(
              controller: controller,
              keyboardType: TextInputType.number,
              hintText: L10n.tr().enterPoints,
              inputFormatters: FilteringTextInputFormatter.digitsOnly,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: MainBtn(
                onPressed: () async {
                  final text = controller.text.trim();
                  final points = int.tryParse(text) ?? 0;
                  if (points <= 0) {
                    voucherAlert(title: L10n.tr().invalidPoints, context: ctx);
                    return;
                  }
                  if (points > availablePoints) {
                    voucherAlert(
                      title: L10n.tr().insufficientPoints,
                      context: ctx,
                    );
                    return;
                  }
                  await context.read<CheckoutCubit>().convertPoints(points);
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                text: L10n.tr().convert,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.card,
    required this.isSelected,
    required this.onTap,
  });

  final CardEntity card;
  final bool isSelected;
  final VoidCallback onTap;

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
            GradientRadioBtn(
              isSelected: isSelected,
              size: 4,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.cardNumber,
                    style: TStyle.blackBold(16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${card.cardHolderName} • ${card.formattedExpiry}',
                    style: TStyle.greyRegular(12),
                  ),
                ],
              ),
            ),
            if (card.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Co.purple.withOpacityNew(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  L10n.tr().defaultCard,
                  style: TStyle.primaryBold(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddCardItem extends StatelessWidget {
  const _AddCardItem({required this.onTap});

  final VoidCallback onTap;

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
            color: Co.purple.withOpacityNew(0.3),
            width: 1,
            style: BorderStyle.solid,
          ),
          color: Co.purple.withOpacityNew(0.05),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: Co.purple,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              L10n.tr().addCard,
              style: TStyle.primaryBold(16),
            ),
          ],
        ),
      ),
    );
  }
}
