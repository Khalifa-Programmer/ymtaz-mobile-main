import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../layout/services/logic/services_cubit.dart';
import '../../../../layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart' as services_model;
// Add import for the service request model
import '../models/service_request.dart';
import '../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../../core/widgets/spacing.dart';
import '../add_service_screen.dart';
import '../../../logic/ymtaz_elite_cubit.dart';

class ServiceForm extends StatefulWidget {
  final TextEditingController priceController;
  // Update the callback type
  final Function(BaseServiceRequest) onSuccess;

  const ServiceForm({
    super.key,
    required this.priceController,
    required this.onSuccess,
  });

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  String? selectedMainService;
  String? selectedSubService;
  String? selectedLevel;

  @override
  void initState() {
    super.initState();
    getit<ServicesCubit>().loadServices();
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

  bool _validateInputs(List<services_model.Item>? services) {
    if (selectedMainService == null) {
      _showError('يرجى اختيار نوع الخدمة');
      return false;
    }

    if (selectedSubService == null) {
      _showError('يرجى اختيار الخدمة المطلوبة');
      return false;
    }

    // التحقق من المستوى إذا كان متاحاً
    if (services != null) {
      final mainService = services.firstWhere((item) => item.id.toString() == selectedMainService, 
        orElse: () => services_model.Item());
      final service = mainService.services?.firstWhere((s) => s.id.toString() == selectedSubService,
        orElse: () => services_model.Service());
      if (service?.ymtazLevelsPrices != null && service!.ymtazLevelsPrices!.isNotEmpty && selectedLevel == null) {
        _showError('يرجى اختيار مستوى الخدمة');
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

  void _handleSubmit(List<services_model.Item>? services) {
    if (_validateInputs(services)) {
      String? serviceName;
      String? levelName;
      
      if (services != null) {
        final mainService = services.firstWhere((item) => item.id.toString() == selectedMainService, 
          orElse: () => services_model.Item());
        final service = mainService.services?.firstWhere((s) => s.id.toString() == selectedSubService,
          orElse: () => services_model.Service());
        serviceName = service?.title;
        
        if (selectedLevel != null) {
          final level = service?.ymtazLevelsPrices?.firstWhere((l) => l.id.toString() == selectedLevel);
          levelName = level?.level?.name;
        }
      }

      // نرسل معرف الخدمة (Service ID) كـ subServiceId لأنه هو ما يتوقعه السيرفر (الخدمة الفرعية)
      // كانت المشكلة ربما في إرسال معرف المستوى (Level ID) أو معرف القسم (Item ID)
      final request = ServiceRequest(
        mainServiceId: selectedMainService!,
        subServiceId: selectedSubService!,
        price: int.parse(widget.priceController.text),
        serviceName: serviceName,
        levelName: levelName,
      );
      widget.onSuccess(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ServicesCubit>(),
      child: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          state.whenOrNull(
            errorServices: (error) => _showError(error),
          );
        },
        builder: (context, state) {
          final allServices = getit<ServicesCubit>().servicesRequirementsResponse?.data?.items;
          final eliteRequest = getit<YmtazEliteCubit>().selectedRequest;
          final eliteCategoryId = eliteRequest?.eliteServiceCategory?.id;

          // تصفية الخدمات الرئيسية لتناسب قسم طلب النخبة (مثلاً: جنائي)
          final filteredServices = _getFilteredServices(allServices, eliteCategoryId);
          
          // تحديد الخدمة الرئيسية تلقائياً إذا كان هناك خيار واحد فقط متاح
          if (selectedMainService == null && filteredServices.length == 1) {
             WidgetsBinding.instance.addPostFrameCallback((_) {
               if (mounted && selectedMainService == null) {
                 setState(() {
                   selectedMainService = filteredServices.first.id.toString();
                 });
               }
             });
          }

          final isLoading = state is LoadingServices || allServices == null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // نوع الخدمة الرئيسي
              _buildDropdown(
                hint: 'نوع الخدمة',
                value: selectedMainService,
                items: _getMainServiceItems(filteredServices),
                onChanged: _handleMainServiceSelection,
                isLoading: isLoading,
                enabled: true,
              ),

              // الخدمة الفرعية
              if (selectedMainService != null && filteredServices.isNotEmpty) ...[
                SizedBox(height: 12.h),
                _buildDropdown(
                  hint: 'الخدمة المطلوبة',
                  value: selectedSubService,
                  items: _getSubServiceItems(filteredServices, selectedMainService!),
                  onChanged: _handleSubServiceSelection,
                  isLoading: false,
                  enabled: true,
                ),
              ],

              // مستوى الخدمة (Level)
              if (selectedSubService != null && filteredServices.isNotEmpty) ...[
                _buildLevelDropdown(filteredServices),
              ],

              if (selectedSubService != null && (selectedLevel != null || !_hasLevels(filteredServices))) ...[
                SizedBox(height: 16.h),
                _buildPriceInput(),
              ],

              SizedBox(height: 16.h),
              _buildSubmitButton(filteredServices),
            ],
          );
        },
      ),
    );
  }

  bool _hasLevels(List<services_model.Item>? services) {
    if (services == null || selectedMainService == null || selectedSubService == null) return false;
    final mainService = services.firstWhere((item) => item.id.toString() == selectedMainService,
      orElse: () => services_model.Item());
    final service = mainService.services?.firstWhere((s) => s.id.toString() == selectedSubService,
      orElse: () => services_model.Service());
    return service?.ymtazLevelsPrices != null && service!.ymtazLevelsPrices!.isNotEmpty;
  }

  Widget _buildLevelDropdown(List<services_model.Item> services) {
    final mainService = services.firstWhere((item) => item.id.toString() == selectedMainService,
      orElse: () => services_model.Item());
    final service = mainService.services?.firstWhere((s) => s.id.toString() == selectedSubService,
      orElse: () => services_model.Service());
    
    if (service?.ymtazLevelsPrices == null || service!.ymtazLevelsPrices!.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        SizedBox(height: 12.h),
        _buildDropdown(
          hint: 'مستوى الخدمة',
          value: selectedLevel,
          items: service.ymtazLevelsPrices!.map((level) => DropdownMenuItem(
            value: level.id.toString(),
            child: Text(level.level?.name ?? 'مستوى ${level.id}'),
          )).toList(),
          onChanged: (value) {
            setState(() {
              selectedLevel = value;
            });
          },
          isLoading: false,
          enabled: true,
        ),
      ],
    );
  }

