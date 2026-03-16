import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_lawyer_section/models/service_request.dart';
import 'widgets/consultation_form.dart';
import 'widgets/service_form.dart';
import 'widgets/appointment_form.dart';

class AddServiceScreen extends StatefulWidget {
  final Function(BaseServiceRequest) onServiceAdded;

  const AddServiceScreen({
    super.key,
    required this.onServiceAdded,
  });

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  String selectedService = 'استشارة';
  final TextEditingController _priceController = TextEditingController();

  void _handleServiceSuccess(BaseServiceRequest request) {
    widget.onServiceAdded(request);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, 'إضافة خدمة'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اختر نوع الخدمة",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 16.h),
            _buildServiceOptions(),
            SizedBox(height: 24.h),
            const Divider(),
            SizedBox(height: 24.h),
            if (selectedService == 'استشارة')
              ConsultationForm(
                priceController: _priceController,
                onSuccess: _handleServiceSuccess,
              )
            else if (selectedService == 'موعد')
              AppointmentForm(
                priceController: _priceController,
                onSuccess: _handleServiceSuccess,
              )
            else if (selectedService == 'خدمة')
              ServiceForm(
                priceController: _priceController,
                onSuccess: _handleServiceSuccess,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceOption('موعد', AppAssets.appointments),
        _buildServiceOption('استشارة', AppAssets.advisories),
        _buildServiceOption('خدمة', AppAssets.services),
      ],
    );
  }

  Widget _buildServiceOption(String title, String icon) {
    final bool isSelected = selectedService == title;
    return InkWell(
      onTap: () {
        setState(() => selectedService = title);
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? const Color(0xFFFAF6E9) : Colors.white,
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFFB4B4B4),
              width: 28.w,
              height: 28.w,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFFB4B4B4),
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
