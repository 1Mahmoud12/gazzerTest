class CheckoutParams {
  final List<String> paymentMethod;
  final String? voucher;
  final String? phoneNumber;
  final String? timeSlot;
  final String? notes;

  CheckoutParams({
    required this.paymentMethod,
    this.phoneNumber,
    this.voucher,
    this.timeSlot,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentMethod.length == 1) {
      map['payment_method'] = paymentMethod[0];
    } else {
      map['payment_method'] = paymentMethod;
    }

    if (voucher != null) map['voucher'] = voucher;
    if (phoneNumber != '') map['phone'] = phoneNumber;
    if (timeSlot != null) map['time_slot'] = timeSlot;
    if (timeSlot != null) map['is_scheduled'] = 1;
    if (notes != null) map['notes'] = notes;
    return map;
  }
}
