import 'package:flutter/material.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/models/schedule_entry.dart';

class DetailEpisodeDialog extends StatefulWidget {
  final ScheduleEntry scheduleEntry;
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
        margin: const EdgeInsets.only(top: 45),
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
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: widget.scheduleEntry.imageurltemplate != null
                    ? Image.network(
                        widget.scheduleEntry.imageurltemplate ?? "",
                      )
                    : Image.asset('assets/images/no_image_available.png')),
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
                widget.scheduleEntry.program.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 50),
              child: Text(widget.scheduleEntry.description),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
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
