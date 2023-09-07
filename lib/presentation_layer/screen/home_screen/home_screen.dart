import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/winner_model.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/award_screen/award_screen.dart';
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
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: "Home Screen", isBack: false),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.kPrimary,
                  ),
                )
              : InfoWidget(
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
                          AnimatedWinnersList(homeController: homeController),
                          SizedBox(height: 15),
                          HeaderText(title: 'Time Remaining'),
                          StreamBuilder<int>(
                            stream: homeController.stopWatchTimer!.rawTime,
                            initialData:
                                homeController.stopWatchTimer!.rawTime.value,
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
                                  press: () {
                                    // final now = DateTime.now();
                                    // print(now);
                                    // final nextLotteryEndTime =
                                    //     now.add(Duration(hours: 2));
                                    // print(nextLotteryEndTime);
                                  },
                                ),
                                CustomButton(
                                  width: deviceInfo.localWidth * 0.45,
                                  height: 55,
                                  color: ColorManager.kPrimary,
                                  text: "Get a free ticket",
                                  fontSize: 18,
                                  press: () {
                                    homeController.createTicketForUser();
                                  },
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
                );
        },
      ),
    );
  }
}
