import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/domain/entities/working_hours_entity.dart';
import 'package:gazzer/features/supportScreen/domain/working_hours_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/working_hours_states.dart';

class WorkingHoursCubit extends Cubit<WorkingHoursState> {
  final WorkingHoursRepo _repo;

  WorkingHoursCubit(this._repo) : super(WorkingHoursInitial());

  Future<void> loadWorkingHours() async {
    emit(WorkingHoursLoading());

    final result = await _repo.getWorkingHours();
    switch (result) {
      case final Ok<List<WorkingHoursEntity>> ok:
        emit(WorkingHoursLoaded(ok.value));
        break;
      case final Err<List<WorkingHoursEntity>> err:
        emit(WorkingHoursError(err.error.message));
        break;
    }
  }

  bool isCurrentlyOnline(List<WorkingHoursEntity> workingHours) {
    if (workingHours.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final currentDay = _getDayOfWeek(now.weekday);
    final currentTime = TimeOfDay.fromDateTime(now);

    // Find today's schedule
    final todaySchedule = workingHours.where((schedule) => schedule.dayOfWeek.toLowerCase() == currentDay.toLowerCase()).firstOrNull;

    // If no schedule for today, return false
    if (todaySchedule == null || !todaySchedule.isActive) {
      return false;
    }

    final startTime = _parseTime(todaySchedule.startTime);
    final endTime = _parseTime(todaySchedule.endTime);

    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return 'monday';
    }
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
