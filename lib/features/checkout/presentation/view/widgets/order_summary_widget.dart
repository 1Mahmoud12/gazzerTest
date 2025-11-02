import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({
    super.key,
  });

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  @override
  void initState() {
    super.initState();
    // Load cart when entering the screen
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
              const SizedBox(height: 12),
              ItemSummary(
                title: L10n.tr().total,
                value: state.summary.total,
                total: true,
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

  const ItemSummary({
    super.key,
    required this.title,
    required this.value,
    this.discount = false,
    this.total = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: total ? TStyle.burbleBold(16) : TStyle.blackBold(14),
        ),
        Text(
          '${discount && value != 0 ? '-' : ''} ${Helpers.getProperPrice(value)}',
          style: total ? TStyle.burbleBold(16) : TStyle.blackBold(14),
        ),
      ],
    );
  }
}
