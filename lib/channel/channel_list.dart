import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/channel/models/schedule.dart';
import 'package:sr_schedules_app/channel/models/schedule_entry.dart';
import 'package:sr_schedules_app/widgets/schedule_item.dart';

class ChannelList extends StatefulWidget {
  const ChannelList({super.key, required this.id, required this.channelName});
  final int id;
  final String channelName;

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  final dio = Dio();
  late Schedule p3Schedule;
  final List<ScheduleEntry> _schedulesEntries = [];
  late final ScrollController _scrollController;
  int currentPage = 1;
  bool dataIsFetched = false;
  bool isFetchingMoreSchedule = false;

  void _getScheuldes() async {
    final String apiUrl =
        "http://api.sr.se/api/v2/scheduledepisodes?channelid=${widget.id}&format=json&page=$currentPage";
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
                  child: ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      ..._schedulesEntries.map((scheduleEntry) {
                        return ScheduleItem(scheduleEntry: scheduleEntry);
                      }).toList(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 30),
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
      title: Text("${widget.channelName} Tablå",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500)),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Text(
            formattedDateTime(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        )
      ],
    );
  }
}
