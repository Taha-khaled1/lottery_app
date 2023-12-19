import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  void _printUserToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
  }

  Future<String> userToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    return token ?? "";
  }

  /// Initialize Firebase and setup listeners
  Future<void> initialize() async {
    _printUserToken();
    _requestIOSPermissions();

    _foregroundAppListener();

    _backgroundAppListener();

    _terminatedAppListener();
  }

  /// Request notification permissions for iOS
  void _requestIOSPermissions() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  /// Handle notifications when the app is in the foreground
  void _foregroundAppListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Message received in the FOREGROUND: ${message.notification?.body}");
      // Handle the notification or data payload here
    });
  }

  /// Handle notifications when the app is in the background but still running
  void _backgroundAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "Message opened from the BACKGROUND: ${message.notification?.body}");
      // Handle the notification or data payload here
    });
  }

  /// Handle notifications caused by tapping when the app was terminated
  void _terminatedAppListener() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print(
          "The app was launched from TERMINATED state by tapping on the notification: ${initialMessage.notification?.body}");
      // Handle the notification or data payload here
    }
  }

  /// This is a global background handler, must be outside of the class
  static Future<void> backgroundHandler(RemoteMessage message) async {
    print(
        "Message received in the BACKGROUND or TERMINATED state: ${message.notification?.body}");
    // Handle the notification or data payload here
  }
}
