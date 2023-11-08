import 'package:flutter/material.dart';
import 'package:sr_schedules_app/channel_episodes/models/episode.dart';
import 'package:sr_schedules_app/channel_episodes/models/schedule.dart';
import 'package:sr_schedules_app/widgets/detail_episode_dialog.dart';

class EpisodeItem extends StatelessWidget {
  final Episode scheduleEntry;
  const EpisodeItem({super.key, required this.scheduleEntry});

  @override
  Widget build(BuildContext context) {
    void openCustomDialog() {
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: DetailEpisodeDialog(scheduleEntry: scheduleEntry),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          });
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            openCustomDialog();
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
            scheduleEntry.program.name != null
                ? scheduleEntry.program.name ?? ""
                : scheduleEntry.title,
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
