import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sr_schedules_app/constants/color.dart';
import 'package:sr_schedules_app/models/schedule.dart';
import 'package:sr_schedules_app/models/schedule_entry.dart';
import 'package:sr_schedules_app/widgets/schedule_item.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late Schedule p3Schedule;
  final List<ScheduleEntry> _schedulesEntries = [];
  late final ScrollController _scrollController;
  int currentPage = 1;
  bool dataIsFetched = false;

  void _getScheuldes() async {
    final String apiUrl =
        "http://api.sr.se/api/v2/scheduledepisodes?channelid=164&format=json&page=$currentPage";
    final response = await dio.get(apiUrl);
    p3Schedule = Schedule.fromJson(response.data);

    setState(() {
      dataIsFetched = true;
      _schedulesEntries.addAll(p3Schedule.schedule);
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (currentPage < p3Schedule.pagination.totalpages) {
          currentPage++;
          _getScheuldes();
        } else {
          print(
              "currentPage: $currentPage, max ${p3Schedule.pagination.totalpages}");
        }
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("reached the top");
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
                      const SizedBox(height: 30),
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
      backgroundColor: srsaBlue,
      leading: Container(
          margin: const EdgeInsets.only(left: 8, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset('assets/images/p3.png'),
          )),
      title: const Text("P3 Tablå",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
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
