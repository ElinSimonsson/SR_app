import 'package:sr_schedules_app/models/schedule_entry.dart';

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
          return ScheduleEntry.fromJson(entry);
        }).toList(),
        pagination: Pagination.fromJson(json['pagination']));
  }
}

class Pagination {
  final int page;
  final int size;
  final int totalhits;
  final int totalpages;
  final String nextPage;

  Pagination(
      {required this.page,
      required this.size,
      required this.totalhits,
      required this.totalpages,
      required this.nextPage});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      size: json['size'] as int,
      totalhits: json['totalhits'] as int,
      totalpages: json['totalpages'] as int,
      nextPage: json['nextpage'] as String,
    );
  }
}
