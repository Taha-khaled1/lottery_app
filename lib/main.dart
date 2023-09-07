import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:free_lottery/presentation_layer/notification_service/notification_service.dart';
import 'package:free_lottery/presentation_layer/utils/NotificationHandler.dart';
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
  await NotificationService().initializePlatformNotifications();
  NotificationHandler notificationHandler = NotificationHandler();
  await notificationHandler.initialize();

  // await AndroidAlarmManager.initialize();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}
