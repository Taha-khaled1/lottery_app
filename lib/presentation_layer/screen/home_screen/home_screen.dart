import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:free_lottery/presentation_layer/components/show_dialog.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/AnimatedWinnersList%20.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/HeaderText.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/TimeDisplay.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/prize_card.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/Admobe_Controller.dart';
import 'package:free_lottery/presentation_layer/utils/NotificationHandler.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../main.dart';
import 'home_controller/home_controller.dart';

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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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

List<DateTime> pressTimestamps = [];
storeTimestamps() async {
  List<String> toStore =
      pressTimestamps.map((dt) => dt.toIso8601String()).toList();
  sharedPreferences.setStringList('timestamps', toStore);
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
      (printRedColor("mmms"));
      if (!isLogin()) {
        showDilog(
          context,
          "You must be logged in to receive a ticket",
        );
        return;
      }
      pressTimestamps.add(currentTime);
      storeTimestamps();
      widget.admobe.showRewardedAd();
    } else {
      final firstTimestamp = pressTimestamps.first;
      final durationSinceFirstPress = currentTime.difference(firstTimestamp);

      if (durationSinceFirstPress >= Duration(hours: 4)) {
        pressTimestamps.removeAt(0);
        pressTimestamps.add(currentTime);
        storeTimestamps();
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
      press: () async {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.id}'); // e.g. "Moto G (4)"

        // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        // print('Running on ${iosInfo.utsname.machine}');
      },

      // _handleButtonPress,
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

Future<void> createAccountWithDeviceIdentifier() async {
  try {
    printRedColor("start");
    // Check if the device has a unique identifier (e.g., Android ID, IMEI, or other device-specific info)
    String deviceIdentifier = await getDeviceIdentifier();
    printRedColor("getDeviceIdentifier");
    // Check if an account with the device identifier already exists in your Firebase database
    bool doesAccountExist = await doesAccountExistF(deviceIdentifier);
    printRedColor("doesAccountExistF : $doesAccountExist");
    if (doesAccountExist) {
      // Account with the device identifier already exists
      signInWithDeviceIdentifier(
        getEmailDevice(deviceIdentifier),
        deviceIdentifier,
      );
      sharedPreferences.setString("login_type", 'id');
      printRedColor("signInWithDeviceIdentifier");
    } else {
      // Create a new account using the device identifier
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: getEmailDevice(deviceIdentifier),
        password: deviceIdentifier, // Use the device identifier as the password
      );

      sharedPreferences.setString('id', credential.user!.uid);
      sharedPreferences.setString('email', credential.user!.email!);
      sharedPreferences.setString("login_type", 'id');
      printRedColor(" credential.user!.uid : ${credential.user!.uid} : ");
      // Store the device identifier in Firestore
      await storeDeviceIdentifier(
          sharedPreferences.getString('id')!, deviceIdentifier);
    }
  } catch (e) {
    // Handle any exceptions that may occur during the process
    showToast('$e.');
    printRedColor("$e");
  } finally {
    sharedPreferences.setString("login_type", 'id');
  }
}

Future<String> getDeviceIdentifier() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.id;
}

Future<bool> doesAccountExistF(String deviceIdentifier) async {
  try {
    final userDoc = FirebaseFirestore.instance.collection('users');
    final query = await userDoc
        .where('deviceIdentifier', isEqualTo: deviceIdentifier)
        .get();

    // If any documents match the query, an account with the device identifier exists
    return query.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors that may occur during the query
    print('Error checking account existence: $e');
    return false;
  }
}

Future<void> storeDeviceIdentifier(
    String userId, String deviceIdentifier) async {
  try {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'));
    printRedColor("userDoc : ${userDoc} : ");
    String token = await NotificationHandler().userToken();
    await userDoc.set({
      'userId': sharedPreferences.getString('id'),
      'image': sharedPreferences.getString('image'),
      'wallet': "0",
      'code': "+1",
      'phone': "00000",
      'deviceIdentifier': getDeviceIdentifier(),
      'name': "non-name",
      "fcm": token,
    });
  } catch (e) {
    printRedColor("===========> : ${e} : ");
  }
}

void signInWithDeviceIdentifier(email, password) async {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  final userId = credential.user!.uid;
  sharedPreferences.setString('id', userId);
  sharedPreferences.setString('email', credential.user!.email!);
  var user =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  sharedPreferences.setString('image', user['image'] ?? '');
  sharedPreferences.setString('name', user['name'] ?? '');
  sharedPreferences.setString('phone', user['phone'] ?? '');
  sharedPreferences.setString("lev", '2');
}

String getEmailDevice(deviceId) {
  return "device-" + deviceId + "@gmail.com";
}
