import 'package:flutter/material.dart';
import 'package:sr_schedules_app/widgets/schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final dio = Dio();

  // void _getScehuldes() async {
  //   const String apiUrl =
  //       "http://api.sr.se/api/v2/scheduledepisodes?channelid=164&format=json";
  //   final response = await dio.get(apiUrl);
  //   final p3schedule = Schedule.fromJson(response.data);
  //   print(p3schedule.pagination.totalpages);
  // }

  // @override
  // void initState() {
  //   _getScehuldes();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const ScheduleWidget(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset('assets/images/p3.png'),
          )),
      title: const Text("P3 Idag"),
      centerTitle: true,
    );
  }
}
