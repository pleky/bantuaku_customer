import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:bantuaku_customer/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const channelID = 'bantuaku_customer_channel';
const channelName = 'BantuAku Customer Notifications';

class FirebaseNotificationService {
  static final FirebaseNotificationService _instance = FirebaseNotificationService._internal();
  factory FirebaseNotificationService() => _instance;
  FirebaseNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // iOS permission
    if (Platform.isIOS) {
      await _messaging.requestPermission(alert: true, badge: true, sound: true, provisional: true);
    }

    _messaging.requestPermission(alert: true, badge: true, sound: true, provisional: true);

    // Android/iOS local notification setup
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
    await _localNotifications.initialize(initSettings);

    // Get FCM Token
    final token = await _messaging.getToken();
    final sharedPreference = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('FCM Token: $token');
    }

    if (token != null) {
      await sharedPreference.setString(Constants.fcmTokenKey, token);
    }

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Received message: ${message.notification?.title}');
      }
      _showNotification(message);
    });

    // When app opened by notification (background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Opened app by notification: ${message.notification?.title}');
      }
    });

    // For background message (must be top-level function)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      channelID,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}

// Background message handler (must be outside class)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseNotificationService()._showNotification(message);
}

Future<void> deleteFcmToken() async {
  final sharedPreference = await SharedPreferences.getInstance();
  await sharedPreference.remove(Constants.fcmTokenKey);
  await FirebaseMessaging.instance.deleteToken();
}

Future<String?> generateNewFCM() async {
  final newToken = await FirebaseMessaging.instance.getToken();
  debugPrint('Generated new FCM token: $newToken');
  final sharedPreference = await SharedPreferences.getInstance();
  if (newToken != null) {
    await sharedPreference.setString(Constants.fcmTokenKey, newToken);
  }
  return newToken;
}
