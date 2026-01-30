import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../models/reminder_model.dart';

class ReminderForm extends StatefulWidget {
  final Function(ReminderModel) onSave;
  final ReminderModel? initialReminder;

  const ReminderForm({
    Key? key, 
    required this.onSave, 
    this.initialReminder,
  }) : super(key: key);

  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<int> _selectedDays = [];
  RepeatType _repeatType = RepeatType.none;
  String? _titleError;
  bool _showValidationErrors = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.initialReminder != null) {
      _titleController.text = widget.initialReminder!.title;
      _descriptionController.text = widget.initialReminder!.description;
      _selectedDate = widget.initialReminder!.dateTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.initialReminder!.dateTime);
      _repeatType = widget.initialReminder!.repeatType;
      _selectedDays = List.from(widget.initialReminder!.repeatDays);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildTitleInput(),
                const SizedBox(height: 16),
                _buildDescriptionInput(),
                const SizedBox(height: 20),
                _buildDateTimePicker(),
                const SizedBox(height: 20),
                _buildRepeatTypePicker(),
                if (_repeatType != RepeatType.none) ...[
                  const SizedBox(height: 16),
                  _buildRepeatDaysPicker(),
                ],
                const SizedBox(height: 30),
                _buildSaveButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.initialReminder == null ? 'إضافة تذكير جديد' : 'تعديل التذكير',
          style: TextStyles.cairo_18_bold.copyWith(
            color: appColors.blue100,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عنوان التذكير',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _titleController,
          placeholder: 'أدخل عنوان التذكير',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: _titleError != null && _showValidationErrors
                ? Border.all(color: Colors.red)
                : null,
          ),
        ),
        if (_titleError != null && _showValidationErrors)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _titleError!,
              style: TextStyles.cairo_12_regular.copyWith(
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وقت وتاريخ التذكير',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _showDatePicker,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: appColors.grey10,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
                        style: TextStyles.cairo_14_regular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: _showTimePicker,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: appColors.grey10,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(_selectedTime),
                        style: TextStyles.cairo_14_regular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRepeatTypePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تكرار التذكير',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildRepeatTypeOption(RepeatType.none, 'بدون تكرار'),
              const Divider(height: 1),
              _buildRepeatTypeOption(RepeatType.daily, 'يومي'),
              const Divider(height: 1),
              _buildRepeatTypeOption(RepeatType.weekly, 'أسبوعي'),
              const Divider(height: 1),
              _buildRepeatTypeOption(RepeatType.monthly, 'شهري'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRepeatTypeOption(RepeatType type, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _repeatType = type;
          if (type == RepeatType.none) {
            _selectedDays = [];
          } else if (type == RepeatType.weekly && _selectedDays.isEmpty) {
            _selectedDays = [_selectedDate.weekday];
          } else if (type == RepeatType.monthly && _selectedDays.isEmpty) {
            _selectedDays = [_selectedDate.day];
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyles.cairo_14_regular,
            ),
            const Spacer(),
            if (_repeatType == type)
              const Icon(
                Icons.check_circle,
                color: appColors.primaryColorYellow,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatDaysPicker() {
    if (_repeatType == RepeatType.weekly) {
      return _buildWeekDaysPicker();
    } else if (_repeatType == RepeatType.monthly) {
      return _buildMonthDaysPicker();
    }
    return const SizedBox.shrink();
  }

  Widget _buildWeekDaysPicker() {
    final weekDays = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أيام التكرار',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(7, (index) {
            final day = index + 1;
            final isSelected = _selectedDays.contains(day);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    if (_selectedDays.length > 1) {
                      _selectedDays.remove(day);
                    }
                  } else {
                    _selectedDays.add(day);
                  }
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? appColors.primaryColorYellow
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weekDays[index],
                  style: TextStyles.cairo_12_medium.copyWith(
                    color: isSelected ? Colors.white : appColors.grey10,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMonthDaysPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أيام الشهر للتكرار',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isSelected = _selectedDays.contains(day);
              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      if (_selectedDays.length > 1) {
                        _selectedDays.remove(day);
                      }
                    } else {
                      _selectedDays.add(day);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appColors.primaryColorYellow
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? appColors.primaryColorYellow
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyles.cairo_12_medium.copyWith(
                        color: isSelected ? Colors.white : appColors.grey10,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: appColors.primaryColorYellow,
        borderRadius: BorderRadius.circular(12),
        onPressed: _saveReminder,
        child: Text(
          widget.initialReminder == null ? 'إضافة التذكير' : 'حفظ التعديلات',
          style: TextStyles.cairo_16_bold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appColors.primaryColorYellow,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appColors.primaryColorYellow,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'ص' : 'م';
    return '$hour:$minute $period';
  }

  void _validateForm() {
    setState(() {
      _showValidationErrors = true;
      _titleError = _titleController.text.trim().isEmpty
          ? 'يرجى إدخال عنوان للتذكير'
          : null;
    });
  }

  void _saveReminder() {
    _validateForm();

    if (_titleError != null) return;

    final DateTime now = DateTime.now();
    final DateTime reminderDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (reminderDateTime.isBefore(now) && _repeatType == RepeatType.none) {
      _showError('لا يمكن إضافة تذكير في وقت سابق');
      return;
    }

    final reminder = ReminderModel(
      id: widget.initialReminder?.id ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dateTime: reminderDateTime,
      repeatType: _repeatType,
      repeatDays: _selectedDays,
    );

    widget.onSave(reminder);
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'تنبيه',
          style: TextStyles.cairo_16_bold,
        ),
        content: Text(
          message,
          style: TextStyles.cairo_14_regular,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'حسناً',
              style: TextStyles.cairo_14_medium.copyWith(
                color: appColors.primaryColorYellow,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وصف التذكير',
          style: TextStyles.cairo_14_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _descriptionController,
          placeholder: 'وصف التذكير (اختياري)',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          minLines: 3,
          maxLines: 5,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
