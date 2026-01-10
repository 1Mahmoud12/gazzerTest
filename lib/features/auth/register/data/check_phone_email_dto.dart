class CheckPhoneEmailDto {
  CheckPhoneEmailDto({this.status, this.message, this.data});

  final String? status;
  final String? message;
  final CheckPhoneEmailData? data;

  factory CheckPhoneEmailDto.fromJson(Map<String, dynamic> json) {
    return CheckPhoneEmailDto(
      status: json['status'],
      message: json['message'],
      data: json['data'] == null
          ? null
          : CheckPhoneEmailData.fromJson(json['data']),
    );
  }
}

class CheckPhoneEmailData {
  CheckPhoneEmailData({required this.phoneFound, required this.emailFound});

  final bool phoneFound;
  final bool emailFound;

  factory CheckPhoneEmailData.fromJson(Map<String, dynamic> json) {
    return CheckPhoneEmailData(
      phoneFound: json['phone_found'] ?? false,
      emailFound: json['email_found'] ?? false,
    );
  }
}
