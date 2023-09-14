import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';

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
  await fetchDataAndSaveToSharedPreferences();
  // await AndroidAlarmManager.initialize();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

Future<void> fetchDataAndSaveToSharedPreferences() async {
  final firestore = FirebaseFirestore.instance;
  // final sharedPreferences = await SharedPreferences.getInstance();

  try {
    final doc = await firestore.collection('setting').doc('setting').get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      print('Data saved to SharedPreferences: $data');
      sharedPreferences.setString('android_id', data['android_id']);
      sharedPreferences.setString('client_id', data['client_id']);
      sharedPreferences.setString('ios_id', data['ios_id']);
      sharedPreferences.setString('public_key', data['public_key']);
      sharedPreferences.setString('secret_key', data['secret_key']);

      // You can also print the values to confirm they were retrieved and saved correctly.
      print('Data saved to SharedPreferences: $data');
    } else {
      print('Document does not exist.');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}
