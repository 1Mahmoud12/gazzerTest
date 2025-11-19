import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';

enum PaymentMethodType {
  creditDebit,
  applePay,
  eWallet,
}

class ResultPayment {
  final PaymentMethodType paymentMethodType;
  final PaymentCardEntity? paymentCard;
  final String? walletNumber;

  ResultPayment({
    required this.paymentMethodType,
    this.paymentCard,
    this.walletNumber,
  });
}

class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({
    super.key,
    required this.amount,
    required this.paymentCards,
    required this.onPaymentResult,
  });

  final double amount;
  final List<PaymentCardEntity> paymentCards;
  final Function(ResultPayment?) onPaymentResult;

  static Future<void> show({
    required BuildContext context,
    required double amount,
    required List<PaymentCardEntity> paymentCards,
    required Function(ResultPayment?) onPaymentResult,
  }) {
    return showDialog(
      context: context,
      // isScrollControlled: true,
      // backgroundColor: Colors.transparent,
      // useSafeArea: true,
      builder: (context) => Dialog(
        child: PaymentMethodBottomSheet(
          amount: amount,
          paymentCards: paymentCards,
          onPaymentResult: onPaymentResult,
        ),
      ),
    );
  }

  @override
  State<PaymentMethodBottomSheet> createState() => _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  PaymentMethodType? _selectedMethod;
  PaymentCardEntity? _selectedCard;
  static const int _newCardId = -1; // Special ID for "Add New Card" option
  final TextEditingController _walletNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _walletNumberController.dispose();
    super.dispose();
  }

  bool _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    // If starts with '0' or '01', length should be 11
    if (value.startsWith('0')) {
      return value.length == 11;
    }
    // If starts with '1' (but not '01'), length should be 10
    if (value.startsWith('1')) {
      return value.length == 10;
    }
    return false;
  }

  void _handlePayment() {
    if (_selectedMethod == null) {
      return;
    }

    // Validate based on payment method
    if (_selectedMethod == PaymentMethodType.creditDebit) {
      // For credit/debit, card selection is optional (can add new card)
      // No validation needed
    } else if (_selectedMethod == PaymentMethodType.applePay) {
      // Validate phone number for eWallet
      Alerts.showToast(L10n.tr().comingSoon, error: false);
      return;
    } else if (_selectedMethod == PaymentMethodType.eWallet) {
      // Validate phone number for eWallet
      if (!_formKey.currentState!.validate()) {
        return;
      }
      final walletNumber = _walletNumberController.text.trim();
      if (!_validatePhoneNumber(walletNumber)) {
        return;
      }
    }

    // Create result and return
    final result = ResultPayment(
      paymentMethodType: _selectedMethod!,
      paymentCard: _selectedCard?.id == -1 ? null : _selectedCard,
      walletNumber: _selectedMethod == PaymentMethodType.eWallet ? _walletNumberController.text.trim() : null,
    );

    Navigator.of(context).pop();
    widget.onPaymentResult(result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Container(
      decoration: const BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with wallet icon
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Co.purple,
                      ),
                      child: SvgPicture.asset(
                        Assets.paymentIc,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.walletYouWillRecharge(
                        widget.amount.toStringAsFixed(0),
                        l10n.egp,
                      ),
                      style: TStyle.robotBlackMedium(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.walletPleaseSelectPaymentMethod,
                      style: TStyle.robotBlackMedium(font: FFamily.roboto),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Payment method options
              _PaymentMethodOption(
                icon: Assets.creditIc,
                title: l10n.walletCreditOrDebit,
                isSelected: _selectedMethod == PaymentMethodType.creditDebit,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethodType.creditDebit;
                    _selectedCard = widget.paymentCards.isNotEmpty ? widget.paymentCards.first : null;
                  });
                },
                paymentMethodWidget: _selectedMethod == PaymentMethodType.creditDebit
                    ? _CreditDebitSection(
                        paymentCards: widget.paymentCards,
                        selectedCard: _selectedCard,
                        onCardSelected: (card) {
                          setState(() {
                            _selectedCard = card;
                          });
                        },
                        onAddNewCard: () {
                          setState(() {
                            _selectedCard = const PaymentCardEntity(
                              id: _newCardId,
                              last4Digits: '0000',
                              cardBrand: 'new',
                              cardholderName: 'New Card',
                              expiryMonth: 1,
                              expiryYear: 2025,
                              isDefault: false,
                            );
                          });
                        },
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              _PaymentMethodOption(
                icon: Assets.applePayIc,
                title: l10n.walletApplePay,
                isSelected: _selectedMethod == PaymentMethodType.applePay,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethodType.applePay;
                  });
                },
              ),
              const SizedBox(height: 12),
              _PaymentMethodOption(
                icon: Assets.eWalletIc,
                title: l10n.walletEWallet,
                isSelected: _selectedMethod == PaymentMethodType.eWallet,
                paymentMethodWidget: _selectedMethod == PaymentMethodType.eWallet
                    ? _EWalletSection(
                        controller: _walletNumberController,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethodType.eWallet;
                  });
                },
              ),

              // Expanded details based on selection
              if (_selectedMethod != null) ...[
                const SizedBox(height: 24),
                MainBtn(
                  onPressed: _selectedMethod != null ? _handlePayment : () {},
                  isEnabled: _selectedMethod != null,
                  bgColor: Co.purple,
                  text: l10n.walletPayNow,
                  textStyle: TStyle.whiteBold(16, font: FFamily.roboto),
                  width: double.infinity,
                  radius: 40,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  const _PaymentMethodOption({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.paymentMethodWidget,
  });

  final String icon;
  final String title;
  final Widget? paymentMethodWidget;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Co.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Co.purple : Co.lightGrey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TStyle.robotBlackMedium(font: FFamily.roboto),
                  ),
                ),
                GradientRadioBtn(
                  isSelected: isSelected,
                  onPressed: onTap,
                  size: 12,
                ),
              ],
            ),
            if (paymentMethodWidget != null) paymentMethodWidget!,
          ],
        ),
      ),
    );
  }
}

