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
    super.key,
    required this.onSave,
    this.initialReminder,
  });

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
  
  // متغير جديد لتحديد النغمة
  final String _selectedRingtone = 'نغمة المنبه الافتراضية';

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
            color: appColors.blue100.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 25),
                _buildTitleInput(),
                const SizedBox(height: 16),
                _buildDateTimePicker(),
                const SizedBox(height: 16),
                _buildRingtonePicker(), // القسم الجديد للنغمة
                const SizedBox(height: 16),
                _buildRepeatTypePicker(),
                if (_repeatType != RepeatType.none) ...[
                  const SizedBox(height: 16),
                  _buildRepeatDaysPicker(),
                ],
                const SizedBox(height: 16),
                _buildDescriptionInput(),
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
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          widget.initialReminder == null ? 'ضبط منبه جديد' : 'تعديل المنبه',
          style: TextStyles.cairo_18_bold.copyWith(
            color: appColors.blue100,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.close, color: appColors.blue100),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ماذا تريد أن نتذكر؟', style: TextStyles.cairo_14_medium.copyWith(color: appColors.blue100)),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _titleController,
          placeholder: 'عنوان المنبه (مثلاً: موعد الدواء)',
          placeholderStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: appColors.blue100.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _titleError != null && _showValidationErrors 
                ? Colors.red 
                : appColors.blue100.withOpacity(0.1)
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker() {
    return Row(
      children: [
        Expanded(
          child: _buildPickerTile(
            label: 'التاريخ',
            value: '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
            icon: Icons.calendar_today_outlined,
            onTap: _showDatePicker,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPickerTile(
            label: 'الوقت',
            value: _formatTime(_selectedTime),
            icon: Icons.access_time,
            onTap: _showTimePicker,
          ),
        ),
      ],
    );
  }

  Widget _buildPickerTile({required String label, required String value, required IconData icon, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.cairo_12_medium.copyWith(color: appColors.grey10)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appColors.blue100.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: appColors.blue100.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: appColors.primaryColorYellow),
                const SizedBox(width: 8),
                Text(value, style: TextStyles.cairo_14_regular.copyWith(color: appColors.blue100)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRingtonePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('نغمة التنبيه', style: TextStyles.cairo_14_medium.copyWith(color: appColors.blue100)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            // هنا تفتح قائمة النغمات
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: appColors.blue100.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: appColors.blue100.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.music_note_rounded, color: appColors.primaryColorYellow),
                const SizedBox(width: 10),
                Text(_selectedRingtone, style: TextStyles.cairo_14_regular),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: appColors.blue100.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: CupertinoButton(
        color: appColors.primaryColorYellow,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(15),
        onPressed: _saveReminder,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.alarm_add, color: appColors.blue100),
            const SizedBox(width: 8),
            Text(
              widget.initialReminder == null ? 'تفعيل المنبه الآن' : 'حفظ التعديلات',
              style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
            ),
          ],
        ),
      ),
    );
  }

  // ميثود مساعدة لبناء خيارات التكرار بشكل أجمل
  Widget _buildRepeatTypeOption(RepeatType type, String label) {
    bool isSelected = _repeatType == type;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _repeatType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? appColors.blue100 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyles.cairo_12_medium.copyWith(
                color: isSelected ? Colors.white : appColors.blue100,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRepeatTypePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('التكرار', style: TextStyles.cairo_14_medium.copyWith(color: appColors.blue100)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: appColors.blue100.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildRepeatTypeOption(RepeatType.none, 'مرة'),
              _buildRepeatTypeOption(RepeatType.daily, 'يومي'),
              _buildRepeatTypeOption(RepeatType.weekly, 'أسبوعي'),
              _buildRepeatTypeOption(RepeatType.monthly, 'شهري'),
            ],
          ),
        ),
      ],
    );
  }

  // (بقية الميثودات مثل _showDatePicker, _formatTime, _validateForm تبقى كما هي مع تعديل بسيط في الألوان داخل الثيم)

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
              primary: appColors.blue100, // اللون الكحلي للتقويم
              onPrimary: Colors.white,
              onSurface: appColors.blue100,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: appColors.primaryColorYellow),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) setState(() => _selectedDate = pickedDate);
  }

  void _showTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appColors.blue100,
              onPrimary: Colors.white,
              onSurface: appColors.blue100,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) setState(() => _selectedTime = pickedTime);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'ص' : 'م';
    return '$hour:$minute $period';
  }

  void _saveReminder() {
    setState(() {
      _showValidationErrors = true;
      _titleError = _titleController.text.trim().isEmpty ? 'يرجى إدخال عنوان' : null;
    });

    if (_titleError != null) return;

    final reminder = ReminderModel(
      id: widget.initialReminder?.id ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dateTime: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute),
      repeatType: _repeatType,
      repeatDays: _selectedDays,
    );

    widget.onSave(reminder);
  }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملاحظات إضافية', style: TextStyles.cairo_14_medium.copyWith(color: appColors.blue100)),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _descriptionController,
          placeholder: 'مثلاً: خذ الحبة بعد الأكل مباشرة',
          placeholderStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          padding: const EdgeInsets.all(16),
          minLines: 2,
          maxLines: 3,
          decoration: BoxDecoration(
            color: appColors.blue100.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: appColors.blue100.withOpacity(0.1)),
          ),
        ),
      ],
    );
  }
  
  // دالة بناء أيام الأسبوع والشهر (بنفس منطق الكود القديم لكن بتنسيق ألوان كحلي/ذهبي)
  Widget _buildRepeatDaysPicker() {
     if (_repeatType == RepeatType.weekly) {
      return _buildWeekDaysPicker();
    } else if (_repeatType == RepeatType.monthly) {
      return _buildMonthDaysPicker();
    }
    return const SizedBox.shrink();
  }

  Widget _buildWeekDaysPicker() {
    final weekDays = ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];
    return Wrap(
      spacing: 8,
      children: List.generate(7, (index) {
        final day = index + 1;
        final isSelected = _selectedDays.contains(day);
        return ChoiceChip(
          label: Text(weekDays[index]),
          selected: isSelected,
          onSelected: (val) {
             setState(() {
              if (val) {
                _selectedDays.add(day);
              } else if (_selectedDays.length > 1) _selectedDays.remove(day);
            });
          },
          selectedColor: appColors.primaryColorYellow,
          backgroundColor: appColors.blue100.withOpacity(0.05),
          labelStyle: TextStyle(color: isSelected ? appColors.blue100 : appColors.blue100),
        );
      }),
    );
  }

  Widget _buildMonthDaysPicker() {
     return SizedBox(
       height: 50,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: 31,
         itemBuilder: (context, index) {
           final day = index + 1;
           final isSelected = _selectedDays.contains(day);
           return GestureDetector(
             onTap: () => setState(() => isSelected ? _selectedDays.remove(day) : _selectedDays.add(day)),
             child: Container(
               width: 40,
               margin: const EdgeInsets.only(right: 8),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: isSelected ? appColors.primaryColorYellow : appColors.blue100.withOpacity(0.05),
               ),
               child: Center(child: Text('$day', style: TextStyle(color: appColors.blue100))),
             ),
           );
         },
       ),
     );
  }
}
