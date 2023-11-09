import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/channel_episodes/models/schedule.dart';
import 'package:sr_schedules_app/channel_episodes/models/episode.dart';
import 'package:sr_schedules_app/home/model/channel.dart';
import 'package:sr_schedules_app/widgets/episode_item.dart';

class ChannelList extends StatefulWidget {
  const ChannelList({super.key, required this.channel});
  final Channel channel;

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  final dio = Dio();
  late Schedule p3Schedule;
  final List<Episode> _schedulesEntries = [];
  late final ScrollController _scrollController;
  int currentPage = 1;
  bool dataIsFetched = false;
  bool isFetchingMoreSchedule = false;

  void _getScheuldes() async {
    final String apiUrl =
        "http://api.sr.se/api/v2/scheduledepisodes?channelid=${widget.channel.id}&format=json&page=$currentPage";
    final response = await dio.get(apiUrl);
    p3Schedule = Schedule.fromJson(response.data);

    setState(() {
      dataIsFetched = true;
      _schedulesEntries.addAll(p3Schedule.schedule);
      if (isFetchingMoreSchedule) {
        isFetchingMoreSchedule = false;
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (currentPage < p3Schedule.pagination.totalpages) {
          isFetchingMoreSchedule = true;
          currentPage++;
          _getScheuldes();
        }
      });
    }
  }

  @override
  void initState() {
    _getScheuldes();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: srsaLightGray,
        appBar: _buildAppBar(),
        body: Center(
          child: dataIsFetched == false
              ? const CircularProgressIndicator()
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: _schedulesEntries.isEmpty
                        ? const Text(
                            "Tyvärr, inga avsnitt planerade för den här dagen.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : ListView(
                            controller: _scrollController,
                            children: <Widget>[
                              const SizedBox(height: 30),
                              ..._schedulesEntries.map((scheduleEntry) {
                                return EpisodeItem(episode: scheduleEntry);
                              }).toList(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isFetchingMoreSchedule
                                        ? const CircularProgressIndicator()
                                        : const SizedBox(),
                                  ],
                                ),
                              )
                            ],
                          ),
                  ),
                ),
        ));
  }

  AppBar _buildAppBar() {
    String formattedDateTime() {
      initializeDateFormatting();
      final DateTime now = DateTime.now();

      final DateFormat customDateFormat = DateFormat('E d MMM', 'sv_SE');
      String formattedDate = customDateFormat.format(now);

      return formattedDate;
    }

    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: srsaBlue,
      title: Text("${widget.channel.name} idag",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17)),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Text(
            formattedDateTime(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        )
      ],
    );
  }
}
