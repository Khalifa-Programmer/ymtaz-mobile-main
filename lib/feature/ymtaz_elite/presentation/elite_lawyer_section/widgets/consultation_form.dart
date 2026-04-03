import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_accurate_specialization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_categories_types.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_general_specialization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/widgets/spacing.dart';
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
  String? selectedLevelId;          // مستوى الطلب (id السعر المرتبط بالمستوى)
  int? selectedDurationMinutes;     // مدة الاستشارة (دقائق)
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // نوع الاستشارة المرئية = "2"
  bool get _isVisualType => selectedServiceType == "2";

  // قائمة المستويات للتخصص الدقيق المختار
  List<LevelElement> _getLevelsForSelectedSub(AdvisoriesAccurateSpecialization? spec) {
    if (spec?.data?.subCategories == null) return [];
    final sub = spec!.data!.subCategories!.firstWhere(
      (s) => s.id.toString() == selectedAccurateSpecialization,
      orElse: () => SubCategory(),
    );
    return sub.levels ?? [];
  }

  @override
  void initState() {
    super.initState();
    getit<AdvisoryCubit>().getAdvisoriesTypes();
  }

  void _showError(String message) {
    if (!mounted) return;
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
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), overlayEntry.remove);
  }

  bool _validateInputs(List<LevelElement> levels) {
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

    // للاستشارة المرئية: التحقق من المستوى ثم المدة ثم الوقت
    if (_isVisualType) {
      if (levels.isNotEmpty && selectedLevelId == null) {
        _showError('يرجى اختيار مستوى الطلب');
        return false;
      }
      if (selectedDurationMinutes == null) {
        _showError('يرجى اختيار مدة الاستشارة');
        return false;
      }
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
    } catch (_) {
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
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: appColors.primaryColorYellow),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: appColors.primaryColorYellow),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => isStart ? startTime = picked : endTime = picked);
    }
  }

  void _handleSubmit(List<LevelElement> levels) {
    if (_validateInputs(levels)) {
      final request = ConsultationRequest(
        advisoryTypeId: selectedServiceType!,
        generalSpecializationId: selectedGeneralSpecialization!,
        accurateSpecializationId: selectedAccurateSpecialization!,
        price: int.parse(widget.priceController.text),
        date: _isVisualType && selectedDate != null
            ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
            : "",
        fromTime: _isVisualType && startTime != null
            ? "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}"
            : "",
        toTime: _isVisualType && endTime != null
            ? "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}"
            : "",
        levelId: selectedLevelId,
        duration: selectedDurationMinutes,
      );
      widget.onSuccess(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>(),
      child: BlocConsumer<AdvisoryCubit, AdvisoryState>(
        listener: _handleAdvisoryStateChanges,
        builder: (context, state) {
          final cubit = getit<AdvisoryCubit>();
          final types = cubit.advisoriesCategoriesTypes?.data?.items;
          final isLoadingTypes = state is AdvisoryTypesLoading || types == null;

          // قائمة المستويات للتخصص المختار
          final levels = _getLevelsForSelectedSub(cubit.advisoriesAccurateSpecialization);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── نوع الاستشارة ──────────────────────────────────────
              _buildDropdown(
                hint: 'نوع الاستشارة',
                items: _getAdvisoryTypeItems(types),
                value: selectedServiceType,
                onChanged: _handleAdvisoryTypeSelection,
                isLoading: isLoadingTypes,
                enabled: true,
              ),

              // ── التخصص العام ───────────────────────────────────────
              if (selectedServiceType != null) ...[
                SizedBox(height: 12.h),
                BlocBuilder<AdvisoryCubit, AdvisoryState>(
                  buildWhen: (prev, curr) =>
                      curr is AdvisoryGeneralTypesLoading ||
                      curr is AdvisoryGeneralTypesLoaded,
                  builder: (context, _) {
                    final generalTypes = cubit.advisoriesGeneralSpecialization?.data;
                    final loading = state is AdvisoryGeneralTypesLoading || generalTypes == null;
                    return _buildDropdown(
                      hint: 'التخصص العام',
                      items: _getGeneralTypeItems(generalTypes),
                      value: selectedGeneralSpecialization,
                      onChanged: _handleGeneralTypeSelection,
                      isLoading: loading,
                      enabled: true,
                    );
                  },
                ),
              ],

              // ── التخصص الدقيق ─────────────────────────────────────
              if (selectedGeneralSpecialization != null) ...[
                SizedBox(height: 12.h),
                BlocBuilder<AdvisoryCubit, AdvisoryState>(
                  buildWhen: (prev, curr) =>
                      curr is AdvisoryAccurateTypesLoading ||
                      curr is AdvisoryAccurateTypesLoaded,
                  builder: (context, _) {
                    final accTypes =
                        cubit.advisoriesAccurateSpecialization?.data?.subCategories;
                    final loading =
                        state is AdvisoryAccurateTypesLoading || accTypes == null;
                    return _buildDropdown(
                      hint: 'التخصص الدقيق',
                      items: _getAccurateTypeItems(accTypes),
                      value: selectedAccurateSpecialization,
                      onChanged: _handleAccurateTypeSelection,
                      isLoading: loading,
                      enabled: true,
                    );
                  },
                ),
              ],

              // ══ قسم خاص بالاستشارة المرئية ════════════════════════
              if (_isVisualType && selectedAccurateSpecialization != null) ...[
                SizedBox(height: 16.h),
                _buildVisualSection(levels),
              ],

              // ── السعر ─────────────────────────────────────────────
              if (selectedAccurateSpecialization != null &&
                  (!_isVisualType ||
                      (selectedDurationMinutes != null ||
                          levels.isEmpty))) ...[
                SizedBox(height: 16.h),
                _buildPriceInput(),
              ],

              SizedBox(height: 16.h),
              _buildSubmitButton(levels),
            ],
          );
        },
      ),
    );
  }

  // ── قسم الاستشارة المرئية: مستوى + مدة + تاريخ/وقت ──────────────────────
  Widget _buildVisualSection(List<LevelElement> levels) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان القسم
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Icon(Icons.videocam_rounded, color: appColors.primaryColorYellow, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                'تفاصيل الاستشارة المرئية',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.primaryColorYellow,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),

        // مستوى الطلب
        if (levels.isNotEmpty) ...[
          _buildDropdown(
            hint: 'مستوى الطلب',
            value: selectedLevelId,
            items: levels.map((lvl) => DropdownMenuItem(
              value: lvl.id.toString(),
              child: Text(
                lvl.level?.title ?? 'مستوى ${lvl.id}',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
              ),
            )).toList(),
            onChanged: (value) {
              if (value == null) return;
              final chosen = levels.firstWhere(
                (l) => l.id.toString() == value,
                orElse: () => LevelElement(),
              );
              setState(() {
                selectedLevelId = value;
                selectedDurationMinutes = chosen.duration;
                if (chosen.price != null) {
                  widget.priceController.text = chosen.price!;
                }
              });
            },
            isLoading: false,
            enabled: true,
          ),
          verticalSpace(16.h),
        ],

        // حقل مدة الاستشارة (عرض المدة والسعر)
        if (selectedLevelId != null || levels.isEmpty)
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFBFBFB),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: appColors.grey2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "المدة والسعر المعتمد",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600], fontFamily: 'Cairo'),
              ),
              verticalSpace(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.timer_outlined, color: Colors.blue, size: 20.sp),
                      ),
                      horizontalSpace(12.w),
                      Text(
                        "${selectedDurationMinutes ?? '--'} دقيقة",
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: appColors.blue100, fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: appColors.primaryColorYellow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "${widget.priceController.text} ريال",
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: appColors.primaryColorYellow, fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        verticalSpace(20.h),
        // التاريخ والوقت
        _buildDateTimeSelection(),
      ],
    );
  }

  // ── Handlers ───────────────────────────────────────────────────────────────
  void _handleAdvisoryStateChanges(BuildContext context, AdvisoryState state) {
    if (state is AdvisoryTypesError) _showError('حدث خطأ في تحميل أنواع الاستشارات');
    if (state is AdvisoryGeneralTypesError) _showError('حدث خطأ في تحميل التخصصات العامة');
    if (state is AdvisoryAccurateTypesError) _showError('حدث خطأ في تحميل التخصصات الدقيقة');
  }

  void _handleAdvisoryTypeSelection(String? value) {
    if (value == null) return;
    setState(() {
      selectedServiceType = value;
      selectedGeneralSpecialization = null;
      selectedAccurateSpecialization = null;
      selectedLevelId = null;
      selectedDurationMinutes = null;
      widget.priceController.clear();
    });
    getit<AdvisoryCubit>().getGeneralTypesByAdvisoryId(value);
  }

  void _handleGeneralTypeSelection(String? value) {
    if (value == null || selectedServiceType == null) return;
    setState(() {
      selectedGeneralSpecialization = value;
      selectedAccurateSpecialization = null;
      selectedLevelId = null;
      selectedDurationMinutes = null;
      widget.priceController.clear();
    });
    getit<AdvisoryCubit>().getAccurateTypesByGeneralAndAdvisoryId(
      selectedServiceType!,
      value,
    );
  }

  void _handleAccurateTypeSelection(String? value) {
    if (value == null) return;
    setState(() {
      selectedAccurateSpecialization = value;
      selectedLevelId = null;
      selectedDurationMinutes = null;
      widget.priceController.clear();
    });
  }

  // ── Items builders ─────────────────────────────────────────────────────────
  List<DropdownMenuItem<String>> _getAdvisoryTypeItems(List<Item>? types) =>
      types?.map((i) => DropdownMenuItem(value: i.id.toString(), child: Text(i.name ?? ''))).toList() ?? [];

  List<DropdownMenuItem<String>> _getGeneralTypeItems(List<AdvisoriesGeneralData>? types) =>
      types?.map((i) => DropdownMenuItem(value: i.id.toString(), child: Text(i.name ?? ''))).toList() ?? [];

  List<DropdownMenuItem<String>> _getAccurateTypeItems(List<SubCategory>? types) =>
      types?.map((i) => DropdownMenuItem(value: i.id.toString(), child: Text(i.name ?? ''))).toList() ?? [];

  // ── Dropdown widget ────────────────────────────────────────────────────────
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
        border: Border.all(color: enabled ? appColors.grey2 : appColors.grey3),
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
                hint: Text(hint,
                    style: TextStyle(
                        color: enabled ? appColors.blue100 : appColors.grey10)),
                value: value,
                items: items,
                onChanged: enabled ? onChanged : null,
                icon: Icon(Icons.arrow_drop_down,
                    color: enabled ? appColors.blue100 : appColors.grey10),
              ),
            ),
    );
  }

  // ── Price input ────────────────────────────────────────────────────────────
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

  // ── Submit button ──────────────────────────────────────────────────────────
  Widget _buildSubmitButton(List<LevelElement> levels) {
    return ElevatedButton(
      onPressed: () => _handleSubmit(levels),
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors.primaryColorYellow,
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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

  // ── Date & time selection ──────────────────────────────────────────────────
  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'موعد الاستشارة',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: appColors.blue100,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 8.h),

        // التاريخ
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: appColors.grey2),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: appColors.blue100, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                        : 'اختر التاريخ',
                    style: TextStyle(
                        color: selectedDate != null
                            ? appColors.blue100
                            : appColors.grey10,
                        fontSize: 14.sp,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),

        // وقت البداية والنهاية
        Row(
          children: [
            Expanded(child: _buildTimePicker(isStart: true)),
            SizedBox(width: 8.w),
            Expanded(child: _buildTimePicker(isStart: false)),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePicker({required bool isStart}) {
    final time = isStart ? startTime : endTime;
    return InkWell(
      onTap: () => _selectTime(isStart),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: appColors.grey2),
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: appColors.blue100, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              time?.format(context) ?? (isStart ? 'وقت البداية' : 'وقت النهاية'),
              style: TextStyle(
                color: time != null ? appColors.blue100 : appColors.grey10,
                fontSize: 13.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
