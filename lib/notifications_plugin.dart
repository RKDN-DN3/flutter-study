import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class NotificationPlugin {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final AndroidNotification _androidNotification = const AndroidNotification(
      channelId: "high_importance_channel",
      priority: AndroidNotificationPriority.highPriority);

  NotificationPlugin() {
    Firebase.initializeApp();
    setupPermission();
    setUpFireBaseNotification();
  }

  void setupPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void setUpFireBaseNotification() async {
    String? token = await messaging.getToken();
    print("token $token");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.toMap().toString()}');
    });
  }
}
