import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class SuccessPaymentInvoice extends StatelessWidget {
  const SuccessPaymentInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            // Padding around the entire content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "فاتورة الحجز",
                  style:
                      TextStyles.cairo_18_bold.copyWith(color: appColors.black),
                ),
                verticalSpace(5.h),
                Text(
                  getTimeDate(DateTime.now().toString()), // Current date
                  style: TextStyles.cairo_14_regular
                      .copyWith(color: appColors.grey),
                ),
                verticalSpace(20.h),
                _buildInfoSection(),
                // Custom method to build the info section
                verticalSpace(20.h),
                _buildDetailsSection(),
                // Custom method to build the details section
                verticalSpace(30.h),
                const Divider(color: appColors.grey5, thickness: 0.3),
                verticalSpace(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn('الرقم الضريبي', '3021550606'),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        verticalSpace(5.h),
        Text(
          value,
          style: TextStyles.cairo_12_regular.copyWith(color: appColors.black),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Column(
        children: [
          _buildDetailsHeaderRow(),
          const Divider(color: appColors.grey5, thickness: 0.3),
          verticalSpace(10.h),
          _buildDetailsRow(
              'وقت الشراء', getTimeDate(DateTime.now().toString())),
          verticalSpace(10.h),
          _buildDetailsRow('حالة الطلب', "تم الدفع", color: appColors.green),
        ],
      ),
    );
  }

  Widget _buildDetailsHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'التفاصيل',
          style: TextStyles.cairo_14_bold
              .copyWith(color: appColors.primaryColorYellow),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String description, String value,
      {Color color = appColors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        Text(
          value,
          style: TextStyles.cairo_14_regular.copyWith(color: color),
        ),
      ],
    );
  }
}
