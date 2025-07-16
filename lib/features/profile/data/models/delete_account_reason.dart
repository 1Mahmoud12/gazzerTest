class DeleteAccountReason {
  final String reason;
  final int id;

  DeleteAccountReason({
    required this.reason,
    required this.id,
  });

  factory DeleteAccountReason.fromJson(Map<String, dynamic> json) {
    return DeleteAccountReason(reason: json['reason'], id: json['id']);
  }
}
