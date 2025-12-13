import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<void> init() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    FirebaseMessaging.onMessage.listen((msg) {
      print('Notification: ${msg.notification?.title}');
    });
  }
}
