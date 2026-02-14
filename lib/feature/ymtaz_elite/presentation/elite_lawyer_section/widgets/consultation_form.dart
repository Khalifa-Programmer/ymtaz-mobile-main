import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_accurate_specialization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_categories_types.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_general_specialization.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../advisory_window/logic/advisory_cubit.dart';
import '../models/service_request.dart';

class ConsultationForm extends StatefulWidget {
  final TextEditingController priceController;
  final Function(BaseServiceRequest) onSuccess;

  const ConsultationForm({
    super.key,
    required this.priceController,
    required this.onSuccess,
  });

  @override
  State<ConsultationForm> createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  String? selectedServiceType;
  String? selectedGeneralSpecialization;
  String? selectedAccurateSpecialization;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    super.initState();
    getit<AdvisoryCubit>().getAdvisoriesTypes();
  }

  void _showError(String message) {
    if (!mounted) return;
    
    // استخدام overlay بدلاً من SnackBar
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 16.w,
        right: 16.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: appColors.red,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  bool _validateInputs() {
    if (selectedServiceType == null) {
      _showError('يرجى اختيار نوع الاستشارة');
      return false;
    }

    if (selectedGeneralSpecialization == null) {
      _showError('يرجى اختيار التخصص العام');
      return false;
    }

    if (selectedAccurateSpecialization == null) {
      _showError('يرجى اختيار التخصص الدقيق');
      return false;
    }

    // Add validation for date/time if advisory type is 2
    if (selectedServiceType == "2") {
      if (selectedDate == null) {
        _showError('يرجى اختيار التاريخ');
        return false;
      }
      if (startTime == null || endTime == null) {
        _showError('يرجى تحديد وقت البداية والنهاية');
        return false;
      }
    }

    if (widget.priceController.text.isEmpty) {
      _showError('يرجى إدخال السعر');
      return false;
    }

    try {
      final price = int.parse(widget.priceController.text);
      if (price <= 0) {
        _showError('يجب أن يكون السعر أكبر من صفر');
        return false;
      }
    } catch (e) {
      _showError('يرجى إدخال سعر صحيح');
      return false;
    }

    return true;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _handleSubmit() {
    if (_validateInputs()) {
      final request = ConsultationRequest(
        advisoryTypeId: selectedServiceType!,
        generalSpecializationId: selectedGeneralSpecialization!,
        accurateSpecializationId: selectedAccurateSpecialization!,
        price: int.parse(widget.priceController.text),
        date: selectedServiceType == "2" && selectedDate != null 
            ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
            : "",
        fromTime: selectedServiceType == "2" && startTime != null 
            ? "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}"
            : "",
        toTime: selectedServiceType == "2" && endTime != null 
            ? "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}"
            : "",
      );
      widget.onSuccess(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<AdvisoryCubit, AdvisoryState>(
            listener: _handleAdvisoryStateChanges,
            builder: (context, state) {
              final cubit = getit<AdvisoryCubit>();
              final types = cubit.advisoriesCategoriesTypes?.data?.items;
              final isLoading = state is AdvisoryTypesLoading || types == null;

              return _buildDropdown(
                hint: 'نوع الاستشارة',
                items: _getAdvisoryTypeItems(types),
                value: selectedServiceType,
                onChanged: _handleAdvisoryTypeSelection,
                isLoading: isLoading,
                enabled: true,
              );
            },
          ),

          if (selectedServiceType != null) ...[
            SizedBox(height: 12.h),
            BlocConsumer<AdvisoryCubit, AdvisoryState>(
              listener: _handleGeneralTypeStateChanges,
              builder: (context, state) {
                final cubit = getit<AdvisoryCubit>();
                final types = cubit.advisoriesGeneralSpecialization?.data;
                final isLoading = state is AdvisoryGeneralTypesLoading || types == null;

                return _buildDropdown(
                  hint: 'التخصص العام',
                  items: _getGeneralTypeItems(types),
                  value: selectedGeneralSpecialization,
                  onChanged: _handleGeneralTypeSelection,
                  isLoading: isLoading,
                  enabled: true,
                );
              },
            ),
          ],

          if (selectedGeneralSpecialization != null) ...[
            SizedBox(height: 12.h),
            BlocConsumer<AdvisoryCubit, AdvisoryState>(
              listener: _handleAccurateTypeStateChanges,
              builder: (context, state) {
                final cubit = getit<AdvisoryCubit>();
                final types = cubit.advisoriesAccurateSpecialization?.data?.subCategories;
                final isLoading = state is AdvisoryAccurateTypesLoading || types == null;

                return _buildDropdown(
                  hint: 'التخصص الدقيق',
                  items: _getAccurateTypeItems(types),
                  value: selectedAccurateSpecialization,
                  onChanged: _handleAccurateTypeSelection,
                  isLoading: isLoading,
                  enabled: true,
                );
              },
            ),
          ],

          if (selectedServiceType == "2") ...[
            SizedBox(height: 16.h),
            _buildDateTimeSelection(),
          ],

          SizedBox(height: 16.h),
          _buildPriceInput(),
          SizedBox(height: 16.h),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  void _handleAdvisoryStateChanges(BuildContext context, AdvisoryState state) {
    if (state is AdvisoryTypesError) {
      _showError('حدث خطأ في تحميل أنواع الاستشارات');
    }
  }

  void _handleGeneralTypeStateChanges(BuildContext context, AdvisoryState state) {
    if (state is AdvisoryGeneralTypesError) {
      _showError('حدث خطأ في تحميل التخصصات العامة');
    }
  }

  void _handleAccurateTypeStateChanges(BuildContext context, AdvisoryState state) {
    if (state is AdvisoryAccurateTypesError) {
      _showError('حدث خطأ في تحميل التخصصات الدقيقة');
    }
  }

  List<DropdownMenuItem<String>> _getAdvisoryTypeItems(List<Item>? types) {
    return types?.map((item) => DropdownMenuItem(
      value: item.id.toString(),
      child: Text(item.name ?? ''),
    )).toList() ?? [];
  }

  List<DropdownMenuItem<String>> _getGeneralTypeItems(List<AdvisoriesGeneralData>? types) {
    return types?.map((item) => DropdownMenuItem(
      value: item.id.toString(),
      child: Text(item.name ?? ''),
    )).toList() ?? [];
  }

  List<DropdownMenuItem<String>> _getAccurateTypeItems(List<SubCategory>? types) {
    return types?.map((item) => DropdownMenuItem(
      value: item.id.toString(),
      child: Text(item.name ?? ''),
    )).toList() ?? [];
  }

  void _handleAdvisoryTypeSelection(String? value) {
    if (value != null) {
      setState(() {
        selectedServiceType = value;
        selectedGeneralSpecialization = null;
        selectedAccurateSpecialization = null;
      });
      getit<AdvisoryCubit>().getGeneralTypesByAdvisoryId(value);
    }
  }

  void _handleGeneralTypeSelection(String? value) {
    if (value != null && selectedServiceType != null) {
      setState(() {
        selectedGeneralSpecialization = value;
        selectedAccurateSpecialization = null;
      });
      getit<AdvisoryCubit>().getAccurateTypesByGeneralAndAdvisoryId(
        selectedServiceType!,
        value,
      );
    }
  }

  void _handleAccurateTypeSelection(String? value) {
    if (value != null) {
      setState(() {
        selectedAccurateSpecialization = value;
      });
    }
  }

  Widget _buildDropdown({
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required String? value,
    required Function(String?) onChanged,
    required bool isLoading,
    required bool enabled,
  }) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: enabled ? appColors.grey2 : appColors.grey3,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: enabled ? Colors.white : appColors.grey1,
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                height: 24.h,
                width: 24.h,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    enabled ? appColors.primaryColorYellow : appColors.grey5,
                  ),
                ),
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  hint,
                  style: TextStyle(
                    color: enabled ? appColors.blue100 : appColors.grey10,
                  ),
                ),
                value: value,
                items: items,
                onChanged: enabled ? onChanged : null,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: enabled ? appColors.blue100 : appColors.grey10,
                ),
              ),
            ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors.primaryColorYellow,
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 2,
      ),
      child: Text(
        'إضافة',
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriceInput() {
    return TextField(
      controller: widget.priceController,
      keyboardType: TextInputType.number,
      style: TextStyle(color: appColors.blue100),
      decoration: InputDecoration(
        hintText: 'أدخل السعر',
        hintStyle: TextStyle(color: appColors.grey10),
        suffixText: 'ريال',
        suffixStyle: TextStyle(color: appColors.primaryColorYellow),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: appColors.grey2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: appColors.primaryColorYellow),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'موعد الاستشارة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: appColors.blue100,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: appColors.grey2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: InkWell(
            onTap: _selectDate,
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: appColors.blue100),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    selectedDate != null 
                        ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                        : 'اختر التاريخ',
                    style: TextStyle(color: appColors.blue100),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectTime(true),
                child: Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: appColors.grey2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: appColors.blue100),
                      SizedBox(width: 8.w),
                      Text(
                        startTime?.format(context) ?? 'وقت البداية',
                        style: TextStyle(color: appColors.blue100),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InkWell(
                onTap: () => _selectTime(false),
                child: Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: appColors.grey2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: appColors.blue100),
                      SizedBox(width: 8.w),
                      Text(
                        endTime?.format(context) ?? 'وقت النهاية',
                        style: TextStyle(color: appColors.blue100),
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
}
