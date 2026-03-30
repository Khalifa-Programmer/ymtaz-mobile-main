import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/moyasar_payment_screen.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

class ElitePaymentScreen extends StatefulWidget {
  final Request request;
  final TypesImportance offer;

  const ElitePaymentScreen({super.key, required this.request, required this.offer});

  @override
  State<ElitePaymentScreen> createState() => _ElitePaymentScreenState();
}

class _ElitePaymentScreenState extends State<ElitePaymentScreen> {
  String selectedMethod = 'credit_card';

  @override
  Widget build(BuildContext context) {
    final double price = (widget.offer.price ?? 2500).toDouble();
    final double taxPercent = 0.15;
    final double taxAmount = price * taxPercent;
    final double total = price + taxAmount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildBlurredAppBar(context, "الدفع"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Method Selection
                    Text(
                      "اختر وسيلة الدفع",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F2D37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    verticalSpace(16.h),
                    
                    _buildPaymentOption(
                      id: 'credit_card',
                      title: "بطاقة الائتمان",
                      logos: [
                        _buildVisaLogo(),
                        _buildMasterCardLogo(),
                        _buildAmexLogo(),
                        _buildDiscoverLogo(),
                      ],
                    ),
                    
                    if (Platform.isIOS) ...[
                      verticalSpace(12.h),
                      _buildPaymentOption(
                        id: 'apple_pay',
                        title: "Apple Pay",
                        logos: [
                           Icon(Icons.apple, color: Colors.black, size: 24.sp),
                        ],
                      ),
                    ],
                    
                    if (Platform.isAndroid) ...[
                      verticalSpace(12.h),
                      _buildPaymentOption(
                        id: 'google_pay',
                        title: "Google Pay",
                        logos: [
                           Icon(Icons.payment_rounded, color: Colors.blue, size: 24.sp),
                        ],
                      ),
                    ],
                    
                    verticalSpace(40.h),
                    
                    // Fees Label
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الرسوم",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFC4C4C4),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    verticalSpace(16.h),
                    
                    // Fees Box
                    Container(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Column(
                        children: [
                          _buildPriceRow(
                            "المجموع الكلي", 
                            "${total.toInt()} ريال", 
                            isTotal: true,
                            subtitle: "*السعر شامل ضريبة القيمة المضافة"
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoyasarPaymentScreen(
                          amount: total.toString(),
                          description: widget.offer.reservationImportance?.name ?? "طلب خدمة النخبة",
                          transactionId: widget.offer.id?.toString(),
                          metadata: {
                            'order_id': widget.request.id?.toString() ?? '',
                            'offer_id': widget.offer.id?.toString() ?? '',
                            'type': 'elite',
                            'payment_method': selectedMethod,
                          },
                        ),
                      ),
                    ).then((result) {
                      if (result == 'success' && context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.eliteSuccessPayment,
                          (route) => false,
                          arguments: {
                            'request': widget.request,
                            'offer': widget.offer,
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37), // Golden color
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text("اتمام الطلب",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({required String id, required String title, required List<Widget> logos}) {
    final bool isSelected = selectedMethod == id;
    
    return InkWell(
      onTap: () => setState(() => selectedMethod = id),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9EDEF) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F2D37) : Colors.grey[200]!,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Row(children: logos),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            horizontalSpace(12.w),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0F2D37), width: 2),
              ),
              padding: EdgeInsets.all(3.w),
              child: isSelected 
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0F2D37),
                    ),
                  ) 
                : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisaLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Center(
        child: Text(
          "VISA",
          style: TextStyle(
            color: const Color(0xFF1A1F71),
            fontWeight: FontWeight.w900,
            fontSize: 9.sp,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildMasterCardLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Center(
        child: SizedBox(
          width: 14.w,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB001B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF79E1B).withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmexLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: const Color(0xFF016FD0),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Center(
        child: Text(
          "AMEX",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 7.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DISC",
              style: TextStyle(
                color: const Color(0xFF444444),
                fontWeight: FontWeight.bold,
                fontSize: 6.sp,
              ),
            ),
            Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6000),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 18.sp : 14.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? const Color(0xFFD4AF37) : const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF0F2D37),
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          verticalSpace(4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ],
    );
  }
}
