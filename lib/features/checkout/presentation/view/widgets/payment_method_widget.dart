import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_alert_widget.dart';

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
                  const SizedBox(height: 12),
                  if (cubit.timeSlots == null)
                    _PaymentMethodItem(
                      method: PaymentMethod.wallet,
                      title: L10n.tr().wallet,
                      icon: Assets.wallet,
                      isSelected: selectedMethod == PaymentMethod.wallet,
                      walletPhoneNumber: cubit.walletPhoneNumber,
                      onTap: () async {
                        String number = '';
                        String prefix = '';
                        String providerName = '';
                        await _showWalletProviderSheet(
                          context,
                          onPicked: (provider) async {
                            switch (provider) {
                              case _WalletProvider.vodafone:
                                prefix = '010';
                                providerName = 'vodafone_cash';
                                break;
                              case _WalletProvider.etisalat:
                                prefix = '011';
                                providerName = 'etisalat_cash';
                                break;
                              case _WalletProvider.orange:
                                prefix = '012';
                                providerName = 'orange_cash';
                                break;
                            }
                            // Navigator.of(context).pop();
                          },
                        );
                        if (prefix.isEmpty || providerName.isEmpty) {
                          return;
                        }
                        await _showWalletNumberSheet(
                          context,
                          prefix: prefix,
                        ).then((value) {
                          number = value ?? '';
                        });
                        if (number.isNotEmpty && prefix.isNotEmpty && providerName.isNotEmpty) {
                          cubit.selectPaymentMethod(PaymentMethod.wallet);

                          cubit.setWalletInfo(
                            providerName: providerName,
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
                      isSelected: selectedMethod == PaymentMethod.creditDebitCard,
                      onTap: () => cubit.selectPaymentMethod(
                        PaymentMethod.creditDebitCard,
                      ),
                    ),
                  // if (selectedMethod == PaymentMethod.creditDebitCard) ...[
                  //   const SizedBox(height: 12),
                  //   ...cards.map(
                  //     (card) => Padding(
                  //       padding: const EdgeInsets.only(bottom: 12),
                  //       child: _CardItem(
                  //         card: card,
                  //         isSelected: (cubit.selectedCard == null)
                  //             ? card.isDefault
                  //             : cubit.selectedCard == card,
                  //         onTap: () {
                  //           cubit.selectCard(card);
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  //   const SizedBox(height: 12),
                  //   _AddCardItem(
                  //     onTap: () async {
                  //       await context.push(CardDetailsScreen.route);
                  //       if (context.mounted) {
                  //         context.read<CheckoutCubit>().loadCheckoutData();
                  //       }
                  //     },
                  //   ),
                  // ],
                  if (cubit.timeSlots == null) const SizedBox(height: 12),

                  _PaymentMethodItem(
                    method: PaymentMethod.gazzerWallet,
                    title: L10n.tr().gazzarWallet,
                    icon: Assets.wallet,
                    isSelected: selectedMethod == PaymentMethod.gazzerWallet,
                    onTap: () async {
                      if (cubit.timeSlots != null && cubit.walletBalance < cubit.totalOrder) {
                        voucherAlert(title: L10n.tr().insufficientWalletBalance, context: context, asDialog: false);
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
                          cubit.selectPaymentMethod(PaymentMethod.gazzerWallet, removeRemainingMethod: false);
                          cubit.setWalletInfo(providerName: '', phoneNumber: '');
                        }
                        if (cubit.remainingPaymentMethod == PaymentMethod.wallet) {
                          String prefix = '';
                          String providerName = '';
                          await _showWalletProviderSheet(
                            context,
                            onPicked: (provider) async {
                              switch (provider) {
                                case _WalletProvider.vodafone:
                                  prefix = '010';
                                  providerName = 'vodafone_cash';
                                  break;
                                case _WalletProvider.etisalat:
                                  prefix = '011';
                                  providerName = 'etisalat_cash';
                                  break;
                                case _WalletProvider.orange:
                                  prefix = '012';
                                  providerName = 'orange_cash';
                                  break;
                              }
                            },
                          );

                          if (prefix.isNotEmpty && providerName.isNotEmpty && context.mounted) {
                            final number = await _showWalletNumberSheet(
                              context,
                              prefix: prefix,
                            );
                            if (number != null && number.isNotEmpty) {
                              cubit.selectPaymentMethod(PaymentMethod.gazzerWallet, removeRemainingMethod: false);

                              cubit.setWalletInfo(
                                providerName: providerName,
                                phoneNumber: number,
                              );
                            }
                          }
                        }
                      }
                    },
                    balance: walletBalance,
                    availablePoints: availablePoints,
                  ),
                  if (cubit.remainingPaymentMethod != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${L10n.tr().remainingPaymentBy} ${cubit.remainingPaymentMethod == PaymentMethod.creditDebitCard ? L10n.tr().creditCard : L10n.tr().wallet}',
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
  });

  final PaymentMethod method;
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? balance;
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
                        if (method == PaymentMethod.gazzerWallet && (availablePoints ?? 0) > 0)
                          InkWell(
                            onTap: () => _showConvertPointsSheet(
                              context,
                              availablePoints!,
                            ),

                            child: Text(
                              L10n.tr().convert,
                              style: TStyle.primaryBold(12),
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

void _showConvertPointsSheet(BuildContext context, int availablePoints) {
  final controller = TextEditingController(text: availablePoints.toString());
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().convertPoints, style: TStyle.blackBold(16)),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: MainTextField(
                controller: controller,
                keyboardType: TextInputType.number,
                hintText: L10n.tr().enterPoints,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: MainBtn(
                onPressed: () async {
                  final text = controller.text.trim();
                  final points = int.tryParse(text) ?? 0;
                  if (points <= 0) {
                    voucherAlert(title: L10n.tr().invalidPoints, context: ctx);
                    return;
                  }
                  if (points > availablePoints) {
                    voucherAlert(
                      title: L10n.tr().insufficientPoints,
                      context: ctx,
                    );
                    return;
                  }
                  await context.read<CheckoutCubit>().convertPoints(points);
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                text: L10n.tr().convert,
              ),
            ),
          ],
        ),
      );
    },
  );
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

