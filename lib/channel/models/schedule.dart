import 'package:sr_schedules_app/channel/models/pagination.dart';
import 'package:sr_schedules_app/channel/models/schedule_entry.dart';

class Schedule {
  final List<ScheduleEntry> schedule;
  final Pagination pagination;

  Schedule({
    required this.schedule,
    required this.pagination,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        schedule: (json['schedule'] as List).map((entry) {
          final scheduleEntry = ScheduleEntry.fromJson(entry);
          scheduleEntry.convertToDateTime();
          return scheduleEntry;
        }).toList(),
        pagination: Pagination.fromJson(json['pagination']));
  }
}
