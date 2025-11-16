import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/pkgs/paymob/paymob_view.dart';
import 'package:gazzer/core/presentation/pkgs/paymob/paymob_webhook_service.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/success_dialog.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/presentation/cubit/add_balance_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/add_balance_state.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_state.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/payment_method_bottom_sheet.dart';

class AddFundWidget extends StatelessWidget {
  const AddFundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final paymentCards = state is WalletLoaded ? state.data.paymentCards : const <PaymentCardEntity>[];
        return _AddFundWidgetContent(paymentCards: paymentCards);
      },
    );
  }
}

class _AddFundWidgetContent extends StatefulWidget {
  const _AddFundWidgetContent({required this.paymentCards});

  final List<PaymentCardEntity> paymentCards;

  @override
  State<_AddFundWidgetContent> createState() => _AddFundWidgetState();
}

class _AddFundWidgetState extends State<_AddFundWidgetContent> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<AddBalanceCubit>(),
      child: BlocConsumer<AddBalanceCubit, AddBalanceState>(
        listener: (context, state) async {
          if (state is AddBalanceSuccess) {
            // Navigate to payment screen
            if (context.mounted) {
              final result =
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(paymentUrl: state.iframeUrl),
                    ),
                  ) ??
                  'error,${L10n.tr().payment_failed}';
              animationDialogLoading();
              if (!result.split(',').last.contains('http')) {
                Alerts.showToast(
                  L10n.tr().payment_failed,
                );
                closeDialog();

                return;
              }
              final response = await PaymobWebhookService.fetchWebhookResponse(
                result.split(',').last,
              );
              final message = response['message'];
              final status = response['data']?['payment_status'];
              closeDialog();
              if (status == 'completed') {
                final addedAmount = double.tryParse(_amountController.text) ?? 0;
                await showSuccessDialog(
                  AppNavigator.mainKey.currentContext!,
                  title: '${L10n.tr(context).youJustCashedIn} ${Helpers.getProperPrice(addedAmount)}',
                  subTitle: L10n.tr(context).keepCollecting,
                  iconAsset: Assets.successfullyAddPoundsIc,
                );
                context.read<WalletCubit>().load(forceRefresh: true);
                _amountController.clear();
              } else {
                Alerts.showToast(
                  message,
                );
              }
              // After payment, refresh wallet data
            }
          } else if (state is AddBalanceError) {
            Alerts.showToast(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AddBalanceLoading;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L10n.tr().walletAddFunds,
                style: TStyle.robotBlackTitle(),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Co.bg,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Co.purple100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.visaIc),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            L10n.tr().walletRechargeViaCard,
                            style: TStyle.blackMedium(16, font: FFamily.roboto),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacing(16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: MainTextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: TStyle.blackMedium(16, font: FFamily.roboto),
                            hintText: L10n.tr().walletEnterAmount,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}$'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MainBtn(
                            onPressed: isLoading
                                ? () {}
                                : () async {
                                    final amount =
                                        double.tryParse(
                                          _amountController.text,
                                        ) ??
                                        0.0;
                                    if (amount <= 0) {
                                      Alerts.showToast(
                                        L10n.tr().walletEnterAmount,
                                      );
                                      return;
                                    }
                                    await PaymentMethodBottomSheet.show(
                                      context: context,
                                      amount: amount,
                                      paymentCards: widget.paymentCards,
                                      onPaymentResult: (result) {
                                        if (result != null) {
                                          context.read<AddBalanceCubit>().addBalance(
                                            amount: amount,
                                            description: 'description',
                                            paymentMethodType: result.paymentMethodType,
                                            phone: result.walletNumber,
                                            cardId: result.paymentCard?.id,
                                          );
                                        }
                                      },
                                    );
                                  },
                            isEnabled: !isLoading,
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 2,
                            ),
                            bgColor: Co.purple,
                            text: L10n.tr().walletRechargeNow,
                            textStyle: TStyle.whiteBold(
                              16,
                              font: FFamily.roboto,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
