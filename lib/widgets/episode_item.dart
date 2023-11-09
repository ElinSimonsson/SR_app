import 'package:flutter/material.dart';
import 'package:sr_schedules_app/channel_episodes/models/episode.dart';
import 'package:sr_schedules_app/widgets/detail_episode_dialog.dart';

class EpisodeItem extends StatelessWidget {
  final Episode episode;
  const EpisodeItem({super.key, required this.episode});

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
                child: DetailEpisodeDialog(episode: episode),
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
            episode.startTimeUtc,
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            episode.program.name != null
                ? episode.program.name ?? ""
                : episode.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: episode.subtitle != null
              ? Text(
                  episode.subtitle ?? "",
                  textAlign: TextAlign.center,
                )
              : null,
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: episode.imageurl != null
                ? Image.network(episode.imageurl ?? "")
                : Image.asset(
                    "assets/images/no_image_available.png",
                    fit: BoxFit.fill,
                  ),
          ),
        ));
  }
}
