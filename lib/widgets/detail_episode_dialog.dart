import 'package:flutter/material.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/channel_episodes/models/episode.dart';

class DetailEpisodeDialog extends StatefulWidget {
  final Episode scheduleEntry;
  const DetailEpisodeDialog({super.key, required this.scheduleEntry});

  @override
  State<DetailEpisodeDialog> createState() => _DetailEpisodeDialogState();
}

class _DetailEpisodeDialogState extends State<DetailEpisodeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: widget.scheduleEntry.imageurltemplate != null
                      ? Image.network(
                          widget.scheduleEntry.imageurltemplate ?? "",
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      : Image.asset('assets/images/no_image_landscape.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, bottom: 10, right: 10),
              child: Text(
                  "Idag ${widget.scheduleEntry.startTimeUtc} - ${widget.scheduleEntry.endTimeUtc}"),
            ),
            const Divider(
              color: Color.fromARGB(255, 178, 178, 178),
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                widget.scheduleEntry.program.name != null
                    ? widget.scheduleEntry.program.name ?? ""
                    : widget.scheduleEntry.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 5, bottom: 50, right: 10),
              child: Text.rich(TextSpan(children: <TextSpan>[
                const TextSpan(
                    text: 'Beskrivning: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: widget.scheduleEntry.description != ""
                        ? widget.scheduleEntry.description
                        : "Ingen beskrivning finns",
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: srsaBlue),
                    child: const Text('Ok'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
