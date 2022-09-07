import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true);

  NotificationPlugin() {
    Firebase.initializeApp();
    _requestPermission();
    _createChannel();
    _getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message ${message.toMap().toString()}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          DateTime.now().millisecond,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              priority: Priority.max,
              importance: Importance.max,
              icon: "@mipmap/ic_launcher",
              enableVibration: true,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    });
  }

  Future<void> _createChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> _getToken() async {
    String? token = await _messaging.getToken();
    print("Token $token");
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
