import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../layout/services/logic/services_cubit.dart';
import '../../../../layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';
// Add import for the service request model
import '../models/service_request.dart';

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

  bool _validateInputs() {
    if (selectedMainService == null) {
      _showError('يرجى اختيار نوع الخدمة');
      return false;
    }

    if (selectedSubService == null) {
      _showError('يرجى اختيار الخدمة المطلوبة');
      return false;
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

  void _handleSubmit() {
    if (_validateInputs()) {
      final request = ServiceRequest(
        mainServiceId: selectedMainService!,
        subServiceId: selectedSubService!,
        price: int.parse(widget.priceController.text),
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
          final services = getit<ServicesCubit>().servicesRequirementsResponse?.data?.items;
          final isLoading = state is LoadingServices || services == null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // نوع الخدمة الرئيسي
              _buildDropdown(
                hint: 'نوع الخدمة',
                value: selectedMainService,
                items: _getMainServiceItems(services),
                onChanged: _handleMainServiceSelection,
                isLoading: isLoading,
                enabled: true,
              ),

              // الخدمة الفرعية
              if (selectedMainService != null && services != null) ...[
                SizedBox(height: 12.h),
                _buildDropdown(
                  hint: 'الخدمة المطلوبة',
                  value: selectedSubService,
                  items: _getSubServiceItems(services, selectedMainService!),
                  onChanged: _handleSubServiceSelection,
                  isLoading: false,
                  enabled: true,
                ),
              ],

              if (selectedSubService != null) ...[
                SizedBox(height: 16.h),
                _buildPriceInput(),
              ],

              SizedBox(height: 16.h),
              _buildSubmitButton(),
            ],
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _getMainServiceItems(List<Item>? services) {
    return services?.map((item) => DropdownMenuItem(
      value: item.id.toString(),
      child: Text(item.name ?? ''),
    )).toList() ?? [];
  }

  List<DropdownMenuItem<String>> _getSubServiceItems(List<Item> services, String mainServiceId) {
    final mainService = services.firstWhere(
      (item) => item.id.toString() == mainServiceId,
      orElse: () => Item(),
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
      widget.priceController.clear();
    });
  }

  void _handleSubServiceSelection(String? value) {
    setState(() {
      selectedSubService = value;
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
}
