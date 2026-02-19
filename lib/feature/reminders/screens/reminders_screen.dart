import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/services/notification_service.dart';

import '../models/reminder_model.dart';
import '../services/reminder_service.dart';
import '../widgets/reminder_form.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final ReminderService _reminderService = ReminderService();
  List<ReminderModel> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    try {
      setState(() {
        _isLoading = true;
      });

      _reminders = await _reminderService.getAllReminders();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء تحميل التذكيرات'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.grey1,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'التذكيرات',
                style: TextStyles.cairo_24_bold.copyWith(
                  color: appColors.blue100,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appColors.primaryColorYellow,
                      appColors.darkYellow90,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () async {
                  // اختبار الإشعارات
                  final notificationService = NotificationService();
                  await notificationService.showTestNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم إرسال إشعار تجريبي'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'اختبار الإشعارات',
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: _isLoading
                ? const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _reminders.isEmpty
                    ? SliverFillRemaining(
                        child: _buildEmptyState(),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ReminderCard(
                            reminder: _reminders[index],
                            onDelete: () => _deleteReminder(index),
                          ).animate().fadeIn(
                                duration: Duration(milliseconds: 300),
                                delay: Duration(milliseconds: index * 50),
                              ),
                          childCount: _reminders.length,
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddReminderForm,
        icon: const Icon(Icons.add, color: appColors.white),
        label: Text(
          'تذكير جديد',
          style: TextStyles.cairo_14_bold.copyWith(color: appColors.white),
        ),
        backgroundColor: appColors.primaryColorYellow,
        elevation: 4,
      ).animate().scale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 120,
            color: appColors.grey2,
          )
              .animate()
              .scale(duration: const Duration(milliseconds: 300))
              .then()
              .shake(duration: const Duration(milliseconds: 500)),
          const SizedBox(height: 24),
          Text(
            'لا توجد تذكيرات',
            style: TextStyles.cairo_18_bold.copyWith(
              color: appColors.grey10,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اضغط على زر الإضافة لإنشاء تذكير جديد',
            style: TextStyles.cairo_14_medium.copyWith(
              color: appColors.grey5,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteReminder(int index) async {
    final reminder = _reminders[index];
    setState(() {
      _reminders.removeAt(index);
    });

    try {
      await _reminderService.deleteReminder(reminder.id);
    } catch (e) {
      if (mounted) {
        setState(() {
          _reminders.insert(index, reminder);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('حدث خطأ أثناء حذف التذكير'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'إعادة المحاولة',
              textColor: Colors.white,
              onPressed: () => _deleteReminder(index),
            ),
          ),
        );
      }
    }
  }

  void _showAddReminderForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReminderForm(
        onSave: (reminder) async {
          try {
            await _reminderService.addReminder(reminder);
            await _loadReminders();
            if (mounted) {
              Navigator.pop(context);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('حدث خطأ أثناء حفظ التذكير'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showEditReminderForm(ReminderModel reminder) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReminderForm(
        initialReminder: reminder,
        onSave: (updatedReminder) async {
          try {
            await _reminderService.updateReminder(updatedReminder);
            await _loadReminders();
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تحديث التذكير بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('حدث خطأ أثناء تحديث التذكير'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback onDelete;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد لون الخلفية حسب نوع التكرار
    List<Color> gradientColors;
    
    switch (reminder.repeatType) {
      case RepeatType.daily:
        gradientColors = [
          appColors.white,
          Colors.blue.withOpacity(0.1),
        ];
        break;
      case RepeatType.weekly:
        gradientColors = [
          appColors.white,
          Colors.green.withOpacity(0.1),
        ];
        break;
      case RepeatType.monthly:
        gradientColors = [
          appColors.white,
          Colors.purple.withOpacity(0.1),
        ];
        break;
      default:
        gradientColors = [
          appColors.white,
          appColors.lightYellow10.withOpacity(0.3),
        ];
    }
    
    // تحديد أيقونة التذكير حسب نوع التكرار
    IconData reminderIcon;
    Color iconColor = reminder.isActive ? appColors.primaryColorYellow : appColors.grey5;
    
    switch (reminder.repeatType) {
      case RepeatType.daily:
        reminderIcon = Icons.update;
        break;
      case RepeatType.weekly:
        reminderIcon = Icons.view_week;
        break;
      case RepeatType.monthly:
        reminderIcon = Icons.calendar_view_month;
        break;
      default:
        reminderIcon = Icons.notifications_none_rounded;
    }
    
    return Card(
      elevation: 0.4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: reminder.isActive ? appColors.grey2 : Colors.grey.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // تعديل التذكير
          final remindersScreen = context.findAncestorStateOfType<_RemindersScreenState>();
          if (remindersScreen != null) {
            remindersScreen._showEditReminderForm(reminder);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: reminder.isActive 
                          ? iconColor.withOpacity(0.1) 
                          : Colors.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      reminderIcon,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                reminder.title,
                                style: TextStyles.cairo_16_bold.copyWith(
                                  color: reminder.isActive ? appColors.blue100 : appColors.grey5,
                                ),
                              ),
                            ),
                            if (reminder.repeatType != RepeatType.none)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getRepeatTypeColor().withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _getRepeatTypeText(reminder.repeatType),
                                  style: TextStyles.cairo_10_medium.copyWith(
                                    color: _getRepeatTypeColor(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (reminder.description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            reminder.description,
                            style: TextStyles.cairo_14_regular.copyWith(
                              color: reminder.isActive ? appColors.grey10 : appColors.grey5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDivider(),
              const SizedBox(height: 12),
              _buildReminderInfo(context),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButtons(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: appColors.grey2.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              reminder.isActive ? Icons.notifications_active : Icons.notifications_off,
              color: reminder.isActive ? appColors.primaryColorYellow : appColors.grey5,
            ),
            onPressed: () {
              final remindersScreen = context.findAncestorStateOfType<_RemindersScreenState>();
              if (remindersScreen != null) {
                remindersScreen._reminderService.toggleReminderActive(
                  reminder.id, 
                  !reminder.isActive
                ).then((_) {
                  remindersScreen._loadReminders();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        reminder.isActive 
                            ? 'تم إيقاف التذكير' 
                            : 'تم تفعيل التذكير'
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                });
              }
            },
            tooltip: reminder.isActive ? 'إيقاف التذكير' : 'تفعيل التذكير',
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: appColors.red5.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.delete_outline),
            color: appColors.red,
            onPressed: onDelete,
            tooltip: 'حذف التذكير',
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appColors.grey2,
            appColors.grey2.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // عرض الوقت دائماً لأنه مهم في جميع أنواع التذكيرات
              Expanded(
                child: _buildTimeInfo(),
              ),
              
              // عرض التاريخ فقط للتذكيرات غير المتكررة
              if (reminder.repeatType == RepeatType.none)
                Expanded(
                  child: _buildDateInfo(),
                ),
            ],
          ),
          
          // عرض تفاصيل التكرار للتذكيرات المتكررة
          if (reminder.repeatType != RepeatType.none) ...[
            const SizedBox(height: 8),
            _buildRepeatInfo(),
          ],
        ],
      ),
    );
  }
  
  Widget _buildTimeInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.access_time,
            size: 14,
            color: appColors.primaryColorYellow,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الوقت',
              style: TextStyles.cairo_10_regular.copyWith(
                color: appColors.grey5,
              ),
            ),
            Text(
              _formatDateTime(reminder.dateTime),
              style: TextStyles.cairo_12_medium.copyWith(
                color: appColors.grey10,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildDateInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.calendar_today,
            size: 14,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'التاريخ',
              style: TextStyles.cairo_10_regular.copyWith(
                color: appColors.grey5,
              ),
            ),
            Text(
              _formatDate(reminder.dateTime),
              style: TextStyles.cairo_12_medium.copyWith(
                color: appColors.grey10,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildRepeatInfo() {
    Color repeatColor = _getRepeatTypeColor();
    IconData repeatIcon;
    String repeatTitle;
    String repeatValue;
    
    switch (reminder.repeatType) {
      case RepeatType.daily:
        repeatIcon = Icons.update;
        repeatTitle = 'تكرار يومي';
        repeatValue = 'كل يوم في نفس الوقت';
        break;
      case RepeatType.weekly:
        repeatIcon = Icons.view_week;
        repeatTitle = 'تكرار أسبوعي';
        if (reminder.repeatDays.isEmpty) {
          repeatValue = 'يوم ${_getWeekDayName(reminder.dateTime.weekday)} من كل أسبوع';
        } else {
          repeatValue = 'أيام: ${_formatWeekDays(reminder.repeatDays)}';
        }
        break;
      case RepeatType.monthly:
        repeatIcon = Icons.calendar_view_month;
        repeatTitle = 'تكرار شهري';
        if (reminder.repeatDays.isEmpty) {
          repeatValue = 'يوم ${reminder.dateTime.day} من كل شهر';
        } else {
          repeatValue = 'أيام: ${reminder.repeatDays.join('، ')} من كل شهر';
        }
        break;
      default:
        repeatIcon = Icons.repeat;
        repeatTitle = 'تكرار';
        repeatValue = '';
    }
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: repeatColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            repeatIcon,
            size: 14,
            color: repeatColor,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repeatTitle,
                style: TextStyles.cairo_10_regular.copyWith(
                  color: appColors.grey5,
                ),
              ),
              Text(
                repeatValue,
                style: TextStyles.cairo_12_medium.copyWith(
                  color: repeatColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  String _getWeekDayName(int weekday) {
    final weekDays = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    return weekDays[weekday - 1];
  }

  String _formatWeekDays(List<int> days) {
    final weekDays = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    
    return days.map((day) => weekDays[day - 1]).join('، ');
  }

  String _formatDateTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'ص' : 'م';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }

  String _getRepeatTypeText(RepeatType type) {
    switch (type) {
      case RepeatType.daily:
        return 'يومياً';
      case RepeatType.weekly:
        return 'أسبوعياً';
      case RepeatType.monthly:
        return 'شهرياً';
      default:
        return '';
    }
  }
  
  Widget _buildRepeatDaysInfo() {
    if (reminder.repeatType == RepeatType.weekly && reminder.repeatDays.isNotEmpty) {
      final days = _formatWeekDays(reminder.repeatDays);
      return Row(
        children: [
          const Icon(
            Icons.view_week,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 4),
          Text(
            'أيام: $days',
            style: TextStyles.cairo_12_medium.copyWith(
              color: Colors.green,
            ),
          ),
        ],
      );
    } else if (reminder.repeatType == RepeatType.monthly && reminder.repeatDays.isNotEmpty) {
      final days = reminder.repeatDays.join('، ');
      return Row(
        children: [
          const Icon(
            Icons.calendar_view_month,
            size: 16,
            color: Colors.purple,
          ),
          const SizedBox(width: 4),
          Text(
            'أيام: $days',
            style: TextStyles.cairo_12_medium.copyWith(
              color: Colors.purple,
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Color _getRepeatTypeColor() {
    switch (reminder.repeatType) {
      case RepeatType.daily:
        return Colors.blue;
      case RepeatType.weekly:
        return Colors.green;
      case RepeatType.monthly:
        return Colors.purple;
      default:
        return appColors.primaryColorYellow;
    }
  }
}
