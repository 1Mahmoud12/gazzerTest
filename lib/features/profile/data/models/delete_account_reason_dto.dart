class DeleteAccountReasonDTO {
  final String title;
  final String description;
  final int id;

  DeleteAccountReasonDTO({
    required this.title,
    required this.description,
    required this.id,
  });

  factory DeleteAccountReasonDTO.fromJson(Map<String, dynamic> json) {
    return DeleteAccountReasonDTO(
      title: json['title'],
      description: json['description'],
      id: json['id'],
    );
  }
}
