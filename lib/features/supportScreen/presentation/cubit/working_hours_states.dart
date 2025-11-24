import 'package:gazzer/features/supportScreen/domain/entities/working_hours_entity.dart';

abstract class WorkingHoursState {}

class WorkingHoursInitial extends WorkingHoursState {}

class WorkingHoursLoading extends WorkingHoursState {}

class WorkingHoursLoaded extends WorkingHoursState {
  final List<WorkingHoursEntity> workingHours;

  WorkingHoursLoaded(this.workingHours);
}

class WorkingHoursError extends WorkingHoursState {
  final String message;

  WorkingHoursError(this.message);
}
