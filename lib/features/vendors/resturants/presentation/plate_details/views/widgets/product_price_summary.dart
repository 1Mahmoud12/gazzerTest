import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainBtn;
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/increment_widget.dart';

class ProductPriceSummary extends StatelessWidget {
  const ProductPriceSummary({
    super.key,
    required this.onChangeQuantity,
    required this.price,
    required this.onsubmit,
    required this.quantity,
    required this.isLoading,
    this.isUpdatingCart = false,
    this.maxQuantity,
  });

  final Function({required bool isAdding}) onChangeQuantity;
  final num price;
  final int quantity;
  final Future Function() onsubmit;
  final bool isLoading;
  final bool isUpdatingCart;
  final int? maxQuantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: IncrementWidget(
                  initVal: quantity,
                  onChanged: (isAdding) => onChangeQuantity(isAdding: isAdding),
                  isIncrementDisabled: maxQuantity != null && quantity >= maxQuantity!,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: MainBtn(
                  onPressed: () async {
                    if (Session().client == null) {
                      return Alerts.showToast(L10n.tr().pleaseLoginToUseCart, isInfo: true);
                    }
                    await onsubmit();
                  },
                  isLoading: isLoading,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(_getButtonText(context), style: context.style16500.copyWith(color: Co.white)),
                        const Spacer(),
                        Text(Helpers.getProperPrice(price), style: context.style16500.copyWith(color: Co.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getButtonText(BuildContext context) {
    if (isUpdatingCart) {
      return L10n.tr().updateCart;
    }

    try {
      final cubit = context.read<AddToCartCubit>();
      if (cubit.cartItem?.cartId != null) {
        return L10n.tr().updateCart;
      }
    } catch (_) {
      // Provider not available; default to add to cart
    }

    return L10n.tr().addItems;
  }
}
