import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/success_dialog.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L10n.tr().choosePaymentMethod, style: TStyle.robotBlackSubTitle()),
              const VerticalSpacing(16),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        onTap: () => cubit.selectPaymentMethod(PaymentMethod.wallet),
                        // async {
                        //   //String number = '';
                        //
                        //   // await _showWalletNumberSheet(context).then((value) {
                        //   //   number = value ?? '';
                        //   // });
                        //   // if (number.isNotEmpty) {
                        //   //   cubit.selectPaymentMethod(PaymentMethod.wallet);
                        //   //
                        //   //   cubit.setWalletInfo(providerName: 'e_wallet', phoneNumber: number);
                        //   // }
                        // },
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
                          cubit.selectPaymentMethod(PaymentMethod.creditDebitCard);
                          if (cards.isNotEmpty) {
                            cubit.selectCard(cards.first);
                          }
                        },
                      ),

                    if (cubit.timeSlots == null) const SizedBox(height: 12),

                    _PaymentMethodItem(
                      method: PaymentMethod.gazzerWallet,
                      title: L10n.tr().gazzarWallet,
                      icon: Assets.wallet,
                      isSelected: selectedMethod == PaymentMethod.gazzerWallet,
                      onTap: () async {
                        if (cubit.timeSlots != null && cubit.walletBalance < cubit.totalOrder) {
                          voucherAlert(title: L10n.tr().insufficientWalletBalance, context: context);
                          return;
                        }
                        if (cubit.walletBalance > cubit.totalOrder) {
                          cubit.selectPaymentMethod(PaymentMethod.gazzerWallet);
                        } else {
                          cubit.selectPaymentMethod(PaymentMethod.gazzerWallet, removeRemainingMethod: false);

                          // final remaining = (cubit.totalOrder - walletBalance).clamp(0, double.infinity);
                          // await _showInsufficientWalletSheet(
                          //   context,
                          //   remaining: remaining.toDouble(),
                          //   onSelect: (method) {
                          //     cubit.setRemainingPaymentMethod(method);
                          //   },
                          // );
                          showSuccessDialog(
                            context,
                            title: L10n.tr().wallet_insufficient_balance,
                            subTitle: L10n.tr().choose_additional_payment_method,
                            iconAsset: Assets.completePaymentIc,
                            showCelebrate: false,
                            additionalWidget: Column(
                              spacing: 8,
                              children: [
                                MainBtn(
                                  onPressed: () {
                                    cubit.setRemainingPaymentMethod(PaymentMethod.creditDebitCard);
                                    Navigator.of(context).pop();
                                  },
                                  text: L10n.tr().complete_with_card,
                                  textStyle: TStyle.robotBlackRegular(),
                                  bgColor: Colors.transparent,
                                  borderColor: Co.black,
                                ),

                                MainBtn(
                                  onPressed: () {
                                    cubit.setRemainingPaymentMethod(PaymentMethod.wallet);
                                    Navigator.of(context).pop();
                                  },
                                  text: L10n.tr().wallet,
                                  textStyle: TStyle.robotBlackRegular(),
                                  bgColor: Colors.transparent,
                                  borderColor: Co.black,
                                ),
                                if (Platform.isIOS)
                                  MainBtn(
                                    onPressed: () {
                                      Alerts.showToast(L10n.tr().comingSoon);
                                      // cubit.setRemainingPaymentMethod(PaymentMethod.applePay);
                                      // Navigator.of(context).pop();
                                    },
                                    text: L10n.tr().complete_with_apple_pay,
                                    textStyle: TStyle.robotBlackRegular(),
                                    bgColor: Colors.transparent,
                                    borderColor: Co.black,
                                  ),
                              ],
                            ),
                          );
                          if (cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard) {
                            cubit.setWalletInfo(providerName: '', phoneNumber: '');
                            if (cards.isNotEmpty) {
                              cubit.selectCard(cards.first);
                            }
                          }
                          if (cubit.remainingPaymentMethod == PaymentMethod.wallet) {
                            if (context.mounted) {
                              // final number = await _showWalletNumberSheet(context);
                              // if (number != null && number.isNotEmpty) {
                              //   cubit.setRemainingPaymentMethod(PaymentMethod.wallet);
                              //   cubit.selectPaymentMethod(PaymentMethod.gazzerWallet, removeRemainingMethod: false);
                              //
                              //   cubit.setWalletInfo(providerName: 'e_wallet', phoneNumber: number);
                              // }
                            }
                          }
                        }
                      },
                      balance: walletBalance,
                      remainingAmount: (cubit.totalOrder - walletBalance).clamp(0, double.infinity),
                      availablePoints: availablePoints,
                    ),
                    if (cubit.remainingPaymentMethod != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${L10n.tr().remainingPaymentBy} ${cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard ? L10n.tr().creditCard : L10n.tr().wallet} ${L10n.tr().and} ${L10n.tr().remainingAmount} ${Helpers.getProperPrice((cubit.totalOrder - walletBalance).clamp(0, double.infinity))}',
                              style: TStyle.robotBlackRegular().copyWith(color: Co.darkGrey),
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
          ),
        );
      },
    );
  }
}

