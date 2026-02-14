import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:yamtaz/config/themes/localization.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/local_notification.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/app_router.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/shared/notofication/notification.dart';
import 'package:yamtaz/firebase_options.dart';
import 'package:yamtaz/yamtaz.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/services.dart';

import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 2. إخفاء شريط التنقل (Navigation Bar) وشريط الحالة (Status Bar) بشكل دائم
  // وضع immersiveSticky يجعل الشريط يظهر عند السحب ويختفي تلقائياً دون التأثير على حجم الشاشة
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await EasyLocalization.ensureInitialized();

  // FlavorConfig(
  //     name: "DEV",
  //     color: Colors.red,
  //     location: BannerLocation.bottomStart,
  //     variables: {
  //       "baseUrl": "https://dev.api.yamtaz.sa/api/",
  //     }
  // );
  //
  // FlavorConfig(
  //     name: "PROD",
  //     variables: {
  //       "baseUrl": "https://api.yamtaz.sa/api/",
  //     }
  // );

  // Initialize Firebase with a check to prevent duplicate app error
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    debugPrint('Firebase already initialized: $e');
  }
  final messaging = FirebaseMessaging.instance;
  setGetIt();

  await NotificationService().initNotification();
  tz.initializeTimeZones();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);


  String? token = await messaging.getToken();


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      // print('Handling a foreground message: ${message.messageId}');
      // print('Message data: ${message.data}');
      // print('Message notification: ${message.notification?.title}');
      // print('Message notification: ${message.notification?.body}');
    }

    showNotification(message, navigatorKey);
  });

  if (kDebugMode) {
    // print('Registration Token=$token');
  }

  if (kDebugMode) {
    // print('Permission granted: ${settings.authorizationStatus}');
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  await CacheHelper.init();

  CacheHelper.saveData(key: "FCM", value: token);

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: LocalizationsData.supportedLanguages,
      fallbackLocale: LocalizationsData.supportedLanguages.first,
      startLocale: LocalizationsData.supportedLanguages.first,
      child: Yamtaz(appRouter: AppRouter(), initialRoute: Routes.splash, navigatorKey: navigatorKey,)));
}
