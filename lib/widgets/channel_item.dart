import 'package:flutter/material.dart';
import 'package:sr_schedules_app/channel/channel_list.dart';

class ChannelItem extends StatelessWidget {
  const ChannelItem(
      {super.key,
      required this.name,
      required this.channelType,
      required this.imageUrl,
      required this.id});

  final String imageUrl;
  final String name;
  final String channelType;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChannelList(
                          id: id,
                          channelName: name,
                        )));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: imageUrl != ""
                ? Image.network(imageUrl)
                : Image.asset(
                    "assets/images/no_image_available.png",
                    fit: BoxFit.fill,
                  ),
          ),
          title: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            channelType,
            textAlign: TextAlign.center,
          ),
          trailing: const Icon(Icons.arrow_forward)),
    );
  }
}