class _CreditDebitSection extends StatelessWidget {
  const _CreditDebitSection({
    required this.paymentCards,
    required this.selectedCard,
    required this.onCardSelected,
    required this.onAddNewCard,
  });

  final List<PaymentCardEntity> paymentCards;
  final PaymentCardEntity? selectedCard;
  final Function(PaymentCardEntity) onCardSelected;
  final VoidCallback onAddNewCard;

  static const int _newCardId = -1;

  bool _isNewCardSelected() => selectedCard?.id == _newCardId;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (paymentCards.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...paymentCards.map((card) {
                final cardIsSelected = selectedCard?.id == card.id && selectedCard?.id != _newCardId;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => onCardSelected(card),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Co.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: cardIsSelected ? Co.purple : Co.lightGrey,
                          width: cardIsSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          GradientRadioBtn(
                            isSelected: cardIsSelected,
                            onPressed: () => onCardSelected(card),
                            size: 8,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '**** **** **** ${card.last4Digits}',
                              style: TStyle.robotBlackMedium(
                                font: FFamily.roboto,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                final newCardIsSelected = _isNewCardSelected();
                return InkWell(
                  onTap: onAddNewCard,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Co.bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: newCardIsSelected ? Co.purple : Co.lightGrey,
                        width: newCardIsSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        GradientRadioBtn(
                          isSelected: newCardIsSelected,
                          onPressed: onAddNewCard,
                          size: 8,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.walletPayWithAnotherCard,
                          style: TStyle.robotBlackMedium(font: FFamily.roboto).copyWith(
                            color: Co.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EWalletSection extends StatelessWidget {
  const _EWalletSection({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MainTextField(
          controller: controller,
          hintText: l10n.walletEnterWalletNumber,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.thisFieldIsRequired;
            }
            // Check if starts with '0' or '01' (both start with '0')
            if (value.startsWith('0')) {
              if (value.length != 11) {
                return l10n.phoneMustBeElevenDigits;
              }
              return null;
            }
            // Check if starts with '1' (but not '01')
            if (value.startsWith('1')) {
              if (value.length != 10) {
                return l10n.phoneMustBeTenDigits;
              }
              return null;
            }
            // If doesn't start with '0' or '1', show error
            return l10n.phoneMustStartWithZeroOrOne;
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        ),
      ),
    );
  }
}
