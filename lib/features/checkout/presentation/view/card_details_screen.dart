import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';
import 'package:go_router/go_router.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  static const route = '/card-details';

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cardNumberController;
  late final TextEditingController _expiryMonthController;
  late final TextEditingController _expiryYearController;
  late final TextEditingController _cardHolderNameController;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _expiryMonthController = TextEditingController();
    _expiryYearController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    context.read<CheckoutCubit>().loadCards();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    final digitsOnly = value.replaceAll(' ', '');
    if (digitsOnly.length != 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  String? _validateExpiryMonth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    final month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }
    return null;
  }

  String? _validateExpiryYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    final year = int.tryParse(value);
    if (year == null) {
      return 'Invalid year';
    }

    // Get current year
    final currentYear = DateTime.now().year % 100;

    // Check if the date is in the future
    final month = int.tryParse(_expiryMonthController.text);
    if (month != null) {
      final currentMonth = DateTime.now().month;
      if (year < currentYear || (year == currentYear && month <= currentMonth)) {
        return 'Expiry date must be in the future';
      }
    }

    return null;
  }

  String? _validateCardHolderName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return L10n.tr().thisFieldIsRequired;
    }
    final words = value.trim().split(' ');
    if (words.length < 2) {
      return 'Name must be greater than one word';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di<CheckoutCubit>(),

      child: Scaffold(
        appBar: AppBar(
          title: GradientText(
            text: 'Create Your Card',
            style: TStyle.blackBold(18),
          ),
        ),
        body: ListView(
          padding: AppConst.defaultPadding,
          children: [
            BlocConsumer<CheckoutCubit, CheckoutStates>(
              listener: (context, state) {
                if (state is CardCreated) {
                  Alerts.showToast('Card created successfully', error: false);
                  context.pop();
                } else if (state is CardError) {
                  Alerts.showToast(state.message);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Number',
                        style: TStyle.blackBold(14),
                      ),
                      const VerticalSpacing(8),
                      MainTextField(
                        controller: _cardNumberController,
                        hintText: '4916 6272 1991 9310',
                        showBorder: true,
                        borderRadius: 16,
                        validator: _validateCardNumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: CardNumberFormatter(),
                        max: 19, // 16 digits + 3 spaces
                      ),
                      const VerticalSpacing(16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Month',
                                  style: TStyle.blackBold(14),
                                ),
                                const VerticalSpacing(8),
                                MainTextField(
                                  controller: _expiryMonthController,
                                  hintText: '10',
                                  showBorder: true,
                                  borderRadius: 16,
                                  validator: _validateExpiryMonth,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: FilteringTextInputFormatter.digitsOnly,
                                  max: 2,
                                ),
                              ],
                            ),
                          ),
                          const HorizontalSpacing(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Year',
                                  style: TStyle.blackBold(14),
                                ),
                                const VerticalSpacing(8),
                                MainTextField(
                                  controller: _expiryYearController,
                                  hintText: '27',
                                  showBorder: true,
                                  borderRadius: 16,
                                  validator: _validateExpiryYear,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: FilteringTextInputFormatter.digitsOnly,
                                  max: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(16),
                      Text(
                        'Card Holder Name',
                        style: TStyle.blackBold(14),
                      ),
                      const VerticalSpacing(8),
                      MainTextField(
                        controller: _cardHolderNameController,
                        hintText: 'John Doe',
                        showBorder: true,
                        borderRadius: 16,
                        validator: _validateCardHolderName,
                        keyboardType: TextInputType.name,
                      ),
                      const VerticalSpacing(24),
                      const VerticalSpacing(16),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: AppConst.defaultPadding,
            child: BlocBuilder<CheckoutCubit, CheckoutStates>(
              builder: (context, state) {
                final isLoading = state is CardsLoaded && state.isCreating;
                return MainBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.read<CheckoutCubit>().createCard(
                        cardNumber: _cardNumberController.text,
                        expiryMonth: int.parse(_expiryMonthController.text),
                        expiryYear: int.parse(_expiryYearController.text),
                        cardHolderName: _cardHolderNameController.text,
                      );
                    }
                  },
                  isLoading: isLoading,
                  text: 'Create Card',
                  bgColor: Co.purple.withOpacity(0.1),
                  borderColor: Co.purple,
                  borderThickness: 1,
                  textStyle: TStyle.primaryBold(16),
                  width: double.infinity,
                  height: 50,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final digitsOnly = text.replaceAll(' ', '');
    if (digitsOnly.length > 16) return oldValue;

    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
