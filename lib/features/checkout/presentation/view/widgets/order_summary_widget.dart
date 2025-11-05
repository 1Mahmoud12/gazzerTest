import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_states.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key});

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      buildWhen: (previous, current) => current is FullCartStates,
      builder: (context, state) {
        if (state is! FullCartStates || state.summary.subTotal == 0) {
          return const SizedBox.shrink();
        }
        return BlocBuilder<VouchersCubit, VouchersStates>(
          builder: (context, vState) {
            final baseTotal = state.summary.total.toDouble();
            double voucherDeduction = 0.0;
            String? voucherFormatted;

            if (vState is VoucherApplied) {
              final isPercent = vState.discountType.toLowerCase().contains('percent');
              if (isPercent) {
                voucherDeduction = baseTotal * (vState.discountAmount / 100.0);
                voucherFormatted = '- ${vState.discountAmount.toStringAsFixed(0)}%';
              } else {
                voucherDeduction = vState.discountAmount;
                voucherFormatted = '- ${Helpers.getProperPrice(vState.discountAmount)}';
              }
            }

            final finalTotal = (baseTotal - voucherDeduction).clamp(0.0, double.infinity);
            context.read<CheckoutCubit>().addFinalTotal(finalTotal);
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Co.purple.withOpacityNew(0.1),
              ),
              child: Column(
                children: [
                  ItemSummary(title: L10n.tr().subTotal, value: state.summary.subTotal),
                  const SizedBox(height: 8),
                  ItemSummary(title: L10n.tr().discount, value: state.summary.discount, discount: true),
                  const SizedBox(height: 8),
                  ItemSummary(title: L10n.tr().deliveryFee, value: state.summary.deliveryFee),
                  const SizedBox(height: 8),
                  ItemSummary(title: L10n.tr().serviceFee, value: state.summary.serviceFee),
                  const SizedBox(height: 8),

                  if (voucherFormatted != null) ...[
                    ItemSummary(title: L10n.tr().totalBeforeCode, value: state.summary.total),
                    const SizedBox(height: 8),
                    ItemSummary(
                      title: L10n.tr().promoCode,
                      value: voucherDeduction,
                      discount: true,
                      formattedValue: voucherFormatted,
                    ),
                    const SizedBox(height: 8),
                  ],
                  ItemSummary(title: L10n.tr().total, value: finalTotal, total: true),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ItemSummary extends StatelessWidget {
  final String title;
  final num value;
  final bool discount;
  final bool total;
  final String? formattedValue;

  const ItemSummary({super.key, required this.title, required this.value, this.discount = false, this.total = false, this.formattedValue});

  @override
  Widget build(BuildContext context) {
    final valueText = formattedValue ?? '${discount && value != 0 ? '-' : ''} ${Helpers.getProperPrice(value)}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: total ? TStyle.burbleBold(16) : TStyle.blackBold(14)),
        Text(valueText, style: total ? TStyle.burbleBold(16) : TStyle.blackBold(14)),
      ],
    );
  }
}
