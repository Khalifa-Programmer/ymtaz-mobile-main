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

  // إعدادات تفاصيل الأندرويد لضمان ظهور النص من الأعلى
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel', // معرف قناة جديد أو مميز
    'High Importance Notifications', // اسم القناة
    importance: Importance.max, // ضروري جداً لظهور الإشعار من الأعلى
    priority: Priority.high, // ضروري جداً
    ticker: 'ticker',
    icon: "logopng",
    fullScreenIntent:
        true, // اختيارية: تساعد في بعض الإصدارات لإظهار المحتوى فوراً
    enableVibration: true, // تفعيل التنبيه المرئي
    channelShowBadge: true, // إظهار الرقم على أيقونة التطبيق
    playSound: true, // تفعيل الصوت
  );

  const iOSDetails = DarwinNotificationDetails(
    presentAlert: true, // ضروري لـ iOS لإظهار الإشعار أثناء فتح التطبيق
    presentSound: true,
    presentBadge: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidDetails, iOS: iOSDetails);

  // إظهار الإشعار باستخدام البيانات القادمة من RemoteMessage
  await flutterLocalNotificationsPlugin.show(
    DateTime.now()
        .millisecond, // استخدام معرف فريد لكل إشعار لكي لا يختفي القديم
    payload.notification?.title ?? "عنوان الإشعار",
    payload.notification?.body ?? "محتوى الإشعار",
    platformChannelSpecifics,
  );

  getit<NotificationCubit>().getNotifications();

  // عملية الـ Initialize للضغط على الإشعار
  await flutterLocalNotificationsPlugin.initialize(initialSetting,
      onDidReceiveNotificationResponse: (details) async {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(Routes.homeLayout, (route) => false);
    navigatorKey.currentState
        ?.pushNamed(typeNotificationNavigation(payload.data['type']));
  });
}
