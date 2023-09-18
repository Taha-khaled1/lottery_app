import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_lottery/presentation_layer/notification_service/notification_service.dart';
import 'package:free_lottery/presentation_layer/utils/NotificationHandler.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:free_lottery/application_layer/app/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

import 'data_layer/models/user_model.dart';

UserModel? userApp;
late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  sharedPreferences.setString("lang", 'ar');
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  await NotificationService().initializePlatformNotifications();
  NotificationHandler notificationHandler = NotificationHandler();
  await notificationHandler.initialize();
  await fetchDataAndSaveToSharedPreferences();
  if (isLogin()) {
    await fetchUserData(sharedPreferences.getString("id")!);
  }

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
      printRedColor('Data saved to SharedPreferences: $data');
      sharedPreferences.setString('android_id', data['android_id']);
      sharedPreferences.setString('client_id', data['client_id']);
      sharedPreferences.setString('ios_id', data['ios_id']);
      sharedPreferences.setString('public_key', data['public_key']);
      sharedPreferences.setString('secret_key', data['secret_key']);
      sharedPreferences.setString('privecy', data['privecy']);
      sharedPreferences.setString('terms', data['terms']);
      sharedPreferences.setString('password', data['password']);
      sharedPreferences.setBool('ispaypal', data['ispaypal']);
      sharedPreferences.setString('num_ads', data['num_ads'].toString());
      sharedPreferences.setString('percentage', data['percentage'].toString());
      // You can also print the values to confirm they were retrieved and saved correctly.
      printRedColor('Data saved to SharedPreferences hhh: $data');
    } else {
      print('Document does not exist.');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

Future fetchUserData(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userSnapshot.exists) {
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    userApp = UserModel.fromMap(userData);

    return userData;
  }
}
