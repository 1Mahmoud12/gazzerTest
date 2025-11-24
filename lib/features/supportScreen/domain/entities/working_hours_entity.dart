class WorkingHoursEntity {
  final int id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkingHoursEntity({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}
