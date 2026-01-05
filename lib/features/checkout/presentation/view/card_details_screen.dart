// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gazzer/core/presentation/localization/l10n.dart';
// import 'package:gazzer/core/presentation/resources/app_const.dart';
// import 'package:gazzer/core/presentation/theme/app_theme.dart';
// import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
// import 'package:gazzer/di.dart';
// import 'package:gazzer/features/checkout/presentation/cubit/cardsCubit/cards_cubit.dart';
// import 'package:gazzer/features/checkout/presentation/cubit/cardsCubit/cards_states.dart';
// import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
// import 'package:go_router/go_router.dart';
//
// class CardDetailsScreen extends StatefulWidget {
//   const CardDetailsScreen({super.key});
//
//   static const route = '/card-details';
//
//   @override
//   State<CardDetailsScreen> createState() => _CardDetailsScreenState();
// }
//
// class _CardDetailsScreenState extends State<CardDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _cardNumberController;
//   late final TextEditingController _expiryMonthController;
//   late final TextEditingController _expiryYearController;
//   late final TextEditingController _cardHolderNameController;
//   bool _isDefault = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _cardNumberController = TextEditingController();
//     _expiryMonthController = TextEditingController();
//     _expiryYearController = TextEditingController();
//     _cardHolderNameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryMonthController.dispose();
//     _expiryYearController.dispose();
//     _cardHolderNameController.dispose();
//     super.dispose();
//   }
//
//   String? _validateCardNumber(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return L10n.tr().thisFieldIsRequired;
//     }
//     final digitsOnly = value.replaceAll(' ', '');
//     if (digitsOnly.length != 16) {
//       return L10n.tr().cardNumberMustBe16Digits;
//     }
//     return null;
//   }
//
//   String? _validateExpiryMonth(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return L10n.tr().thisFieldIsRequired;
//     }
//     final month = int.tryParse(value);
//     if (month == null || month < 1 || month > 12) {
//       return L10n.tr().invalidMonth;
//     }
//     return null;
//   }
//
//   String? _validateExpiryYear(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return L10n.tr().thisFieldIsRequired;
//     }
//     final year = int.tryParse(value);
//     if (year == null) {
//       return L10n.tr().invalidYear;
//     }
//
//     final currentYear = DateTime.now().year % 100;
//     final month = int.tryParse(_expiryMonthController.text);
//     if (month != null) {
//       final currentMonth = DateTime.now().month;
//       if (year < currentYear || (year == currentYear && month <= currentMonth)) {
//         return L10n.tr().expiryDateMustBeInFuture;
//       }
//     }
//
//     return null;
//   }
//
//   String? _validateCardHolderName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return L10n.tr().thisFieldIsRequired;
//     }
//     final words = value.trim().split(' ');
//     if (words.length < 2) {
//       return L10n.tr().nameMustBeGreaterThanOneWord;
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => di<CardsCubit>()),
//         BlocProvider.value(value: di<CheckoutCubit>()),
//       ],
//       child: PopScope(
//         canPop: true,
//         onPopInvokedWithResult: (didPop, result) async {
//           if (didPop) return;
//           context.read<CheckoutCubit>().loadCheckoutData();
//           if (context.mounted) context.pop();
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: GradientText(
//               text: L10n.tr().createYourCard,
//               style: TStyle.robotBlackMedium().copyWith(fontWeight:TStyle.bold),
//             ),
//           ),
//           body: ListView(
//             padding: AppConst.defaultPadding,
//             children: [
//               BlocConsumer<CardsCubit, CardsStates>(
//                 listener: (context, state) {
//                   if (state is CardAddedSuccess) {
//                     context.read<CheckoutCubit>().loadCheckoutData();
//                     Alerts.showToast(state.message, error: false);
//                     context.pop();
//                   } else if (state is CardAddedError) {
//                     Alerts.showToast(state.message);
//                   }
//                 },
//                 builder: (context, state) {
//                   final isLoading = state is CardsLoading;
//                   return Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(L10n.tr().cardNumber, style: TStyle.robotBlackRegular14().copyWith(fontWeight:TStyle.bold)),
//                         const VerticalSpacing(8),
//                         MainTextField(
//                           controller: _cardNumberController,
//                           hintText: '4916 6272 1991 9310',
//                           showBorder: true,
//                           borderRadius: 16,
//                           validator: _validateCardNumber,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [CardNumberFormatter()],
//                           max: 19,
//                         ),
//                         const VerticalSpacing(16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     L10n.tr().expiryMonth,
//                                     style: TStyle.robotBlackRegular14().copyWith(fontWeight:TStyle.bold),
//                                   ),
//                                   const VerticalSpacing(8),
//                                   MainTextField(
//                                     controller: _expiryMonthController,
//                                     hintText: '10',
//                                     showBorder: true,
//                                     borderRadius: 16,
//                                     validator: _validateExpiryMonth,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                                     max: 2,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const HorizontalSpacing(16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     L10n.tr().expiryYear,
//                                     style: TStyle.robotBlackRegular14().copyWith(fontWeight:TStyle.bold),
//                                   ),
//                                   const VerticalSpacing(8),
//                                   MainTextField(
//                                     controller: _expiryYearController,
//                                     hintText: '27',
//                                     showBorder: true,
//                                     borderRadius: 16,
//                                     validator: _validateExpiryYear,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                                     max: 2,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const VerticalSpacing(16),
//                         Text(
//                           L10n.tr().cardHolderName,
//                           style: TStyle.robotBlackRegular14().copyWith(fontWeight:TStyle.bold),
//                         ),
//                         const VerticalSpacing(8),
//                         MainTextField(
//                           controller: _cardHolderNameController,
//                           hintText: 'John Doe',
//                           showBorder: true,
//                           borderRadius: 16,
//                           validator: _validateCardHolderName,
//                           keyboardType: TextInputType.name,
//                         ),
//                         const VerticalSpacing(12),
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 1.1,
//                               child: Checkbox(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                 value: _isDefault,
//                                 visualDensity: VisualDensity.compact,
//                                 onChanged: (val) {
//                                   if (val == null) return;
//                                   setState(() => _isDefault = val);
//                                 },
//                               ),
//                             ),
//                             const HorizontalSpacing(8),
//                             Expanded(
//                               child: Text(
//                                 L10n.tr().setAsDefaultCard,
//                                 style: TStyle.robotBlackRegular14().copyWith(fontWeight:TStyle.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const VerticalSpacing(16),
//                         MainBtn(
//                           onPressed: () {
//                             if (isLoading) return;
//                             if (_formKey.currentState?.validate() == true) {
//                               context.read<CardsCubit>().addCard(
//                                 cardNumber: _cardNumberController.text,
//                                 cardholderName: _cardHolderNameController.text,
//                                 expiryMonth: _expiryMonthController.text.padLeft(2, '0'),
//                                 expiryYear: _expiryYearController.text.length == 2 ? '20${_expiryYearController.text}' : _expiryYearController.text,
//                                 isDefault: _isDefault,
//                               );
//                             }
//                           },
//                           isLoading: isLoading,
//                           text: L10n.tr().createCard,
//
//                           borderThickness: 1,
//                           width: double.infinity,
//                           height: 50,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CardNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final text = newValue.text;
//     if (text.isEmpty) return newValue;
//     final digitsOnly = text.replaceAll(' ', '');
//     if (digitsOnly.length > 16) return oldValue;
//     final buffer = StringBuffer();
//     for (int i = 0; i < digitsOnly.length; i++) {
//       if (i > 0 && i % 4 == 0) buffer.write(' ');
//       buffer.write(digitsOnly[i]);
//     }
//     final formatted = buffer.toString();
//     return TextEditingValue(
//       text: formatted,
//       selection: TextSelection.collapsed(offset: formatted.length),
//     );
//   }
// }
