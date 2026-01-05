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
  final FocusNode _amountFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

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
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(paymentUrl: state.iframeUrl))) ??
                  'error,${L10n.tr().payment_failed}';
              animationDialogLoading();
              if (!result.split(',').last.contains('http')) {
                Alerts.showToast(L10n.tr().payment_failed);
                closeDialog();

                return;
              }
              final response = await PaymobWebhookService.fetchWebhookResponse(result.split(',').last);
              final message = response['message'] ?? L10n.tr(context).payment_failed;
              // Safely access payment_status - data might be a list or map
              final data = response['data'];
              final status = (data is Map<String, dynamic>) ? data['payment_status'] : null;
              closeDialog();
              if (status == 'completed') {
                final addedAmount = double.tryParse(_amountController.text) ?? 0;
                await showSuccessDialog(
                  AppNavigator.mainKey.currentContext!,
                  title: '${L10n.tr(context).youJustCashedIn} ${Helpers.getProperPrice(addedAmount)}',
                  subTitle: L10n.tr(context).thisIsBeginning,
                  iconAsset: Assets.successfullyAddPoundsIc,
                );
                // After payment, refresh wallet data
                context.read<WalletCubit>().load(forceRefresh: true);
              } else {
                Alerts.showToast(message);
              }
              // Clear the controller and reset form validation
              _amountController.clear();
              _amountFocusNode.unfocus();
              // Reset form validation state after clearing controller
              // Using addPostFrameCallback ensures controller is cleared before form reset
              if (mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    // Reset form which will clear validation errors
                    // Since controller is already cleared, reset will keep it empty
                    _formKey.currentState?.reset();
                  }
                });
              }
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
              Text(L10n.tr().walletAddFunds, style: TStyle.robotBlackTitle()),
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
                    Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: MainTextField(
                              controller: _amountController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              focusNode: _amountFocusNode,
                              style: TStyle.blackMedium(16, font: FFamily.roboto),
                              hintText: L10n.tr().walletEnterAmount,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChange: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return L10n.tr().walletEnterAmount;
                                }
                                if (value.length < 2) {
                                  return L10n.tr().makeAdditonMoreThan10Pounds;
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: MainBtn(
                              onPressed: isLoading
                                  ? () {}
                                  : () async {
                                      final amount = double.tryParse(_amountController.text) ?? 0.0;
                                      if (amount <= 10) {
                                        Alerts.showToast(L10n.tr().walletEnterAmount);
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
                              isEnabled: !isLoading || ((int.tryParse(_amountController.text) ?? 0) < 10),
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                              bgColor: (int.tryParse(_amountController.text) ?? 0) < 10 ? Co.purple200 : Co.purple,
                              text: L10n.tr().walletRechargeNow,
                              textStyle: TStyle.whiteBold(16, font: FFamily.roboto),
                            ),
                          ),
                        ],
                      ),
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
