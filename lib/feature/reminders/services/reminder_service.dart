import 'package:hive_flutter/hive_flutter.dart';
import 'package:yamtaz/core/services/notification_service.dart';

import '../models/reminder_model.dart';

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  static const String _boxName = 'reminders_box';
  Box<ReminderModel>? _box;
  bool _initialized = false;
  final NotificationService _notificationService = NotificationService();

  factory ReminderService() {
    return _instance;
  }

  ReminderService._internal();

  Future<void> init() async {
    if (_initialized) return;

    try {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ReminderModelAdapter());
        print('Registered ReminderModelAdapter');
      }_box = await Hive.openBox<ReminderModel>(_boxName);
      _initialized = true;
      print('Opened Hive box successfully. Box length: ${_box?.length}');
      await _rescheduleActiveReminders();
    } catch (e, stackTrace) {
      print('Error initializing Hive: $e');
      print('Stack trace: $stackTrace');
      _initialized = false;
      rethrow;
    }
  }

  Future<void> _rescheduleActiveReminders() async {
    try {
      final reminders = await getAllReminders();
      final now = DateTime.now();
      
      for (final reminder in reminders) {
        if (reminder.isActive && reminder.dateTime.isAfter(now)) {
          await _notificationService.scheduleReminder(reminder);
          print('Rescheduled reminder: ${reminder.id}');
        }
      }
    } catch (e) {
      print('Error rescheduling reminders: $e');
    }
  }

  Future<Box<ReminderModel>> _getBox() async {
    if (!_initialized || _box == null || !_box!.isOpen) {
      await init();
    }
    if (_box == null || !_box!.isOpen) {
      throw Exception('Hive box is not available');
    }
    return _box!;
  }

  Future<void> addReminder(ReminderModel reminder) async {
    try {
      final box = await _getBox();
      await box.put(reminder.id, reminder);
      print('Saved reminder with ID: ${reminder.id}');
      print('Current box contents: ${box.values.length} items');
      await _notificationService.scheduleReminder(reminder);
    } catch (e, stackTrace) {
      print('Error saving reminder: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    try {
      final box = await _getBox();
      
      await _notificationService.cancelReminder(reminder.id);
      
      // Update reminder in database
      await box.put(reminder.id, reminder);
      
      // Schedule new notification if reminder is active
      if (reminder.isActive) {
        await _notificationService.scheduleReminder(reminder);
      }
      
      print('Updated reminder with ID: ${reminder.id}');
    } catch (e) {
      print('Error updating reminder: $e');
      rethrow;
    }
  }

  Future<void> toggleReminderActive(String id, bool isActive) async {
    try {
      final box = await _getBox();
      final reminder = box.get(id);
      
      if (reminder != null) {
        // Create updated reminder
        final updatedReminder = ReminderModel(
          id: reminder.id,
          title: reminder.title,
          description: reminder.description,
          dateTime: reminder.dateTime,
          isActive: isActive,
        );
        
        // Update in database
        await box.put(id, updatedReminder);
        
        // Handle notification
        if (isActive) {
          await _notificationService.scheduleReminder(updatedReminder);
        } else {
          await _notificationService.cancelReminder(id);
        }
      }
    } catch (e) {
      print('Error toggling reminder active state: $e');
      rethrow;
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      final box = await _getBox();
      await box.delete(id);
      await _notificationService.cancelReminder(id);
      print('Deleted reminder with ID: $id');
    } catch (e) {
      print('Error deleting reminder: $e');
      rethrow;
    }
  }

  Future<List<ReminderModel>> getAllReminders() async {
    try {
      final box = await _getBox();
      final reminders = box.values.toList();
      
      // Sort reminders by date (newest first)
      reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      
      print('Retrieved ${reminders.length} reminders from box');
      return reminders;
    } catch (e, stackTrace) {
      print('Error getting reminders: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  Future<ReminderModel?> getReminderById(String id) async {
    try {
      final box = await _getBox();
      return box.get(id);
    } catch (e) {
      print('Error getting reminder by ID: $e');
      return null;
    }
  }

  Future<void> dispose() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
    }
    _initialized = false;
  }
}
