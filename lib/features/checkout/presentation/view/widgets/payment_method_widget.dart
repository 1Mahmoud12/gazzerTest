import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_alert_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_screen.dart';
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
                  if (!Platform.isAndroid) ...[
                    const SizedBox(height: 12),
                    _PaymentMethodItem(
                      method: PaymentMethod.applePay,
                      title: L10n.tr().walletApplePay,
                      icon: Assets.applePayIc,
                      isSelected: selectedMethod == PaymentMethod.applePay,
                      onTap: () => Alerts.showToast(L10n.tr().comingSoon, error: false),
                    ),
                  ],
                  const SizedBox(height: 12),
                  if (cubit.timeSlots == null)
                    _PaymentMethodItem(
                      method: PaymentMethod.wallet,
                      title: L10n.tr().wallet,
                      icon: Assets.wallet,
                      isSelected:
                          selectedMethod == PaymentMethod.wallet ||
                          (selectedMethod == PaymentMethod.gazzerWallet && cubit.remainingPaymentMethod == PaymentMethod.wallet),
                      walletPhoneNumber: cubit.walletPhoneNumber,
                      onTap: () async {
                        String number = '';

                        await _showWalletNumberSheet(
                          context,
                        ).then((value) {
                          number = value ?? '';
                        });
                        if (number.isNotEmpty) {
                          cubit.selectPaymentMethod(PaymentMethod.wallet);

                          cubit.setWalletInfo(
                            providerName: 'e_wallet',
                            phoneNumber: number,
                          );
                        }
                      },
                    ),

                  if (cubit.timeSlots == null) const SizedBox(height: 12),
                  if (cubit.timeSlots == null)
                    _PaymentMethodItem(
                      method: PaymentMethod.creditDebitCard,
                      title: L10n.tr().creditCard,
                      icon: Assets.creditCard,
                      isSelected:
                          selectedMethod == PaymentMethod.creditDebitCard ||
                          (selectedMethod == PaymentMethod.gazzerWallet && cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard),
                      onTap: () {
                        cubit.selectPaymentMethod(
                          PaymentMethod.creditDebitCard,
                        );
                        if (cards.isNotEmpty) {
                          cubit.selectCard(cards.first);
                        }
                      },
                    ),
                  if (selectedMethod == PaymentMethod.creditDebitCard ||
                      (selectedMethod == PaymentMethod.gazzerWallet && cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard)) ...[
                    const SizedBox(height: 12),
                    if (cards.isNotEmpty)
                      ...cards.map(
                        (card) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CardItem(
                            card: card,
                            isSelected: (cubit.selectedCard == null) ? card.isDefault : cubit.selectedCard == card && cubit.selectedCard?.id != -1,
                            onTap: () {
                              cubit.selectCard(card);
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (context) {
                        return _CardItem(
                          onTap: () async {
                            cubit.selectCard(null);
                          },

                          card: CardEntity(
                            id: -1,
                            cardNumber: L10n.tr().walletPayWithAnotherCard,
                            cardHolderName: '',
                            expiryMonth: 1,
                            expiryYear: 2025,
                            isDefault: false,
                          ),
                          isSelected: cubit.selectedCard == null,
                        );
                      },
                    ),
                  ],
                  if (cubit.timeSlots == null) const SizedBox(height: 12),

                  _PaymentMethodItem(
                    method: PaymentMethod.gazzerWallet,
                    title: L10n.tr().gazzarWallet,
                    icon: Assets.wallet,
                    isSelected: selectedMethod == PaymentMethod.gazzerWallet,
                    onTap: () async {
                      if (cubit.timeSlots != null && cubit.walletBalance < cubit.totalOrder) {
                        voucherAlert(
                          title: L10n.tr().insufficientWalletBalance,
                          context: context,
                          asDialog: false,
                        );
                        return;
                      }
                      if (cubit.walletBalance > cubit.totalOrder) {
                        cubit.selectPaymentMethod(PaymentMethod.gazzerWallet);
                      } else {
                        final remaining = (cubit.totalOrder - walletBalance).clamp(0, double.infinity);
                        await _showInsufficientWalletSheet(
                          context,
                          remaining: remaining.toDouble(),
                          onSelect: (method) {
                            cubit.setRemainingPaymentMethod(method);
                          },
                        );
                        if (cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard) {
                          cubit.selectPaymentMethod(
                            PaymentMethod.gazzerWallet,
                            removeRemainingMethod: false,
                          );
                          cubit.setWalletInfo(
                            providerName: '',
                            phoneNumber: '',
                          );
                          if (cards.isNotEmpty) {
                            cubit.selectCard(cards.first);
                          }
                        }
                        if (cubit.remainingPaymentMethod == PaymentMethod.wallet) {
                          if (context.mounted) {
                            final number = await _showWalletNumberSheet(
                              context,
                            );
                            if (number != null && number.isNotEmpty) {
                              cubit.setRemainingPaymentMethod(
                                PaymentMethod.wallet,
                              );
                              cubit.selectPaymentMethod(
                                PaymentMethod.gazzerWallet,
                                removeRemainingMethod: false,
                              );

                              cubit.setWalletInfo(
                                providerName: 'e_wallet',
                                phoneNumber: number,
                              );
                            }
                          }
                        }
                      }
                    },
                    balance: walletBalance,
                    remainingAmount: (cubit.totalOrder - walletBalance).clamp(
                      0,
                      double.infinity,
                    ),
                    availablePoints: availablePoints,
                  ),
                  if (cubit.remainingPaymentMethod != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${L10n.tr().remainingPaymentBy} ${cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard ? L10n.tr().creditCard : L10n.tr().wallet} ${L10n.tr().and} ${L10n.tr().remainingAmount} ${Helpers.getProperPrice((cubit.totalOrder - walletBalance).clamp(0, double.infinity))}',
                            style: TStyle.greyRegular(16),
                          ),
                        ),
                      ],
                    ),
                  ] else
                    const SizedBox.shrink(),
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
    this.walletPhoneNumber,
    this.remainingAmount,
  });

  final PaymentMethod method;
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? balance;
  final double? remainingAmount;
  final int? availablePoints;
  final String? walletPhoneNumber;

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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TStyle.blackBold(16),
                        ),
                      ),
                      if (walletPhoneNumber != null && walletPhoneNumber!.isNotEmpty)
                        Text(
                          walletPhoneNumber!,
                          style: TStyle.greyRegular(12),
                        ),
                    ],
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
                        const HorizontalSpacing(4),
                        if (method == PaymentMethod.gazzerWallet)
                          Container(
                            decoration: BoxDecoration(
                              color: Co.purple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: InkWell(
                              onTap: () async {
                                await context.push(
                                  WalletScreen.route,
                                );
                                if (context.mounted) {
                                  animationDialogLoading();
                                  context.read<CheckoutCubit>().loadCheckoutData();
                                  closeDialog();
                                }
                              },

                              child: Row(
                                children: [
                                  Text(
                                    L10n.tr().goToWallet,
                                    style: TStyle.whiteBold(12),
                                  ),
                                  //const HorizontalSpacing(2),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Co.white,
                                  ),
                                ],
                              ),
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

Future<void> _showInsufficientWalletSheet(
  BuildContext context, {
  required double remaining,
  required void Function(PaymentMethod method) onSelect,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.tr().insufficientWalletBalance,
              style: TStyle.blackBold(16),
            ),
            const SizedBox(height: 8),
            Text(
              '${L10n.tr().remainingAmount}: ${Helpers.getProperPrice(remaining)}',
              style: TStyle.greyRegular(14),
            ),
            const SizedBox(height: 16),
            MainBtn(
              onPressed: () {
                onSelect(PaymentMethod.creditDebitCard);
                Navigator.of(ctx).pop();
              },
              text: L10n.tr().creditCard,
            ),
            const SizedBox(height: 8),
            MainBtn(
              onPressed: () {
                onSelect(PaymentMethod.wallet);
                Navigator.of(ctx).pop();
              },
              text: L10n.tr().wallet,
              bgColor: Co.purple.withOpacityNew(0.1),
              textStyle: TStyle.primaryBold(14),
            ),
          ],
        ),
      );
    },
  );
}

