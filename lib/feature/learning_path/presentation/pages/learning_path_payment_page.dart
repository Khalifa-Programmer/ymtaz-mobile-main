import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';

class LearningPathPaymentPage extends StatefulWidget {
  const LearningPathPaymentPage({super.key});

  @override
  State<LearningPathPaymentPage> createState() => _LearningPathPaymentPageState();
}

class _LearningPathPaymentPageState extends State<LearningPathPaymentPage> {
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: Text('طلب الدفع', style: TextStyles.cairo_15_bold),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appColors.blue100, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemsList(),
            SizedBox(height: 16.h),
            _buildAddMoreButton(),
            SizedBox(height: 24.h),
            _buildPromoCodeSection(),
            SizedBox(height: 24.h),
            _buildPaymentMethods(),
            SizedBox(height: 24.h),
            _buildOrderSummary(),
            SizedBox(height: 32.h),
            CustomButton(
              title: 'اشارك الآن',
              onPress: () {},
              bgColor: appColors.primaryColorYellow,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return Column(
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: appColors.grey1),
          ),
          child: Row(
            children: [
              Icon(Icons.import_contacts, color: appColors.primaryColorYellow, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 ? 'الأنظمة الأساسية' : 'أنظمة الصيانة والآثار',
                      style: TextStyles.cairo_13_bold.copyWith(color: appColors.blue100),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(Icons.star, color: appColors.primaryColorYellow, size: 10.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Text('299 ريال', style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: appColors.primaryColorYellow),
        ),
        child: Center(
          child: Text(
            'إضافة المزيد من المسارات',
            style: TextStyles.cairo_14_bold.copyWith(color: appColors.primaryColorYellow),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _promoController,
            decoration: InputDecoration(
              hintText: 'كود الخصم',
              hintStyle: TextStyles.cairo_13_regular.copyWith(color: appColors.grey10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appColors.grey1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appColors.grey1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        CustomButton(
          title: 'ارسال',
          width: 80,
          onPress: () {},
          bgColor: appColors.white,
          titleColor: appColors.primaryColorYellow,
          borderColor: appColors.primaryColorYellow,
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('طريقة الدفع', style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100)),
        SizedBox(height: 12.h),
        _buildPaymentOption(
          title: 'بطاقة الائتمان أو الخصم',
          icon: Row(
            children: [
              Icon(Icons.credit_card, size: 18.sp),
              SizedBox(width: 4.w),
              const Text('VISA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          isSelected: true,
        ),
        SizedBox(height: 12.h),
        _buildPaymentOption(
          title: 'Pay with Apple Pay',
          icon: Icon(Icons.apple, size: 24.sp),
          isSelected: false,
        ),
      ],
    );
  }

  Widget _buildPaymentOption({required String title, required Widget icon, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: isSelected ? appColors.primaryColorYellow : appColors.grey1),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 12.w),
          Expanded(child: Text(title, style: TextStyles.cairo_13_medium)),
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? appColors.primaryColorYellow : appColors.grey1w5, width: 2),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(color: appColors.primaryColorYellow, shape: BoxShape.circle),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملخص الدفع', style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100)),
        SizedBox(height: 12.h),
        _buildSummaryRow('مجموع الطلب', '299 ريال'),
        _buildSummaryRow('رسوم إضافية', '0.00 ريال'),
        const Divider(),
        _buildSummaryRow('المبلغ الإجمالي', '299 ريال', isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? TextStyles.cairo_14_bold : TextStyles.cairo_13_regular.copyWith(color: appColors.grey10),
          ),
          Text(
            value,
            style: isTotal ? TextStyles.cairo_14_bold.copyWith(color: appColors.primaryColorYellow) : TextStyles.cairo_13_medium,
          ),
        ],
      ),
    );
  }
}
