import 'package:gazzer/features/supportScreen/domain/entities/working_hours_entity.dart';

class WorkingHoursDTO {
  final int id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  WorkingHoursDTO({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkingHoursDTO.fromJson(Map<String, dynamic> json) {
    return WorkingHoursDTO(
      id: json['id'] as int,
      dayOfWeek: json['day_of_week'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  WorkingHoursEntity toEntity() {
    return WorkingHoursEntity(
      id: id,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      isActive: isActive,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
