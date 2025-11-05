import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show DashedBorder, HorizontalSpacing, MainBtn, VerticalSpacing;
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      buildWhen: (previous, current) => current is FullCartStates,
      builder: (context, state) {
        if (state is! FullCartStates || state.summary.subTotal == 0) return const SizedBox.shrink();
        return Skeletonizer(
          enabled: state is FullCartLoading,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
              gradient: Grad().radialGradient,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
                gradient: Grad().linearGradient,
              ),
              child: SafeArea(
                top: false,
                right: false,
                left: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        L10n.tr().orderSummary,
                        style: TStyle.secondaryBold(16),
                      ),
                      const VerticalSpacing(6),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(L10n.tr().subTotal, style: TStyle.secondarySemi(16)),
                                    const HorizontalSpacing(6),
                                    Text(
                                      Helpers.getProperPrice(state.summary.subTotal),
                                      style: TStyle.secondarySemi(12),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(L10n.tr().serviceFee, style: TStyle.secondarySemi(12)),
                                    const HorizontalSpacing(6),
                                    Text(
                                      Helpers.getProperPrice(state.summary.serviceFee),
                                      style: TStyle.secondarySemi(12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(L10n.tr().discount, style: TStyle.secondarySemi(12)),
                                    const HorizontalSpacing(12),
                                    Text(
                                      Helpers.getProperPrice(state.summary.discount),
                                      style: TStyle.secondarySemi(12),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(L10n.tr().deliveryFee, style: TStyle.secondarySemi(12)),
                                    const HorizontalSpacing(12),
                                    Text(
                                      Helpers.getProperPrice(state.summary.deliveryFee),
                                      style: TStyle.secondarySemi(12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(8),
                      const DashedBorder(width: 6, gap: 6, color: Co.secondary),
                      const VerticalSpacing(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(L10n.tr().total, style: TStyle.secondaryBold(13)),
                          const HorizontalSpacing(12),
                          Text(Helpers.getProperPrice(state.summary.total), style: TStyle.secondaryBold(13)),
                        ],
                      ),
                      const VerticalSpacing(8),
                      Row(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: AppConst.defaultInnerBorderRadius,
                                border: GradientBoxBorder(
                                  gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: MainBtn(
                                  onPressed: () {
                                    context.go(HomeScreen.route);
                                  },
                                  text: L10n.tr().addItems,
                                  padding: const EdgeInsets.symmetric(vertical: 3),
                                  width: double.infinity,
                                  height: 0,
                                  textStyle: TStyle.secondaryBold(12),
                                  bgColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: AppConst.defaultInnerBorderRadius,
                                border: GradientBoxBorder(
                                  gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: MainBtn(
                                  onPressed: () {
                                    context.push(
                                      ConfirmOrderScreen.route,
                                    );
                                  },
                                  disabledColor: Co.grey.withAlpha(80),
                                  isEnabled: state.isCartValid,
                                  text: L10n.tr().checkout,
                                  textStyle: TStyle.secondaryBold(12),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 3),
                                  bgColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
