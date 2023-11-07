import 'package:flutter/material.dart';
import 'package:sr_schedules_app/models/schedule_entry.dart';
import 'package:sr_schedules_app/widgets/detail_episode_dialog.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleEntry scheduleEntry;
  const ScheduleItem({super.key, required this.scheduleEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DetailEpisodeDialog(scheduleEntry: scheduleEntry);
                });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Text(
            scheduleEntry.startTimeUtc,
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            scheduleEntry.program.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: scheduleEntry.subtitle != null
              ? Text(
                  scheduleEntry.subtitle ?? "",
                  textAlign: TextAlign.center,
                )
              : null,
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: scheduleEntry.imageurl != null
                ? Image.network(scheduleEntry.imageurl ?? "")
                : Image.asset(
                    "assets/images/no_image_available.png",
                    fit: BoxFit.fill,
                  ),
          ),
        ));
  }
}
