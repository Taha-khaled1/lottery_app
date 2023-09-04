import 'dart:isolate';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:free_lottery/application_layer/app/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  // await NotificationService().initializePlatformNotifications();
  // await AndroidAlarmManager.initialize();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello");
// }
//         await NotificationService().alarmCallback(
//           des: notificationList[randomIndex].description,
//           scheduleDate: combinedDateTime,
//           title: notificationList[randomIndex].title,
//         );
//         showToast('The task was created successfully');