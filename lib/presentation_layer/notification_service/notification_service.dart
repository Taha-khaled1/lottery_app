import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/subjects.dart';
import 'package:free_lottery/main.dart';
// import 'package:free_lottery/presentation_layer/screen/notification_screen/notification_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        selectNotification('');
      },
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    't1', 'c1',
    channelDescription: 'Reminder', //Required for Android 8.0 or after
    importance: Importance.high,
    priority: Priority.high,
    channelShowBadge: true,
    icon: 'logo',
    largeIcon: DrawableResourceAndroidBitmap('logo'),
    sound: RawResourceAndroidNotificationSound(
      sharedPreferences.getString('tun') ?? 'a',
    ),
  );

  void simpleAndroidLocalNotification({
    required String title,
    required String des,
  }) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotifications.show(
      0,
      title,
      des,
      notificationDetails,
    );
  }

  Future<void> alarmCallback(
      {required String title,
      required String des,
      required DateTime scheduleDate}) async {
    // final DateTime now = DateTime.now();
    // final DateTime scheduleDate = now.add(Duration(seconds: 5));

    NotificationDetails notificationDetails = NotificationDetails(
      android: NotificationService().androidPlatformChannelSpecifics,
    );
    await NotificationService().localNotifications.zonedSchedule(
          12345,
          title,
          des,
          tz.TZDateTime.from(
            scheduleDate.add(Duration(seconds: 5)),
            tz.local,
          ),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
  }
  ///////////
}

// void onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NotificationScreen(),
//               ),
//             );
//           },
//         )
//       ],
//     ),
//   );
// }
