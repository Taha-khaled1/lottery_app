import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/AnimatedWinnersList%20.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/HeaderText.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/TimeDisplay.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/TopSection.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'home_controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(15 * 60),
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStopped');
    },
    onEnded: () {
      print('onEnded');
    },
  );
  final scrollController = ScrollController();
  @override
  void initState() {
    // stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    stopWatchTimer.fetchStopped.listen((value) => print('stopped from stream'));
    stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));
    stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: "Home Screen", isBack: false),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TopSection(
                  homeController: homeController,
                  deviceInfo: deviceInfo,
                ),
                SizedBox(height: 30),
                HeaderText(title: 'Recent Winners'),
                AnimatedWinnersList(),
                SizedBox(height: 15),
                HeaderText(title: 'Time Remaining'),
                StreamBuilder<int>(
                  stream: stopWatchTimer.rawTime,
                  initialData: stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime = StopWatchTimer.getDisplayTime(
                      value,
                      hours: true,
                      milliSecond: false,
                    );
                    final parts = displayTime.split(':');
                    final hours = parts[0];
                    final minutes = parts[1];
                    final seconds = parts[2];

                    return TimeDisplay(
                      hours: hours,
                      minutes: minutes,
                      seconds: seconds,
                    );
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      CustomButton(
                        width: deviceInfo.localWidth * 0.45,
                        height: 55,
                        color: ColorManager.black,
                        text: "buying ticket",
                        fontSize: 18,
                        press: () {},
                      ),
                      CustomButton(
                        width: deviceInfo.localWidth * 0.45,
                        height: 55,
                        color: ColorManager.kPrimary,
                        text: "Get a free ticket",
                        fontSize: 18,
                        press: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
