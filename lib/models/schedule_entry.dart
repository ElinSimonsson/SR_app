import 'package:sr_schedules_app/models/channel.dart';
import 'package:sr_schedules_app/models/program.dart';

class ScheduleEntry {
  final int episodeId;
  final String title;
  final String? subtitle;
  final String description;
  final String startTimeUtc;
  final String endTimeUtc;
  final Program program;
  final Channel channel;
  final String? imageurl;
  final String? imageurltemplate;
  final String? photographer;

  ScheduleEntry({
    required this.episodeId,
    required this.title,
    this.subtitle,
    required this.description,
    required this.startTimeUtc,
    required this.endTimeUtc,
    required this.program,
    required this.channel,
    this.imageurl,
    this.imageurltemplate,
    this.photographer,
  });

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      episodeId: json['episodeid'],
      title: json['title'],
      subtitle: json['subtitle'] as String?,
      description: json['description'],
      startTimeUtc: json['starttimeutc'],
      endTimeUtc: json['endtimeutc'],
      program: Program.fromJson(json['program']),
      channel: Channel.fromJson(json['channel']),
      imageurl: json['imageurl'] as String?,
      imageurltemplate: json['imageurltemplate'] as String?,
      photographer: json['photographer'] as String?,
    );
  }
}
