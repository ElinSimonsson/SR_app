import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/widgets/channel_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late List apiChannels = [];
  late List allChannels = [];
  late final ScrollController _scrollController;
  int currentPage = 1;
  late int totalPages;

  void _getChannels() async {
    final String apiUrl =
        "http://api.sr.se/api/v2/channels?format=json&page=$currentPage";
    final response = await dio.get(apiUrl);
    setState(() {
      apiChannels = response.data['channels'];
      totalPages = response.data['pagination']['totalpages'];
      for (var channel in apiChannels) {
        allChannels.add(channel);
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (currentPage < totalPages) {
          currentPage++;
          _getChannels();
        }
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _getChannels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: srsaLightGray,
      appBar: _buildAppbar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            const SizedBox(height: 30),
            ...allChannels.map((e) {
              final name = e['name'] as String;
              final channelType = e['channeltype'] as String;
              final imageUrl = (e['image'] as String?) ?? "";
              final id = e['liveaudio']['id'];
              return ChannelItem(
                  name: name,
                  channelType: channelType,
                  imageUrl: imageUrl,
                  id: id);
            }).toList()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: srsaBlue,
      centerTitle: true,
      title: const Text(
        "Alla Sverige Radio kanaler",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