class _PaymentMethodItem extends StatefulWidget {
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
  State<_PaymentMethodItem> createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<_PaymentMethodItem> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: widget.isSelected ? Co.purple : Co.lightGrey),
          color: Co.bg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                VectorGraphicsWidget(widget.icon, width: 24, height: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(widget.title, style: TStyle.robotBlackRegular())),
                          // if (widget.walletPhoneNumber != null && widget.walletPhoneNumber!.isNotEmpty)
                          //   Text(widget.walletPhoneNumber!, style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey)),
                        ],
                      ),
                    ],
                  ),
                ),
                GradientRadioBtn(isSelected: widget.isSelected, size: 10),
                const SizedBox(width: 12),
              ],
            ),
            if (widget.balance != null) ...[
              const VerticalSpacing(6),
              Text('${L10n.tr().yourBalance}: ${Helpers.getProperPrice(widget.balance!)}', style: TStyle.robotBlackRegular()),
            ],
            if (widget.availablePoints != null && widget.availablePoints! >= 0) ...[
              const VerticalSpacing(6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Co.lightPurple, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(child: Text('${L10n.tr().yourPoints}: ${widget.availablePoints}', style: TStyle.robotBlackRegular())),
                    const HorizontalSpacing(4),
                    if (widget.method == PaymentMethod.gazzerWallet)
                      Container(
                        decoration: BoxDecoration(color: Co.purple, borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () async {
                            await context.push(WalletScreen.route);
                            if (context.mounted) {
                              animationDialogLoading();
                              context.read<CheckoutCubit>().loadCheckoutData();
                              closeDialog();
                            }
                          },

                          child: Text(L10n.tr().convert, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
                        ),
                      ),
                  ],
                ),
              ),
            ],
            if ((cubit.selectedPaymentMethod == PaymentMethod.creditDebitCard && widget.method == PaymentMethod.creditDebitCard) ||
                ((widget.method == PaymentMethod.creditDebitCard && cubit.selectedPaymentMethod == PaymentMethod.gazzerWallet) &&
                    cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard)) ...[
              const SizedBox(height: 12),
              if (cubit.cards.isNotEmpty)
                ...cubit.cards.map(
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

                    card: CardEntity(id: -1, cardNumber: L10n.tr().walletPayWithAnotherCard, cardHolderName: '', expiryMonth: 1, expiryYear: 2025),
                    isSelected: cubit.selectedCard == null,
                  );
                },
              ),
            ],
            if ((cubit.selectedPaymentMethod == PaymentMethod.wallet && widget.method == PaymentMethod.wallet) ||
                ((widget.method == PaymentMethod.wallet && cubit.selectedPaymentMethod == PaymentMethod.gazzerWallet) &&
                    cubit.remainingPaymentMethod == PaymentMethod.wallet)) ...[
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MainTextField(
                      controller: _controller,
                      hintText: L10n.tr().enterPhoneNumber,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChange: (p0) {
                        cubit.setWalletInfo(providerName: 'e_wallet', phoneNumber: p0);
                      },
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
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
//             Text(L10n.tr().choosePaymentMethod, style: TStyle.robotBlackRegular().copyWith(fontWeight:TStyle.bold)),
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

// Future<String?> _showWalletNumberSheet(BuildContext context) async {
//   final controller = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   return showModalBottomSheet<String>(
//     context: context,
//     isScrollControlled: true,
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16, top: 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(L10n.tr().enterPhoneNumber, style: TStyle.robotBlackRegular().copyWith(fontWeight:TStyle.bold)),
//             const SizedBox(height: 8),
//
//             Align(
//               alignment: AlignmentDirectional.centerEnd,
//               child: MainBtn(
//                 onPressed: () {
//                   if (!_formkey.currentState!.validate()) return;
//                   final digits = controller.text.trim();
//
//                   Navigator.of(context).pop(digits);
//                 },
//                 text: L10n.tr().confirm,
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

class _CardItem extends StatelessWidget {
  const _CardItem({required this.card, required this.isSelected, required this.onTap});

  final CardEntity card;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Co.purple : Colors.transparent, width: 2),
          color: Co.bg,
        ),
        child: Row(
          children: [
            GradientRadioBtn(isSelected: isSelected, size: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(card.cardNumber, style: TStyle.robotBlackRegular().copyWith(fontWeight: TStyle.bold)),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   '${card.cardHolderName} • ${card.formattedExpiry}',
                  //   style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey),
                  // ),
                ],
              ),
            ),
            if (card.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Co.purple.withOpacityNew(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(L10n.tr().defaultCard, style: TStyle.robotBlackSmall().copyWith(color: Co.purple)),
              ),
          ],
        ),
      ),
    );
  }
}
