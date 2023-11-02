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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          scheduleEntry.imageurltemplate != null
              ? Image.network(scheduleEntry.imageurltemplate ?? "")
              : Image.asset(
                  'assets/images/no_image_available.png',
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "Idag ${scheduleEntry.startTimeUtc} - ${scheduleEntry.endTimeUtc}"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color.fromARGB(255, 178, 178, 178),
                height: 1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              scheduleEntry.program.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(scheduleEntry.description),
          )
        ],
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Text(
        "Om avsnittet",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: srsaBlue,
    );
  }
}
