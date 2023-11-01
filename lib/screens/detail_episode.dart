import 'package:flutter/material.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/models/schedule_entry.dart';

class DetailEpisodeScreen extends StatelessWidget {
  final ScheduleEntry scheduleEntry;
  const DetailEpisodeScreen({super.key, required this.scheduleEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Text(
        scheduleEntry.program.name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: srsaBlue,
    );
  }
}
