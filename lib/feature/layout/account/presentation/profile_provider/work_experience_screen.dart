import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';

import '../../data/models/experience_model.dart';

// Add this utility function at the top of the file
String formatDateToEnglish(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy-MM-dd', 'en_US').format(date);
}

class WorkExperienceScreen extends StatefulWidget {
  WorkExperienceScreen({super.key});

  @override
  State<WorkExperienceScreen> createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  // Initialize as empty list instead of late
  List<Experience> experiences = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    // Load experiences when screen opens
    _loadExperiences();
  }

  void _loadExperiences() {
    context.read<MyAccountCubit>().getMyWorkExperience();
  }

  Future<void> sendAndSave(String action, List<Experience> experience) async {
    final experiences = experience.map((exp) {
      return {
        'title': exp.title ?? '',
        'company': exp.company ?? '',
        'from': getDateEn(exp.from.toString()),
        'to': exp.to != null ? getDateEn(exp.to.toString()) : null,
      };
    }).toList();

    print(experiences);

    await context.read<MyAccountCubit>().addMyWorkExperience(experiences);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم $action بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الخبرات العملية', style: TextStyle(fontSize: 18.sp)),
      ),
      body: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          state.whenOrNull(
            loadingGetAccountExperience: () {
              setState(() {
                isLoading = true;
                error = null;
              });
            },
            successGetAccountExperience: (experiencesResponse) {
              setState(() {
                isLoading = false;
                error = null;
                experiences = experiencesResponse.data?.Experiences ?? [];
              });
            },
            errorGetAccountExperience: (errorMsg) {
              setState(() {
                isLoading = false;
                error = errorMsg;
              });
            },
          );
        },
        builder: (context, state) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(error!),
                  ElevatedButton(
                    onPressed: _loadExperiences,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Expanded(
                  child: experiences.isEmpty
                      ? const Center(
                          child: Text('لا توجد خبرات مضافة'),
                        )
                      : ListView.separated(
                          itemCount: experiences.length,
                          separatorBuilder: (_, __) => SizedBox(height: 5.h),
                          itemBuilder: (context, index) {
                            final exp = experiences[index];
                            return ExperienceCard(
                              experience: exp,
                              onEdit: () => _editExperience(index),
                              onDelete: () => _deleteExperience(index),
                            );
                          },
                        ),
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  onPress: _addExperience,
                  title: 'إضافة خبرة جديدة',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addExperience() async {
    final result = await showDialog<Experience>(
      context: context,
      builder: (context) => const ExperienceDialog(),
    );

    if (result != null) {
      final experience = {
        'title': result.title ?? '',
        'company': result.company ?? '',
        'from': result.from ?? '',
        'to': result.to, // Remove ?? '' to allow null
      };
      setState(() {
        experiences.add(result);
      });
      await sendAndSave('الاضافة', experiences);
    }
  }

  void _editExperience(int index) async {
    final result = await showDialog<Experience>(
      context: context,
      builder: (context) => ExperienceDialog(
        experience: experiences[index],
      ),
    );

    if (result != null) {
      setState(() {
        experiences[index] = result;
      });
      await sendAndSave('التعديل', experiences);
    }
  }

  void _deleteExperience(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الخبرة'),
        content: const Text('هل أنت متأكد من حذف هذه الخبرة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              final deletedExperience = experiences[index];
              setState(() {
                experiences.removeAt(index);
              });
              Navigator.pop(context);
              await sendAndSave('الحذف', experiences);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    experience.title ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              experience.company ?? '',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              '${formatDateToEnglish(experience.from)} - ${experience.to != null ? formatDateToEnglish(experience.to) : 'حتى الآن'}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceDialog extends StatefulWidget {
  final Experience? experience;

  const ExperienceDialog({super.key, this.experience});

  @override
  State<ExperienceDialog> createState() => _ExperienceDialogState();
}

class _ExperienceDialogState extends State<ExperienceDialog> {
  late TextEditingController titleController;
  late TextEditingController companyController;
  late DateTime fromDate;
  DateTime? toDate;
  bool isCurrentJob = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final exp = widget.experience;
    titleController = TextEditingController(text: exp?.title ?? '');
    companyController = TextEditingController(text: exp?.company ?? '');
    fromDate = exp?.from ?? DateTime.now();
    toDate = exp?.to;
    isCurrentJob = exp?.to == null;
  }

  @override
  Widget build(BuildContext context) {
    // Use forced locale for consistent date display
    final dateFormat = DateFormat('yyyy-MM-dd', 'en');

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        widget.experience == null ? 'إضافة خبرة' : 'تعديل الخبرة',
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'المسمى الوظيفي',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال المسمى الوظيفي';
                    }
                    if (value.length < 2) {
                      return 'المسمى الوظيفي قصير جداً';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: companyController,
                  decoration: InputDecoration(
                    labelText: 'الشركة',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال اسم الشركة';
                    }
                    if (value.length < 2) {
                      return 'اسم الشركة قصير جداً';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Card(
                  child: ListTile(
                    title: const Text('تاريخ البدء'),
                    subtitle: Text(formatDateToEnglish(fromDate)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(true),
                  ),
                ),
                CheckboxListTile(
                  title: const Text('أعمل هنا حالياً'),
                  value: isCurrentJob,
                  onChanged: (value) {
                    setState(() {
                      isCurrentJob = value ?? false;
                      if (isCurrentJob) {
                        toDate = null;
                      }
                    });
                  },
                ),
                if (!isCurrentJob)
                  Card(
                    child: ListTile(
                      title: const Text('تاريخ الانتهاء'),
                      subtitle: Text(toDate != null
                          ? formatDateToEnglish(toDate)
                          : 'اختر التاريخ'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(false),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: _validateAndSave,
          child: const Text('حفظ'),
        ),
      ],
    );
  }

  Future<void> _selectDate(bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : (toDate ?? DateTime.now()),
      firstDate: DateTime(1960),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'US'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
          // Ensure that toDate is after fromDate
          if (toDate != null && toDate!.isBefore(fromDate)) {
            toDate = null;
          }
        } else {
          if (picked.isAfter(fromDate)) {
            toDate = picked;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء'),
              ),
            );
          }
        }
      });
    }
  }

  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (!isCurrentJob && toDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('برجاء اختيار تاريخ الانتهاء'),
          ),
        );
        return;
      }

      final newExperience = Experience(
        title: titleController.text.trim(),
        company: companyController.text.trim(),
        from: fromDate,
        to: isCurrentJob ? null : toDate,
      );
      Navigator.pop(context, newExperience);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    super.dispose();
  }
}
