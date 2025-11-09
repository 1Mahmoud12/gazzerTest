import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gazzer/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentScreen({
    super.key,
    required this.paymentUrl,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool _hasHandledPayment = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
            _checkPaymentStatus(url);
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onUrlChange: (change) {
            log(change.toString());
          },
          onWebResourceError: (WebResourceError error) {
            log('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _checkPaymentStatus(String url) async {
    if (_hasHandledPayment) return;

    if (url.contains('success=true')) {
      _hasHandledPayment = true;
      try {
        Navigator.pop(context, url);
        // final result = await PaymobWebhookService.fetchWebhookResponse(url);
        // logger.d('Payment webhook response: $result');
        // if (!mounted) return;
        // final status = result['status'];
        // final paymentStatus = result['payment_status'];
      } catch (error, stackTrace) {
        logger.e(
          'Failed to confirm payment',
          error: error,
          stackTrace: stackTrace,
        );
        if (mounted) {
          Navigator.pop(context, url);
        }
      }
    } else if (url.contains('success=false') || url.contains('txn_response_code=DECLINED')) {
      _hasHandledPayment = true;
      if (mounted) {
        Navigator.pop(context, url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
