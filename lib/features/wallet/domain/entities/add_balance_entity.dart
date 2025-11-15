class AddBalanceResponse {
  final int walletTopUpId;
  final String amount;
  final String paymentMethod;
  final String paymentStatus;
  final String? iframeUrl;

  const AddBalanceResponse({
    required this.walletTopUpId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.iframeUrl,
  });
}
