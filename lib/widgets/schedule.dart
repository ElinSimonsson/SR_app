import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sr_schedules_app/models/schedule.dart';
import 'package:sr_schedules_app/models/schedule_entry.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final dio = Dio();

  late Schedule p3Schedule;
  List<ScheduleEntry> list = [];

  void _getScehuldes() async {
    const String apiUrl =
        "http://api.sr.se/api/v2/scheduledepisodes?channelid=164&format=json";
    final response = await dio.get(apiUrl);
    setState(() {
      p3Schedule = Schedule.fromJson(response.data);
      list.addAll(p3Schedule.schedule);
    });
  }

  DateTime _convertToDate(String jsonDate) {
    var numeric = jsonDate.split('(')[1].split(')')[0];
    var negative = numeric.contains('-');
    var parts = numeric.split(negative ? '-' : '+');
    var millis = int.parse(parts[0]);

    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  void initState() {
    _getScehuldes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        ...list.map((scheduleEntry) {
          return ListTile(
            trailing: Text("${_convertToDate(scheduleEntry.startTimeUtc)}"),
            title: Text(scheduleEntry.title),
          );
        }).toList()
      ],
    ));
  }
}
