class ConvertPointsRequest {
  ConvertPointsRequest({required this.points});

  final int points;

  Map<String, dynamic> toJson() {
    return {'points': points};
  }
}
