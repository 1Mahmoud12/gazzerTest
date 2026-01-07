// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// import 'package:gazzer/core/data/resources/session.dart';
// import 'package:gazzer/core/presentation/pkgs/paymob/pay_mob_service.dart';
// import 'package:gazzer/core/presentation/pkgs/paymob/paymob_view.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
//
// class CheckoutService {
//   final PaymobService _paymobService = PaymobService();
//
//   Future<void> processWalletPayment(
//     BuildContext context,
//     String walletPhoneNumber,
//   ) async {
//     try {
//       // Ensure you pass the wallet holder's phone number in the correct format (e.g., 01XXXXXXXXX)
//       final walletPhone = walletPhoneNumber;
//
//       final billingData = {
//         'email': Session().client!.email ?? '',
//         'first_name': Session().client!.clientName,
//         'phone_number': Session().client!.phoneNumber,
//
//         // Commonly required fields by Paymob; adjust to your needs
//         'apartment': 'NA',
//         'floor': 'NA',
//         'building': 'NA',
//         'street': 'NA',
//         'city': 'Cairo',
//         'country': 'EG',
//         'state': 'Cairo',
//       };
//
//       final redirectUrl = await _paymobService.initiateWalletPayment(
//         amountCents: 10000, // 100 EGP
//         currency: 'EGP',
//         billingData: billingData,
//         walletPhoneNumber: walletPhone,
//       );
//
//       if (redirectUrl != null && redirectUrl.isNotEmpty && context.mounted) {
//         final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentScreen(paymentUrl: redirectUrl),
//           ),
//         );
//         _handlePaymentResult(result);
//       } else {
//         Alerts.showToast('Failed to initialize wallet payment');
//       }
//     } catch (e) {
//       Alerts.showToast('Error: $e');
//     }
//   }
//
//   // For new cards - user enters all details in Paymob iframe
//   // After success, call your backend to save card details (without CVV)
//   Future<void> processNewCardPayment(
//     BuildContext context, {
//     required int amountCents,
//     Function(Map<String, dynamic>)? onSuccess,
//   }) async {
//     try {
//       final iframeUrl = await _paymobService.initiateCardPayment(
//         amountCents: amountCents,
//         currency: 'EGP',
//       );
//
//       if (iframeUrl != null && iframeUrl.isNotEmpty && context.mounted) {
//         final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentScreen(paymentUrl: iframeUrl),
//           ),
//         );
//         if (result == 'success') {
//           // TODO: Extract card details from Paymob callback and save to YOUR server
//           // You'll need to modify PaymentScreen to capture the success URL params
//           Alerts.showToast('Payment completed successfully!', error: false);
//           if (onSuccess != null) {
//             onSuccess({});
//           }
//         } else {
//           _handlePaymentResult(result);
//         }
//       } else {
//         Alerts.showToast('Failed to initialize card payment');
//       }
//     } catch (e) {
//       Alerts.showToast('Error: $e');
//     }
//   }
//
//   // ============ NEW UNIFIED CHECKOUT ============
//
//   /// Process payment using Paymob's Unified Checkout (modern approach)
//   /// This provides better card handling and saves cards automatically
//   Future<void> processUnifiedCheckout(
//     BuildContext context, {
//     required int amountCents,
//     List<int>? paymentMethodIds,
//     List<Map<String, dynamic>>? items,
//     Function(Map<String, dynamic>)? onSuccess,
//   }) async {
//     try {
//       final checkoutUrl = await _paymobService.initiateUnifiedCheckout(
//         amountCents: amountCents,
//         currency: 'EGP',
//         paymentMethodIds: paymentMethodIds,
//         items: items,
//       );
//
//       if (checkoutUrl != null && checkoutUrl.isNotEmpty && context.mounted) {
//         final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentScreen(paymentUrl: checkoutUrl),
//           ),
//         );
//
//         if (result == 'success') {
//           Alerts.showToast('Payment completed successfully!', error: false);
//           if (onSuccess != null) {
//             onSuccess({});
//           }
//         } else {
//           _handlePaymentResult(result);
//         }
//       } else {
//         Alerts.showToast('Failed to initialize unified checkout');
//       }
//     } catch (e) {
//       Alerts.showToast('Error: $e');
//     }
//   }
//
//   //
//   // // For saved cards - use card token from YOUR server
//   // Future<void> processSavedCardPayment(
//   //   BuildContext context, {
//   //   required String cardToken,
//   //   required int amountCents,
//   // }) async {
//   //   try {
//   //     final result = await _paymobService.payWithSavedCard(
//   //       amountCents: amountCents,
//   //       currency: 'EGP',
//   //       cardToken: cardToken,
//   //     );
//   //
//   //     if (result != null) {
//   //       final success = result['success'] == true;
//   //       if (success) {
//   //         Alerts.showToast('Payment completed successfully!', error: false);
//   //       } else {
//   //         // Check if 3D Secure is required
//   //         final redirectUrl = result['redirect_url'] ?? result['iframe_redirection_url'];
//   //         if (redirectUrl != null) {
//   //           final webViewResult = await Navigator.push(
//   //             context,
//   //             MaterialPageRoute(
//   //               builder: (context) => PaymentScreen(paymentUrl: redirectUrl),
//   //             ),
//   //           );
//   //           _handlePaymentResult(webViewResult);
//   //         } else {
//   //           Alerts.showToast(
//   //             'Payment failed: ${result['message'] ?? 'Unknown error'}',
//   //           );
//   //         }
//   //       }
//   //     } else {
//   //       Alerts.showToast('Failed to process card payment');
//   //     }
//   //   } catch (e) {
//   //     Alerts.showToast('Error: $e');
//   //   }
//   // }
//
//   void _handlePaymentResult(dynamic result) {
//     if (result == 'success') {
//       Alerts.showToast('Payment completed successfully!', error: false);
//     } else if (result == 'failed') {
//       Alerts.showToast('Payment failed. Please try again.');
//     } else {
//       Alerts.showToast('Payment cancelled.');
//     }
//   }
// }
