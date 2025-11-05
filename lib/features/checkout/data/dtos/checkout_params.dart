class CheckoutParams {
  final List<String> paymentMethod;
  final String? voucher;
  final String? timeSlot;
  final bool? isScheduled;
  final String? notes;

  CheckoutParams({
    required this.paymentMethod,
    this.voucher,
    this.timeSlot,
    this.isScheduled,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentMethod.length == 1) {
      map['payment_method'] = paymentMethod[0];
    } else {
      for (int i = 0; i < paymentMethod.length; i++) {
        map['payment_method[$i]'] = paymentMethod[i];
      }
    }
    if (voucher != null) map['voucher'] = voucher;
    if (timeSlot != null) map['time_slot'] = timeSlot;
    if (isScheduled != null) map['is_scheduled'] = isScheduled;
    if (notes != null) map['notes'] = notes;
    return map;
  }
}
