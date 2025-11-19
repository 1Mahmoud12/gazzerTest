import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dashed_border.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
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
            final voucherCubit = context.read<VouchersCubit>();
            if (voucherCubit.selectedDiscountType != null &&
                voucherCubit.selectedDiscountAmount != null &&
                voucherCubit.selectedDiscountType!.isNotEmpty &&
                voucherCubit.selectedDiscountAmount! > 0 &&
                voucherCubit.selectedVoucherCode != null) {
              final isPercent = voucherCubit.selectedDiscountType!.toLowerCase().contains(
                'percent',
              );
              if (isPercent) {
                voucherDeduction = baseTotal * (voucherCubit.selectedDiscountAmount! / 100.0);
                voucherFormatted =
                    '- ${voucherCubit.selectedDiscountAmount!.toStringAsFixed(0)}% (${(baseTotal * (voucherCubit.selectedDiscountAmount! / 100.0)).toStringAsFixed(2)}${L10n.tr().egp})';
              } else {
                voucherDeduction = voucherCubit.selectedDiscountAmount!;
                voucherFormatted = '- ${Helpers.getProperPrice(voucherCubit.selectedDiscountAmount!)}';
              }
            }

            final finalTotal = (baseTotal - voucherDeduction).clamp(
              0.0,
              double.infinity,
            );
            context.read<CheckoutCubit>().addFinalTotal(finalTotal);
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Co.purple.withOpacityNew(0.1),
              ),
              child: Column(
                children: [
                  if (state.summary.subTotal != 0)
                    ItemSummary(
                      title: L10n.tr().grossAmount,
                      value: state.summary.subTotal,
                    ),
                  const SizedBox(height: 8),
                  if (state.summary.discount != 0)
                    ItemSummary(
                      title: L10n.tr().discount,
                      value: state.summary.discount,
                      discount: true,
                    ),
                  const SizedBox(height: 8),
                  if (state.summary.deliveryFee != 0)
                    ItemSummary(
                      title: L10n.tr().deliveryFee,
                      value: state.summary.deliveryFee,
                    ),
                  const SizedBox(height: 8),
                  if (state.summary.serviceFee != 0)
                    ItemSummary(
                      title: L10n.tr().serviceFee,
                      value: state.summary.serviceFee,
                    ),
                  const SizedBox(height: 8),

                  if (voucherFormatted != null) ...[
                    ItemSummary(
                      title: L10n.tr().totalBeforeCode,
                      value: state.summary.total,
                    ),
                    const SizedBox(height: 8),
                    ItemSummary(
                      title: L10n.tr().promoCode,
                      value: voucherDeduction,
                      discount: true,
                      formattedValue: voucherFormatted,
                    ),
                    const SizedBox(height: 8),
                  ],
                  const DashedBorder(
                    width: 10,
                    gap: 8,
                    color: Co.gryPrimary,
                    thickness: 1.5,
                  ),
                  const VerticalSpacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                L10n.tr().total,
                                style: TStyle.blackSemi(20, font: FFamily.roboto),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const HorizontalSpacing(2),
                            Text(
                              ' (${L10n.tr().amountToPay}) ',
                              style: TStyle.blackBold(12, font: FFamily.roboto).copyWith(overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      const HorizontalSpacing(12),
                      Text(Helpers.getProperPrice(finalTotal), style: TStyle.burbleSemi(20, font: FFamily.roboto)),
                    ],
                  ),
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

  const ItemSummary({
    super.key,
    required this.title,
    required this.value,
    this.discount = false,
    this.total = false,
    this.formattedValue,
  });

  @override
  Widget build(BuildContext context) {
    final valueText = formattedValue ?? '${discount && value != 0 ? '-' : ''} ${Helpers.getProperPrice(value)}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: total ? TStyle.burbleSemi(16, font: FFamily.roboto) : TStyle.blackSemi(16, font: FFamily.roboto),
        ),
        Text(
          valueText,
          style: total ? TStyle.burbleBold(18, font: FFamily.roboto) : TStyle.blackSemi(18, font: FFamily.roboto),
        ),
      ],
    );
  }
}
