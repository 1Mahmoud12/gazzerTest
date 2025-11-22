class AddBalanceResponseDto {
  final int walletTopUpId;
  final String amount;
  final String paymentMethod;
  final String paymentStatus;
  final String? iframeUrl;

  AddBalanceResponseDto({
    required this.walletTopUpId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.iframeUrl,
  });

  factory AddBalanceResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final payment = data['payment'] as Map<String, dynamic>? ?? {};
    final invoice = payment['invoice'] as Map<String, dynamic>? ?? {};

    return AddBalanceResponseDto(
      walletTopUpId: (data['wallet_top_up_id'] as num?)?.toInt() ?? 0,
      amount: data['amount'] as String? ?? '0.00',
      paymentMethod: data['payment_method'] as String? ?? '',
      paymentStatus: data['payment_status'] as String? ?? '',
      iframeUrl: invoice['iframe_url'] as String?,
    );
  }
}


