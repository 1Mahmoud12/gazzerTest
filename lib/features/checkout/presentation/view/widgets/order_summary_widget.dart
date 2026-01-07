import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dashed_border.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key});

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  double? _lastTotal;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutStates>(
      buildWhen: (previous, current) {
        // Rebuild on order summary states, but skip CardChange to prevent infinite loop
        return current is OrderSummaryLoading || current is OrderSummaryLoaded || current is OrderSummaryError;
      },
      listener: (context, state) {
        if (state is OrderSummaryError) {
          Alerts.showToast(state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        final orderSummary = cubit.orderSummary;

        if (state is OrderSummaryLoading) {
          return const Center(child: LoadingWidget());
        }

        if (state is OrderSummaryError) {
          // If we have cached data, show it; otherwise show error
          if (orderSummary == null) {
            return const SizedBox.shrink();
          }
        }

        // If no order summary data, don't show widget
        if (orderSummary == null) {
          return const SizedBox.shrink();
        }

        if (orderSummary.subtotal == 0) {
          return const SizedBox.shrink();
        }

        // Get voucher discount from API
        final voucherFormatted =
            '(${orderSummary.voucher?.discountValue} ${(orderSummary.voucher?.discountType ?? '').contains('percentage') ? '%' : ''}) -${orderSummary.voucherDiscount}';

        final finalTotal = orderSummary.total;
        // Only update if the total has changed to avoid infinite rebuilds
        if (_lastTotal != finalTotal) {
          _lastTotal = finalTotal;
          cubit.addFinalTotal(finalTotal);
        }

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Co.purple.withOpacityNew(0.1)),
          child: Column(
            children: [
              if (orderSummary.subtotal != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(title: L10n.tr().grossAmount, value: orderSummary.subtotal),
                ),
              if (orderSummary.discount != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(title: L10n.tr().discount, value: orderSummary.discount, discount: true),
                ),
              if (orderSummary.deliveryFee != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(title: L10n.tr().deliveryFee, value: orderSummary.deliveryFee),
                ),
              if (orderSummary.serviceFee != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(title: L10n.tr().serviceFee, value: orderSummary.serviceFee),
                ),

              if (orderSummary.voucher != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(
                    title: L10n.tr().totalBeforeCode,
                    value: orderSummary.subtotal + orderSummary.deliveryFee + orderSummary.serviceFee - orderSummary.discount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ItemSummary(title: L10n.tr().promoCode, value: 0, discount: true, formattedValue: voucherFormatted),
                ),
              ],

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: DashedBorder(width: 10, gap: 8, color: Co.gryPrimary, thickness: 1.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(L10n.tr().total, style: TStyle.robotBlackSubTitle(), overflow: TextOverflow.ellipsis, maxLines: 1),
                          ),
                          const HorizontalSpacing(2),
                          Text(' (${L10n.tr().amountToPay}) ', style: TStyle.robotBlackThin().copyWith(overflow: TextOverflow.ellipsis), maxLines: 1),
                        ],
                      ),
                    ),
                    const HorizontalSpacing(12),
                    Text(
                      Helpers.getProperPrice(finalTotal),
                      style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple, fontWeight: TStyle.semi),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        Text(
          title,
          style: total ? TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold, color: Co.purple) : TStyle.robotBlackMedium(),
        ),
        Text(valueText, style: total ? TStyle.robotBlackRegular().copyWith(color: Co.purple) : TStyle.robotBlackMedium()),
      ],
    );
  }
}
