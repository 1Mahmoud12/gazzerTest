import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/cart/domain/entities/cart_ordered_with_entity.dart';

class CartOrderedWithWidget extends StatelessWidget {
  const CartOrderedWithWidget({super.key, required this.orderedWith});

  final CartOrderedWithEntity orderedWith;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${orderedWith.name}: ',
        style: TStyle.robotBlackThin(),
        children: [
          TextSpan(
            text: 'x${orderedWith.quantity} ',
            style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey, fontWeight: TStyle.medium),
          ),
          TextSpan(
            text: '(${orderedWith.totalPrice.toStringAsFixed(2)} ${L10n.tr().egp})',
            style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey, fontWeight: TStyle.medium),
          ),
        ],
      ),
    );
  }
}