//enum _WalletProvider { vodafone, etisalat, orange }

// Future<void> _showWalletProviderSheet(
//   BuildContext context, {
//   required void Function(_WalletProvider provider) onPicked,
// }) async {
//   await showModalBottomSheet(
//     context: context,
//     builder: (ctx) {
//       return Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(L10n.tr().choosePaymentMethod, style: TStyle.blackBold(16)),
//             const SizedBox(height: 12),
//             MainBtn(
//               onPressed: () {
//                 onPicked(_WalletProvider.vodafone);
//                 Navigator.of(context).pop();
//               },
//               text: L10n.tr().vodafoneCash,
//             ),
//             const SizedBox(height: 8),
//             MainBtn(
//               onPressed: () {
//                 onPicked(_WalletProvider.etisalat);
//                 Navigator.of(context).pop();
//               },
//               text: L10n.tr().eCash,
//             ),
//             const SizedBox(height: 8),
//             MainBtn(
//               onPressed: () {
//                 onPicked(_WalletProvider.orange);
//                 Navigator.of(context).pop();
//               },
//               text: L10n.tr().orangeCash,
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

Future<String?> _showWalletNumberSheet(
  BuildContext context,
) async {
  final controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().enterPhoneNumber, style: TStyle.blackBold(16)),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 14,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Co.purple.withOpacityNew(0.05),
                  //   ),
                  //   child: ,
                  // ),
                  // const SizedBox(width: 8),
                  Expanded(
                    child: Form(
                      key: _formkey,
                      child: MainTextField(
                        controller: controller,

                        hintText: 'XXXXXXXXXXX',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return L10n.tr().thisFieldIsRequired;
                          }
                          if (!value.startsWith('01')) {
                            return L10n.tr().startsWith01;
                          }
                          if (value.length != 11) {
                            return L10n.tr().invalidPhoneNumber;
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: MainBtn(
                onPressed: () {
                  if (!_formkey.currentState!.validate()) return;
                  final digits = controller.text.trim();

                  Navigator.of(context).pop(digits);
                },
                text: L10n.tr().confirm,
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
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      card.cardNumber,
                      style: TStyle.blackBold(16),
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   '${card.cardHolderName} • ${card.formattedExpiry}',
                  //   style: TStyle.greyRegular(12),
                  // ),
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
