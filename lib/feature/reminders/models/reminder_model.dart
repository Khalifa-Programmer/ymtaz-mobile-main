import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

/// نوع التكرار للتذكير
@HiveType(typeId: 1)
enum RepeatType {
  @HiveField(0)
  none, // بدون تكرار

  @HiveField(1)
  daily, // يومي

  @HiveField(2)
  weekly, // أسبوعي

  @HiveField(3)
  monthly, // شهري
}

@HiveType(typeId: 0)
class ReminderModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final RepeatType repeatType;

  @HiveField(6)
  final List<int> repeatDays; // أيام الأسبوع للتكرار الأسبوعي (1-7) أو أيام الشهر للتكرار الشهري (1-31)

  ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isActive = true,
    this.repeatType = RepeatType.none,
    this.repeatDays = const [],
  });

  /// إنشاء نسخة جديدة من التذكير مع تحديث بعض الحقول
  ReminderModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isActive,
    RepeatType? repeatType,
    List<int>? repeatDays,
  }) {
    return ReminderModel(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isActive: isActive ?? this.isActive,
      repeatType: repeatType ?? this.repeatType,
      repeatDays: repeatDays ?? this.repeatDays,
    );
  }
}
