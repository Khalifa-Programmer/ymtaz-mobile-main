import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yamtaz/config/themes/localization.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/local_notification.dart' as local_notification;
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/app_router.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/shared/notofication/notification.dart';
import 'package:yamtaz/firebase_options.dart';
import 'package:yamtaz/yamtaz.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feature/reminders/models/reminder_model.dart';
import 'feature/reminders/services/reminder_service.dart';
import 'package:yamtaz/core/services/notification_service.dart';
import 'package:flutter/services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // طلب إذن الإشعارات لأندرويد 13 فما فوق
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // 2. إخفاء شريط التنقل (Navigation Bar) وشريط الحالة (Status Bar) بشكل دائم
  // وضع immersiveSticky يجعل الشريط يظهر عند السحب ويختفي تلقائياً دون التأثير على حجم الشاشة
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);


  setGetIt();

  // Initialize Hive first
  await Hive.initFlutter();
  

  // Delete existing box to avoid conflicts
  try {
    await Hive.deleteBoxFromDisk('reminders');
  } catch (e) {
    if (kDebugMode) {
      print('No existing box to delete');
    }
  }
  
  // Register Hive adapters
  try {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ReminderModelAdapter());
      if (kDebugMode) {
        print('ReminderModel adapter registered successfully');
      }
    }
    
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(RepeatTypeAdapter());
      if (kDebugMode) {
        print('RepeatType adapter registered successfully');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error registering Hive adapters: $e');
    }
  }

  // Initialize reminder service
  try {
    await ReminderService().init();
    if (kDebugMode) {
      print('Reminder service initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing reminder service: $e');
    }
  }
  
  // Initialize notification service
  try {
    await NotificationService().init();
    if (kDebugMode) {
      print('Notification service initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing notification service: $e');
    }
  }

  // Initialize other services
  await CacheHelper.init();
  
  // Initialize timezone data
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  // Rest of initialization
  await EasyLocalization.ensureInitialized();
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

  try{
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  }catch(e){
    debugPrint('Error initializing Firebase Analytics: $e');
  }
  
  debugPrint('Firebase initialized successfully');

  try {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.setForegroundNotificationPresentationOptions(
      alert: true, 
      badge: true, 
      sound: true
    );

    String? token = await messaging.getToken();
    if (token != null) {
      await CacheHelper.saveData(key: "FCM", value: token);
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase Messaging: $e');
    }
  }

  if(Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  await local_notification.NotificationService().initNotification();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

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
    // print('Permission granted: ${settings.authorizationStatus}');
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: LocalizationsData.supportedLanguages,
      fallbackLocale: LocalizationsData.supportedLanguages.first,
      startLocale: LocalizationsData.supportedLanguages.first,
      child: Yamtaz(
        appRouter: AppRouter(), 
        initialRoute: Routes.splash,
        navigatorKey: navigatorKey,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ...existing code...
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en', 'US'), // Force English locale
      supportedLocales: const [
        Locale('en', 'US'),
      ],
    );
  }
}