enum _WalletProvider { vodafone, etisalat, orange }

Future<void> _showWalletProviderSheet(
  BuildContext context, {
  required void Function(_WalletProvider provider) onPicked,
}) async {
  await showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().choosePaymentMethod, style: TStyle.blackBold(16)),
            const SizedBox(height: 12),
            MainBtn(
              onPressed: () {
                onPicked(_WalletProvider.vodafone);
                Navigator.of(context).pop();
              },
              text: L10n.tr().vodafoneCash,
            ),
            const SizedBox(height: 8),
            MainBtn(
              onPressed: () {
                onPicked(_WalletProvider.etisalat);
                Navigator.of(context).pop();
              },
              text: L10n.tr().eCash,
            ),
            const SizedBox(height: 8),
            MainBtn(
              onPressed: () {
                onPicked(_WalletProvider.orange);
                Navigator.of(context).pop();
              },
              text: L10n.tr().orangeCash,
            ),
          ],
        ),
      );
    },
  );
}

Future<String?> _showWalletNumberSheet(
  BuildContext context, {
  required String prefix,
}) async {
  final controller = TextEditingController();
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
                    child: MainTextField(
                      controller: controller,
                      prefix: Text(prefix, style: TStyle.primaryBold(14)),
                      hintText: 'XXXXXXXXX',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                      ],
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
                  final digits = controller.text.trim();
                  if (digits.length != 8) {
                    voucherAlert(
                      title: L10n.tr().invalidPhoneNumber,
                      context: context,
                    );
                    return;
                  }
                  Navigator.of(context).pop('$prefix$digits');
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

// class _CardItem extends StatelessWidget {
//   const _CardItem({
//     required this.card,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   final CardEntity card;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Co.purple : Colors.transparent,
//             width: 1,
//           ),
//           color: Co.bg,
//         ),
//         child: Row(
//           children: [
//             GradientRadioBtn(
//               isSelected: isSelected,
//               size: 4,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     card.cardNumber,
//                     style: TStyle.blackBold(16),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${card.cardHolderName} • ${card.formattedExpiry}',
//                     style: TStyle.greyRegular(12),
//                   ),
//                 ],
//               ),
//             ),
//             if (card.isDefault)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Co.purple.withOpacityNew(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   L10n.tr().defaultCard,
//                   style: TStyle.primaryBold(10),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _AddCardItem extends StatelessWidget {
//   const _AddCardItem({required this.onTap});
//
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Co.purple.withOpacityNew(0.3),
//             width: 1,
//             style: BorderStyle.solid,
//           ),
//           color: Co.purple.withOpacityNew(0.05),
//         ),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.add_circle_outline,
//               color: Co.purple,
//               size: 20,
//             ),
//             const SizedBox(width: 12),
//             Text(
//               L10n.tr().addCard,
//               style: TStyle.primaryBold(16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
