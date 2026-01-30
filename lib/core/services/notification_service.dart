import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yamtaz/config/themes/styles.dart';

import '../../feature/reminders/models/reminder_model.dart';
import '../../main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> init() async {
    if (_initialized) return;

    await _setupNotificationChannels();
    await _requestPermissions();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: null,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
    print('Notifications initialized successfully');
  }

  Future<void> _setupNotificationChannels() async {
    if (Platform.isAndroid) {
      // قناة التذكيرات العامة
      const AndroidNotificationChannel remindersChannel =
          AndroidNotificationChannel(
        'reminders_channel',
        'التذكيرات',
        description: 'إشعارات التذكيرات والمواعيد',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      );

      // قناة التذكيرات اليومية
      const AndroidNotificationChannel dailyRemindersChannel =
          AndroidNotificationChannel(
        'daily_reminders_channel',
        'التذكيرات اليومية',
        description: 'إشعارات التذكيرات اليومية',
        importance: Importance.high,
      );

      // قناة التذكيرات الأسبوعية
      const AndroidNotificationChannel weeklyRemindersChannel =
          AndroidNotificationChannel(
        'weekly_reminders_channel',
        'التذكيرات الأسبوعية',
        description: 'إشعارات التذكيرات الأسبوعية',
        importance: Importance.high,
      );

      // قناة التذكيرات الشهرية
      const AndroidNotificationChannel monthlyRemindersChannel =
          AndroidNotificationChannel(
        'monthly_reminders_channel',
        'التذكيرات الشهرية',
        description: 'إشعارات التذكيرات الشهرية',
        importance: Importance.high,
      );

      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(remindersChannel);
        await androidPlugin.createNotificationChannel(dailyRemindersChannel);
        await androidPlugin.createNotificationChannel(weeklyRemindersChannel);
        await androidPlugin.createNotificationChannel(monthlyRemindersChannel);
      }
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final context = navigatorKey.currentContext;
      if (context == null) return;

      final granted = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildPermissionDialog(context),
      );

      if (granted ?? false) {
        await _notifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

        await _notifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission();
      }
    }
  }

  Widget _buildPermissionDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'السماح بالتنبيهات',
        style: TextStyles.cairo_16_bold,
        textAlign: TextAlign.right,
      ),
      content: Text(
        'يحتاج التطبيق إلى إذن لإرسال التنبيهات للتذكيرات. هل تريد السماح بذلك؟',
        style: TextStyles.cairo_14_regular,
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'رفض',
            style: TextStyles.cairo_14_medium.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            'السماح',
            style: TextStyles.cairo_14_bold.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
    // TODO: يمكن إضافة التنقل إلى شاشة التذكيرات هنا
  }

  Future<void> scheduleReminder(ReminderModel reminder) async {
    try {
      final now = DateTime.now();
      if (reminder.dateTime.isBefore(now) && reminder.repeatType == RepeatType.none) {
        print('Cannot schedule notification in the past');
        return;
      }

      // إلغاء الإشعارات السابقة لهذا التذكير
      await cancelReminder(reminder.id);

      switch (reminder.repeatType) {
        case RepeatType.none:
          await _scheduleOnceReminder(reminder);
          break;
        case RepeatType.daily:
          await _scheduleDailyReminder(reminder);
          break;
        case RepeatType.weekly:
          await _scheduleWeeklyReminder(reminder);
          break;
        case RepeatType.monthly:
          await _scheduleMonthlyReminder(reminder);
          break;
      }

      print('تم جدولة الإشعار بنجاح للتذكير: ${reminder.title}');
    } catch (e) {
      print('خطأ في جدولة الإشعار: $e');
    }
  }

  Future<void> _scheduleOnceReminder(ReminderModel reminder) async {
    final tzDateTime = tz.TZDateTime.from(reminder.dateTime, tz.local);
    
    if (tzDateTime.isBefore(tz.TZDateTime.now(tz.local))) {
      print('Cannot schedule one-time notification in the past');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      'reminders_channel',
      'التذكيرات',
      channelDescription: 'إشعارات التذكيرات والمواعيد',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(reminder.description),
      category: AndroidNotificationCategory.reminder,
      visibility: NotificationVisibility.public,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.aiff',
      threadIdentifier: 'reminders',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      reminder.id.hashCode,
      reminder.title,
      reminder.description.isEmpty
          ? 'حان موعد التذكير'
          : reminder.description,
      tzDateTime,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: reminder.id,
    );
  }

  Future<void> _scheduleDailyReminder(ReminderModel reminder) async {
    final time = reminder.dateTime;
    
    // إنشاء وقت اليوم للتذكير
    final scheduledDate = tz.TZDateTime(
      tz.local,
      tz.TZDateTime.now(tz.local).year,
      tz.TZDateTime.now(tz.local).month,
      tz.TZDateTime.now(tz.local).day,
      time.hour,
      time.minute,
    );
    
    // إذا كان الوقت قد مر اليوم، جدول للغد
    final tzDateTime = scheduledDate.isBefore(tz.TZDateTime.now(tz.local))
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    final androidDetails = AndroidNotificationDetails(
      'daily_reminders_channel',
      'التذكيرات اليومية',
      channelDescription: 'إشعارات التذكيرات اليومية',
      importance: Importance.high,
      priority: Priority.high,
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      reminder.id.hashCode,
      reminder.title,
      reminder.description.isEmpty
          ? 'تذكير يومي'
          : reminder.description,
      tzDateTime,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: reminder.id,
    );
  }

  Future<void> _scheduleWeeklyReminder(ReminderModel reminder) async {
    final time = reminder.dateTime;
    List<int> days = reminder.repeatDays;
    
    // إذا لم يتم تحديد أيام، استخدم يوم التذكير الأصلي
    if (days.isEmpty) {
      days = [time.weekday];
    }

    for (final day in days) {
      // تأكد من أن اليوم صالح (1-7)
      if (day < 1 || day > 7) continue;
      
      // إنشاء وقت للتذكير في اليوم المحدد
      final scheduledDate = _nextInstanceOfWeekday(time, day);

      final androidDetails = AndroidNotificationDetails(
        'weekly_reminders_channel',
        'التذكيرات الأسبوعية',
        channelDescription: 'إشعارات التذكيرات الأسبوعية',
        importance: Importance.high,
        priority: Priority.high,
      );

      final iosDetails = const DarwinNotificationDetails();

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        '${reminder.id.hashCode}_$day'.hashCode,
        reminder.title,
        reminder.description.isEmpty
            ? 'تذكير أسبوعي'
            : reminder.description,
        scheduledDate,
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: reminder.id,
      );
    }
  }

  Future<void> _scheduleMonthlyReminder(ReminderModel reminder) async {
    final time = reminder.dateTime;
    List<int> days = reminder.repeatDays;
    
    // إذا لم يتم تحديد أيام، استخدم يوم التذكير الأصلي
    if (days.isEmpty) {
      days = [time.day];
    }

    for (final day in days) {
      // تأكد من أن اليوم صالح (1-31)
      if (day < 1 || day > 31) continue;
      
      // إنشاء وقت للتذكير في اليوم المحدد من الشهر
      final scheduledDate = _nextInstanceOfMonthDay(time, day);

      final androidDetails = AndroidNotificationDetails(
        'monthly_reminders_channel',
        'التذكيرات الشهرية',
        channelDescription: 'إشعارات التذكيرات الشهرية',
        importance: Importance.high,
        priority: Priority.high,
      );

      final iosDetails = const DarwinNotificationDetails();

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        '${reminder.id.hashCode}_$day'.hashCode,
        reminder.title,
        reminder.description.isEmpty
            ? 'تذكير شهري'
            : reminder.description,
        scheduledDate,
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
        payload: reminder.id,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfWeekday(DateTime time, int weekday) {
    final now = tz.TZDateTime.now(tz.local);
    
    // إنشاء تاريخ بنفس الوقت اليوم
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    
    // حساب عدد الأيام حتى اليوم المطلوب من الأسبوع
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    // إذا كان الوقت قد مر اليوم، أضف أسبوع
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }
    
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMonthDay(DateTime time, int day) {
    final now = tz.TZDateTime.now(tz.local);
    
    // إنشاء تاريخ لليوم المحدد من الشهر الحالي
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      min(day, _daysInMonth(now.year, now.month)),
      time.hour,
      time.minute,
    );
    
    // إذا كان التاريخ في الماضي، انتقل للشهر التالي
    if (scheduledDate.isBefore(now)) {
      // الانتقال للشهر التالي
      int nextMonth = now.month + 1;
      int year = now.year;
      
      if (nextMonth > 12) {
        nextMonth = 1;
        year++;
      }
      
      scheduledDate = tz.TZDateTime(
        tz.local,
        year,
        nextMonth,
        min(day, _daysInMonth(year, nextMonth)),
        time.hour,
        time.minute,
      );
    }
    
    return scheduledDate;
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }

  Future<void> cancelReminder(String id) async {
    try {
      // إلغاء الإشعار الأساسي
      await _notifications.cancel(id.hashCode);
      
      // إلغاء الإشعارات المتكررة (للتذكيرات الأسبوعية والشهرية)
      for (int i = 1; i <= 31; i++) {
        await _notifications.cancel('${id.hashCode}_$i'.hashCode);
      }
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }

  Future<void> showTestNotification() async {
    try {
      await _notifications.show(
        0,
        'اختبار الإشعارات',
        'هذا اختبار للتأكد من عمل الإشعارات',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'reminders_channel',
            'التذكيرات',
            channelDescription: 'إشعارات التذكيرات والمواعيد',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            enableVibration: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
      print('تم إرسال إشعار الاختبار');
    } catch (e) {
      print('خطأ في إرسال إشعار الاختبار: $e');
    }
  }
}

