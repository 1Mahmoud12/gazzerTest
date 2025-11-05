class CheckoutResponseDTO {
  final int orderId;
  final String? iframeUrl;
  final String paymentMethod;
  final String paymentStatus;
  final String? transactionId;

  CheckoutResponseDTO({
    required this.orderId,
    this.iframeUrl,
    required this.paymentMethod,
    required this.paymentStatus,
    this.transactionId,
  });

  factory CheckoutResponseDTO.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final order = data['order'] as Map<String, dynamic>? ?? {};
    final payment = data['payment'] as Map<String, dynamic>? ?? {};
    final invoice = payment['invoice'] as Map<String, dynamic>? ?? {};
    final orderPayments = order['order_payments'] as List<dynamic>? ?? [];
    final firstPayment = orderPayments.isNotEmpty ? orderPayments[0] as Map<String, dynamic>? : null;

    return CheckoutResponseDTO(
      orderId: (order['id'] as num?)?.toInt() ?? 0,
      iframeUrl: invoice['iframe_url'] as String?,
      paymentMethod: payment['method'] as String? ?? '',
      paymentStatus: firstPayment?['payment_status'] as String? ?? '',
      transactionId: firstPayment?['transaction_id']?.toString(),
    );
  }
}
