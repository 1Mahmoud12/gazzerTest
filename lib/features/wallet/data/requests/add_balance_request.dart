class AddBalanceRequest {
  final double amount;
  final String description;
  final String paymentMethod;
  final String? phone;
  final int? cardId;

  AddBalanceRequest({
    required this.amount,
    required this.description,
    required this.paymentMethod,
    this.phone,
    this.cardId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'amount': amount,
      'description': description,
      'payment_method': paymentMethod,
    };

    if (phone != null) {
      json['phone'] = phone;
    }

    if (cardId != null) {
      json['card_id'] = cardId;
    }

    return json;
  }
}


