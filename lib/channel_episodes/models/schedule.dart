import 'package:sr_schedules_app/channel_episodes/models/pagination.dart';
import 'package:sr_schedules_app/channel_episodes/models/episode.dart';

class Schedule {
  final List<Episode> schedule;
  final Pagination pagination;

  Schedule({
    required this.schedule,
    required this.pagination,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        schedule: (json['schedule'] as List).map((entry) {
          final scheduleEntry = Episode.fromJson(entry);
          scheduleEntry.convertToDateTime();
          return scheduleEntry;
        }).toList(),
        pagination: Pagination.fromJson(json['pagination']));
  }
}
