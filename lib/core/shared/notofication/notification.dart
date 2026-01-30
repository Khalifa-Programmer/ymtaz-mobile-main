import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/notifications/logic/notification_cubit.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _fcm.requestPermission();
  }

  Future<void> backgroundHandler(RemoteMessage message) async {}

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }
}

Future<void> showNotification(
    RemoteMessage payload, GlobalKey<NavigatorState> navigatorKey) async {
  var android = const AndroidInitializationSettings('logopng');
  var initiallizationSettingsIOS = const DarwinInitializationSettings();
  var initialSetting =
      InitializationSettings(android: android, iOS: initiallizationSettingsIOS);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initialSetting);

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_notification_channel_id',
    'Notification',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    icon: "logopng",
    playSound: true,
    enableVibration: true,
  );
  const iOSDetails = DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidDetails, iOS: iOSDetails);

  await flutterLocalNotificationsPlugin.show(0, payload.notification!.title,
      payload.notification!.body, platformChannelSpecifics);
  getit<NotificationCubit>().getNotifications();

  // Navigate to a new screen after showing the notification

  await flutterLocalNotificationsPlugin.initialize(initialSetting,
      onDidReceiveNotificationResponse: (id) async {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(Routes.homeLayout, (route) => false);
    navigatorKey.currentState
        ?.pushNamed(typeNotificationNavigation(payload.data['type']));
  }, onDidReceiveBackgroundNotificationResponse: (id) async {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(Routes.homeLayout, (route) => false);
    navigatorKey.currentState?.pushNamed(Routes.notifications);
  });
}
