// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:gazzer/core/data/resources/session.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../main.dart';
//
// class PaymobService {
//   // Replace with your Paymob credentials
//   static const String apiKey =
//       'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFd01UYzFOeXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5tVzBRLVJjNE96X3JOQldfWW1oMU95M0N1eE9ZcUJRZ1J0RVlGenVVU1ctOE41aXZ3RXFLRzMyRFgydVhHelNXVUNEa1I5RzYzRjVNTHZvbHRaTmc1dw==';
//   static const String integrationId = '5383777';
//   static const String integrationWalletId = '5383913';
//   static const String iframeId = '975387';
//
//   // Secret keys for new APIs
//   static const String secretKey = 'egy_sk_test_d57718b2c8f9ab8029da5b8f240f5ad7597ff9598e16eb33f4ddec48d6f45070';
//   static const String publicKey = 'egy_pk_test_GX59bj3xB4b3R5n60WScq1hZ8lH0L2eC';
//
//   // Payment method IDs
//   static const int cardPaymentMethodId = 5384831;
//
//   static const String baseUrl = 'https://accept.paymob.com/api';
//
//   // Step 1: Authentication
//   Future<String?> authenticate() async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/tokens'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'api_key': apiKey}),
//       );
//
//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         return data['token'];
//       }
//     } catch (e) {
//       log('Authentication error: $e');
//     }
//     return null;
//   }
//
//   // Step 2: Create Order
//   Future<int?> createOrder({
//     required String authToken,
//     required int amountCents,
//     required String currency,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/ecommerce/orders'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'auth_token': authToken,
//           'delivery_needed': 'false',
//           'amount_cents': amountCents,
//           'currency': currency,
//           'items': [],
//         }),
//       );
//
//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         return data['id'];
//       }
//     } catch (e) {
//       log('Create order error: $e');
//     }
//     return null;
//   }
//
//   // Step 3: Generate Payment Key
//   Future<String?> getPaymentKey({
//     required String authToken,
//     required int orderId,
//     required int amountCents,
//     required String currency,
//     required Map<String, dynamic> billingData,
//     String? integrationIdOverride,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/acceptance/payment_keys'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'auth_token': authToken,
//           'amount_cents': amountCents,
//           'expiration': 3600,
//           'order_id': orderId,
//           'billing_data': billingData,
//           'currency': currency,
//           'integration_id': int.parse(integrationIdOverride ?? integrationId),
//         }),
//       );
//
//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         return data['token'];
//       }
//     } catch (e) {
//       log('Payment key error: $e');
//     }
//     return null;
//   }
//
//   // Complete payment flow (card/iframe)
//   Future<String?> initiatePayment({
//     required int amountCents,
//     required String currency,
//     required Map<String, dynamic> billingData,
//   }) async {
//     // Step 1: Authenticate
//     final authToken = await authenticate();
//     if (authToken == null) return null;
//
//     // Step 2: Create Order
//     final orderId = await createOrder(
//       authToken: authToken,
//       amountCents: amountCents,
//       currency: currency,
//     );
//     if (orderId == null) return null;
//
//     // Step 3: Get Payment Key
//     final paymentKey = await getPaymentKey(
//       authToken: authToken,
//       orderId: orderId,
//       amountCents: amountCents,
//       currency: currency,
//       billingData: billingData,
//       integrationIdOverride: integrationId,
//     );
//
//     return paymentKey;
//   }
//
//   // Wallet payment flow - returns redirect URL
//   Future<String?> initiateWalletPayment({
//     required int amountCents,
//     required String currency,
//     required Map<String, dynamic> billingData,
//     required String walletPhoneNumber,
//   }) async {
//     final authToken = await authenticate();
//     if (authToken == null) return null;
//
//     final orderId = await createOrder(
//       authToken: authToken,
//       amountCents: amountCents,
//       currency: currency,
//     );
//     if (orderId == null) return null;
//
//     final paymentKey = await getPaymentKey(
//       authToken: authToken,
//       orderId: orderId,
//       amountCents: amountCents,
//       currency: currency,
//       billingData: billingData,
//       integrationIdOverride: integrationWalletId,
//     );
//     if (paymentKey == null) return null;
//
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/acceptance/payments/pay'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'source': {
//             'identifier': walletPhoneNumber, // e.g., 01XXXXXXXXX
//             'subtype': 'WALLET',
//           },
//           'payment_token': paymentKey,
//         }),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         // Paymob returns redirect_url for wallet flows
//         return (data['redirect_url'] ?? data['iframe_redirection_url'])?.toString();
//       }
//     } catch (e) {
//       log('Wallet pay error: $e');
//     }
//     return null;
//   }
//
//   // Card payment flow - user enters card details and CVV in iframe
//   // After success, extract card token from callback and save to your server
//   Future<String?> initiateCardPayment({
//     required int amountCents,
//     required String currency,
//   }) async {
//     final authToken = await authenticate();
//     if (authToken == null) return null;
//
//     final orderId = await createOrder(
//       authToken: authToken,
//       amountCents: amountCents,
//       currency: currency,
//     );
//     if (orderId == null) return null;
//
//     final paymentKey = await getPaymentKey(
//       authToken: authToken,
//       orderId: orderId,
//       amountCents: amountCents,
//       currency: currency,
//       billingData: {
//         'email': Session().client!.email ?? '',
//         'first_name': Session().client!.clientName,
//         'phone_number': Session().client!.phoneNumber,
//         'last_name': Session().client!.clientName,
//         'apartment': 'NA',
//         'floor': 'NA',
//         'building': 'NA',
//         'street': 'NA',
//         'city': 'Cairo',
//         'country': 'EG',
//         'state': 'Cairo',
//       },
//       integrationIdOverride: integrationId,
//     );
//     if (paymentKey == null) return null;
//     return getPaymentUrl(paymentKey);
//   }
//
//   // Card payment with saved card token (no CVV needed if token is valid)
//   Future<Map<String, dynamic>?> payWithSavedCard({
//     required int amountCents,
//     required String currency,
//     required String cardToken,
//   }) async {
//     final authToken = await authenticate();
//     if (authToken == null) return null;
//
//     final orderId = await createOrder(
//       authToken: authToken,
//       amountCents: amountCents,
//       currency: currency,
//     );
//     if (orderId == null) return null;
//
//     final paymentKey = await getPaymentKey(
//       authToken: authToken,
//       orderId: orderId,
//       amountCents: amountCents,
//       currency: currency,
//       billingData: {
//         'email': Session().client!.email ?? '',
//         'first_name': Session().client!.clientName,
//         'phone_number': Session().client!.phoneNumber,
//         'last_name': Session().client!.clientName,
//         'apartment': 'NA',
//         'floor': 'NA',
//         'building': 'NA',
//         'street': 'NA',
//         'city': 'Cairo',
//         'country': 'EG',
//         'state': 'Cairo',
//       },
//       integrationIdOverride: integrationId,
//     );
//     if (paymentKey == null) return null;
//
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/acceptance/payments/pay'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'source': {
//             'identifier': cardToken,
//             'subtype': 'TOKEN',
//           },
//           'payment_token': paymentKey,
//         }),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         logger.d('Saved card payment response: $data');
//         return data;
//       } else {
//         log(
//           'Saved card payment error: ${response.statusCode} - ${response.body}',
//         );
//       }
//     } catch (e) {
//       log('Saved card payment error: $e');
//     }
//     return null;
//   }
//
//   // Generate payment URL for iframe
//   String getPaymentUrl(String paymentKey) {
//     return 'https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=$paymentKey';
//   }
//
//   // ============ NEW APIS - Intention & Unified Checkout ============
//
//   /// Create payment intention - returns client_secret for unified checkout
//   Future<Map<String, dynamic>?> createIntention({
//     required int amountCents,
//     required String currency,
//     List<int>? paymentMethodIds,
//     List<Map<String, dynamic>>? items,
//     Map<String, dynamic>? billingData,
//     Map<String, dynamic>? customer,
//     Map<String, dynamic>? extras,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://accept.paymob.com/v1/intention/'),
//         headers: {
//           'Authorization': 'Token $secretKey',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'amount': amountCents,
//           'currency': currency,
//           'payment_methods': paymentMethodIds ?? [cardPaymentMethodId],
//           'items':
//               items ??
//               [
//                 {
//                   'name': 'Order Payment',
//                   'amount': amountCents,
//                   'description': 'Payment for order',
//                   'quantity': 1,
//                 },
//               ],
//           'billing_data':
//               billingData ??
//               {
//                 'apartment': 'NA',
//                 'first_name': Session().client!.clientName,
//                 'last_name': Session().client!.clientName,
//                 'street': 'NA',
//                 'building': 'NA',
//                 'phone_number': Session().client!.phoneNumber,
//                 'city': 'Cairo',
//                 'country': 'EG',
//                 'email': Session().client!.email ?? '',
//                 'floor': 'NA',
//                 'state': 'Cairo',
//               },
//           'customer':
//               customer ??
//               {
//                 'first_name': Session().client!.clientName,
//                 'last_name': Session().client!.clientName,
//                 'email': Session().client!.email ?? '',
//                 'extras': {},
//               },
//           'extras': extras ?? {},
//         }),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         logger.d('Intention created: $data');
//         return data;
//       } else {
//         log(
//           'Create intention error: ${response.statusCode} - ${response.body}',
//         );
//       }
//     } catch (e) {
//       log('Create intention error: $e');
//     }
//     return null;
//   }
//
//   /// Get unified checkout URL with client secret
//   String getUnifiedCheckoutUrl(String clientSecret) {
//     return 'https://accept.paymob.com/unifiedcheckout/?publicKey=$publicKey&clientSecret=$clientSecret';
//   }
//
//   /// Complete flow: Create intention and return unified checkout URL
//   Future<String?> initiateUnifiedCheckout({
//     required int amountCents,
//     required String currency,
//     List<int>? paymentMethodIds,
//     List<Map<String, dynamic>>? items,
//     Map<String, dynamic>? billingData,
//     Map<String, dynamic>? customer,
//     Map<String, dynamic>? extras,
//   }) async {
//     final intention = await createIntention(
//       amountCents: amountCents,
//       currency: currency,
//       paymentMethodIds: paymentMethodIds,
//       items: items,
//       billingData: billingData,
//       customer: customer,
//       extras: extras,
//     );
//
//     if (intention != null && intention['client_secret'] != null) {
//       final clientSecret = intention['client_secret'] as String;
//       return getUnifiedCheckoutUrl(clientSecret);
//     }
//
//     return null;
//   }
// }