  List<services_model.Item> _getFilteredServices(List<services_model.Item>? allServices, int? eliteCategoryId) {
    if (allServices == null) return [];
    if (eliteCategoryId == null) return allServices;
    
    // محاولة مطابقة القسم الرئيسي للنخبة مع أقسام الخدمات
    final filtered = allServices.where((item) => item.id == eliteCategoryId).toList();
    
    // إذا لم يتم العثور على مطابقة مباشرة، تظهر قائمة فارغة أو الكل حسب الرغبة (هنا نتركها فارغة لضمان الدقة)
    return filtered;
  }

  List<DropdownMenuItem<String>> _getMainServiceItems(List<services_model.Item> services) {
    return services.map((item) => DropdownMenuItem(
      value: item.id.toString(),
      child: Text(item.name ?? ''),
    )).toList();
  }

  List<DropdownMenuItem<String>> _getSubServiceItems(List<services_model.Item> services, String mainServiceId) {
    final mainService = services.firstWhere(
      (item) => item.id.toString() == mainServiceId,
      orElse: () => services_model.Item(),
    );
    
    return mainService.services?.map((service) => DropdownMenuItem(
      value: service.id.toString(),
      child: Text(service.title ?? ''),
    )).toList() ?? [];
  }

  void _handleMainServiceSelection(String? value) {
    setState(() {
      selectedMainService = value;
      selectedSubService = null;
      selectedLevel = null;
      widget.priceController.clear();
    });
  }

  void _handleSubServiceSelection(String? value) {
    setState(() {
      selectedSubService = value;
      selectedLevel = null;
    });
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<DropdownMenuItem<String>> items,
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

  Widget _buildSubmitButton(List<services_model.Item>? services) {
    return ElevatedButton(
      onPressed: () => _handleSubmit(services),
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
}
