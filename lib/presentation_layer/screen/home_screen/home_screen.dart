import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/components/show_dialog.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/AnimatedWinnersList%20.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/HeaderText.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/TimeDisplay.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/prize_card.dart';
import 'package:free_lottery/presentation_layer/utils/Admobe_Controller.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../main.dart';
import 'home_controller/home_controller.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  AdmobeController _admobe = Get.put(AdmobeController());
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
                          SizedBox(height: 15),
                          PrizeWidget(ticketCount: 15),
                          SizedBox(height: 10),
                          HeaderText(title: 'Recent Winners'),
                          AnimatedWinnersList(homeController: homeController),
                          SizedBox(height: 10),
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
                                    if (!isLogin()) {
                                      showDilog(
                                        context,
                                        "You must be logged in to receive a ticket",
                                      );
                                      return;
                                    }
                                    bool isPaypal =
                                        sharedPreferences.getBool('ispaypal')!;
                                    Get.to(
                                      () => PaypalCheckout(
                                        sandboxMode: isPaypal,
                                        clientId: sharedPreferences
                                            .getString("client_id")!,
                                        secretKey: sharedPreferences
                                            .getString("secret_key")!,
                                        returnURL: "success.snippetcoder.com",
                                        cancelURL: "cancel.snippetcoder.com",
                                        transactions: const [
                                          {
                                            "amount": {
                                              "total": '0.01',
                                              "currency": "USD",
                                              "details": {
                                                "subtotal": '0.01',
                                                "shipping": '0',
                                                "shipping_discount": 0
                                              }
                                            },
                                            "description":
                                                "The payment transaction description.",
                                            "item_list": {
                                              "items": [
                                                {
                                                  "name": "Ticket",
                                                  "quantity": 1,
                                                  "price": '0.01',
                                                  "currency": "USD"
                                                }
                                              ],
                                            }
                                          }
                                        ],
                                        note:
                                            "Contact us for any questions on your order.",
                                        onSuccess: (Map params) async {
                                          // Get.back();
                                          Get.to(() => MainScreen());

                                          Get.back();
                                          printRedColor("onSuccess: $params");
                                          homeController.createTicketForUser();
                                          await Future.delayed(
                                              Duration(milliseconds: 500));
                                          showDilog(
                                              context, "you got a ticket");
                                        },
                                        onError: (error) {
                                          printRedColor("onerror: $error");
                                          printRedColor(
                                              "==================================================================================");
                                          // Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          printRedColor('cancelled:');
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ButtonPressLimit(
                                  width: deviceInfo.localWidth * 0.45,
                                  admobe: _admobe,
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

class ButtonPressLimit extends StatefulWidget {
  final double width;
  final AdmobeController admobe;

  const ButtonPressLimit(
      {super.key, required this.width, required this.admobe});
  @override
  _ButtonPressLimitState createState() => _ButtonPressLimitState();
}

class _ButtonPressLimitState extends State<ButtonPressLimit> {
  List<DateTime> pressTimestamps = [];

  @override
  void initState() {
    super.initState();
    _loadTimestamps();
  }

  _loadTimestamps() async {
    List<String> storedTimestamps =
        sharedPreferences.getStringList('timestamps') ?? [];
    setState(() {
      pressTimestamps = storedTimestamps.map((s) => DateTime.parse(s)).toList();
    });
  }

  _storeTimestamps() async {
    List<String> toStore =
        pressTimestamps.map((dt) => dt.toIso8601String()).toList();
    sharedPreferences.setStringList('timestamps', toStore);
  }

  _handleButtonPress() {
    if (!isLogin()) {
      showDilog(
        context,
        "You must be logged in to receive a ticket",
      );
      return;
    }
    final currentTime = DateTime.now();

    // Remove timestamps older than 4 hours
    pressTimestamps.removeWhere(
      (timestamp) => currentTime.difference(timestamp) >= Duration(hours: 4),
    );

    if (pressTimestamps.length <=
        int.parse(sharedPreferences.getString('num_ads')!)) {
      pressTimestamps.add(currentTime);
      _storeTimestamps();

      (printRedColor("mmms"));
      if (!isLogin()) {
        showDilog(
          context,
          "You must be logged in to receive a ticket",
        );
        return;
      }
      widget.admobe.showRewardedAd();
    } else {
      final firstTimestamp = pressTimestamps.first;
      final durationSinceFirstPress = currentTime.difference(firstTimestamp);

      if (durationSinceFirstPress >= Duration(hours: 4)) {
        pressTimestamps.removeAt(0);
        pressTimestamps.add(currentTime);
        _storeTimestamps();
        (printRedColor("mmms"));

        widget.admobe.showRewardedAd();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please wait for 4 hours from your first press.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: widget.width,
      height: 55,
      color: ColorManager.kPrimary,
      text: "Get a free ticket",
      fontSize: 18,
      press: _handleButtonPress,
    );
  }
}
// () {
//  (printRedColor(homeController
//    .currentLottery.value!.lotteryId));
//         if (!isLogin()) {
//           showDilog(
//             context,
//             "You must be logged in to receive a ticket",
//           );
//           return;
//         }
//         _admobe.showRewardedAd();
//       },