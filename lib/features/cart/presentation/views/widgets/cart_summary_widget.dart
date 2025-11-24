import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show DashedBorder, HorizontalSpacing, VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10n.tr().orderSummary,
                  style: TStyle.blackMedium(22, font: FFamily.roboto),
                ),
                const VerticalSpacing(6),

                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Co.purple100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.summary.subTotal > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().grossAmount, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(6),
                                Text(
                                  Helpers.getProperPrice(state.summary.subTotal),
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),

                        if (state.summary.discount > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().itemsDiscount, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(12),
                                Text(
                                  '-${Helpers.getProperPrice(state.summary.discount)}',
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),
                        if (state.summary.tax > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().vatAmount, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(12),
                                Text(
                                  Helpers.getProperPrice(state.summary.tax),
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),

                        if (state.summary.serviceFee > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().serviceFee, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(6),
                                Text(
                                  Helpers.getProperPrice(state.summary.serviceFee),
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),

                        if (state.summary.deliveryFee > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().deliveryFee, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(6),
                                Text(
                                  Helpers.getProperPrice(state.summary.deliveryFee),
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),

                        if (state.summary.deliveryFeeDiscount > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(L10n.tr().deliveryFeeDiscount, style: TStyle.blackSemi(16, font: FFamily.roboto)),
                                const HorizontalSpacing(6),
                                Text(
                                  Helpers.getProperPrice(state.summary.deliveryFeeDiscount),
                                  style: TStyle.blackSemi(18, font: FFamily.roboto),
                                ),
                              ],
                            ),
                          ),
                        const DashedBorder(
                          width: 10,
                          gap: 8,
                          color: Co.gryPrimary,
                          thickness: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
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
                              Text(Helpers.getProperPrice(state.summary.total), style: TStyle.burbleSemi(20, font: FFamily.roboto)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpacing(16),
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
                            text: L10n.tr().continueShopping,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            width: double.infinity,
                            height: 0,
                            borderColor: Co.purple,
                            textStyle: TStyle.blackRegular(16),
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
                              if (!state.isCartValid) {
                                Alerts.showToast(L10n.tr().needToAddAddressFirst);
                                return;
                              }
                              context.push(
                                ConfirmOrderScreen.route,
                              );
                            },
                            disabledColor: Co.grey.withAlpha(80),

                            text: L10n.tr().checkout,
                            textStyle: TStyle.whiteRegular(16),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            bgColor: Co.purple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
