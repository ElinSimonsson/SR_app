import 'package:flutter/material.dart';
import 'package:sr_schedules_app/channel_episodes/channel_list.dart';
import 'package:sr_schedules_app/home/model/channel.dart';

class ChannelItem extends StatelessWidget {
  const ChannelItem({super.key, required this.channel});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            print(channel.id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChannelList(
                          id: channel.id,
                          channelName: channel.name,
                        )));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: channel.image != null
                ? Image.network(channel.image ?? "")
                : Image.asset(
                    "assets/images/no_image_available.png",
                    fit: BoxFit.fill,
                  ),
          ),
          title: Text(
            channel.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            channel.channelType,
            textAlign: TextAlign.center,
          ),
          trailing: const Icon(Icons.arrow_forward)),
    );
  }
}
