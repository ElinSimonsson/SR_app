import 'package:intl/intl.dart';
import 'package:sr_schedules_app/channel_episodes/models/program.dart';

class Episode {
  final int? episodeId;
  final String title;
  final String? subtitle;
  final String? description;
  late String startTimeUtc;
  late String endTimeUtc;
  final Program program;
  final String? imageurl;
  final String? imageurltemplate;
  final String? photographer;

  Episode({
    this.episodeId,
    required this.title,
    this.subtitle,
    this.description,
    required this.startTimeUtc,
    required this.endTimeUtc,
    required this.program,
    this.imageurl,
    this.imageurltemplate,
    this.photographer,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeId: json['episodeid'] as int?,
      title: json['title'],
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      startTimeUtc: json['starttimeutc'],
      endTimeUtc: json['endtimeutc'],
      program: Program.fromJson(json['program']),
      imageurl: json['imageurl'] as String?,
      imageurltemplate: json['imageurltemplate'] as String?,
      photographer: json['photographer'] as String?,
    );
  }
}

extension ScheduleEntryExtensions on Episode {
  void convertToDateTime() {
    startTimeUtc = _convertToMillis(startTimeUtc);
    endTimeUtc = _convertToMillis(endTimeUtc);
  }

  String _convertToMillis(String jsonDate) {
    final numeric = jsonDate.split('(')[1].split(')')[0];
    final negative = numeric.contains('-');
    final parts = numeric.split(negative ? '-' : '+');
    final millis = int.parse(parts[0]);

    final dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    final DateFormat formatter = DateFormat.Hm();
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
