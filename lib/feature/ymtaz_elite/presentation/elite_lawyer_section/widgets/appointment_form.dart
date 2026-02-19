import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../my_appointments/logic/appointments_cubit.dart';
// Add import for the service request model
import '../models/service_request.dart';

class AppointmentForm extends StatefulWidget {
  final TextEditingController priceController;
  // Update the callback type
  final Function(BaseServiceRequest) onSuccess;

  const AppointmentForm({
    super.key,
    required this.priceController,
    required this.onSuccess,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  String? selectedAppointmentType;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String address = '';
  String lat = '';
  String lng = '';

  @override
  void initState() {
    super.initState();
    getit<AppointmentsCubit>().getAppointmentsTypes();
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

  void _selectLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            apiKey: 'AIzaSyDGzG6SU9IVPzw2T6YTAH6YAgnAfzM1lsU',
            onPlacePicked: (LocationResult result) {
              setState(() {
                address = result.formattedAddress ?? "";
                lat = result.latLng!.latitude.toString();
                lng = result.latLng!.longitude.toString();
              });
              Navigator.of(context).pop();
            },
            initialLocation: const LatLng(29.378586, 47.990341),
            usePinPointingSearch: true,
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              autofocus: false,
              textDirection: TextDirection.ltr,
            ),
            searchInputDecorationConfig: const SearchInputDecorationConfig(
              hintText: "ابحث عن مكان .....",
            ),
          );
        },
      ),
    );
  }

  bool _validateInputs() {
    if (selectedAppointmentType == null) {
      _showError('يرجى اختيار نوع الموعد');
      return false;
    }

    if (selectedDate == null) {
      _showError('يرجى اختيار تاريخ الموعد');
      return false;
    }

    if (startTime == null || endTime == null) {
      _showError('يرجى تحديد وقت بداية ونهاية الموعد');
      return false;
    }

    if (address.isEmpty) {
      _showError('يرجى تحديد موقع المقابلة');
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
      final request = AppointmentRequest(
        appointmentTypeId: selectedAppointmentType!,
        date: selectedDate!,
        startTime: startTime!.format(context),
        endTime: endTime!.format(context),
        address: address,
        lat: lat,
        lng: lng,
        price: int.parse(widget.priceController.text),
      );
      widget.onSuccess(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AppointmentsCubit>(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypeSelection(),
          SizedBox(height: 16.h),
          _buildDateTimeSelection(),
          SizedBox(height: 16.h),
          _buildLocationSelection(),
          SizedBox(height: 16.h),
          _buildPriceInput(),
          SizedBox(height: 16.h),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTypeSelection() {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final reservationTypes = getit<AppointmentsCubit>()
            .datesTypesResponse
            ?.data
            ?.reservationsTypes;
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => reservationTypes == null,
        );

        return _buildDropdown(
          hint: 'نوع الموعد',
          items: reservationTypes?.map((type) => DropdownMenuItem(
            value: type.id.toString(),
            child: Text(type.name ?? ''),
          )).toList() ?? [],
          value: selectedAppointmentType,
          onChanged: (value) {
            setState(() {
              selectedAppointmentType = value;
            });
          },
          isLoading: isLoading,
          enabled: true,
        );
      },
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'موعد المقابلة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: appColors.blue100,
          ),
        ),
        SizedBox(height: 8.h),
        // Date selection
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Time selection
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: appColors.blue100, size: 20.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          startTime?.format(context) ?? 'من',
                          style: TextStyle(color: appColors.blue100),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: appColors.blue100, size: 20.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          endTime?.format(context) ?? 'إلى',
                          style: TextStyle(color: appColors.blue100),
                          overflow: TextOverflow.ellipsis,
                        ),
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

  Widget _buildLocationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'موقع المقابلة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: appColors.blue100,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: _selectLocation,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: appColors.grey2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: appColors.blue100),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    address.isNotEmpty ? address : 'حدد موقع المقابلة',
                    style: TextStyle(color: appColors.blue100),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
