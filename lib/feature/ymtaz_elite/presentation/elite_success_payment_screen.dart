import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import '../../../core/widgets/app_bar.dart';
import 'elite_request_details_screen.dart';

class EliteSuccessPaymentScreen extends StatelessWidget {
  final Request request;
  final TypesImportance offer;

  const EliteSuccessPaymentScreen({super.key, required this.request, required this.offer});

  @override
  Widget build(BuildContext context) {
    final double price = (offer.price ?? 2500).toDouble();
    final double taxAmount = price * 0.15;
    final double total = price + taxAmount;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: buildBlurredAppBar(
        context, 
        "تم حجز موعدك بنجاح",
        onBackPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeLayout,
            (route) => false,
            arguments: 1, // My Requests or Office tab
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [
                    // Success Circle
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4AF37), // Golden color
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    verticalSpace(24.h),
                    
                    // Details Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                            ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "التفاصيل",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFFC4C4C4),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          verticalSpace(16.h),
                          _buildDetailRow("نوع الطلب", request.eliteServiceCategory?.name ?? "خدمة توكيل محامي"),
                          _buildDetailRow("سعر الخدمة", "${price.toInt()} ريال سعودي"),
                          _buildDetailRow("مستوي الطلب", "متوسط الأهمية"),
                          _buildDetailRow("وقت الشراء", "31/1/2025"),
                          _buildDetailRow("حالة الطلب", "تم الدفع", valueColor: const Color(0xFF27AE60)),
                          
                          verticalSpace(24.h),
                          Divider(color: Colors.grey[100], thickness: 1),
                          verticalSpace(16.h),
                          
                          // Elite Team Info Row (RTL: Starts from Right)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                // Team Avatar (Far Right)
                                Container(
                                    width: 56.w,
                                    height: 56.w,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF04242E), // Very dark teal
                                        shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.w),
                                          child: SvgPicture.asset(
                                            AppAssets.logo,
                                            colorFilter: const ColorFilter.mode(Color(0xFFD1A661), BlendMode.srcIn),
                                          ),
                                        ),
                                    ),
                                ),
                                horizontalSpace(16.w),
                                // Team Name, Service Type, and Crown (Middle)
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              Text(
                                                  "فريق استشاري",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: const Color(0xFF0F2D37),
                                                      fontFamily: 'Cairo',
                                                  ),
                                              ),
                                              horizontalSpace(6.w),
                                              // Crown Icon (Left of Text / After it)
                                              SvgPicture.asset(
                                                AppAssets.crown,
                                                width: 18.w,
                                                height: 18.w,
                                                colorFilter: const ColorFilter.mode(Color(0xFFD1A661), BlendMode.srcIn),
                                              ),
                                          ],
                                        ),
                                        Text(
                                            "خدمة نخبة",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xFFB4B4B4),
                                                fontFamily: 'Cairo',
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                          ),
                          verticalSpace(20.h),
                          // Date and Time Row
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(
                                      "الوقت : 12:00:21", 
                                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFFB4B4B4), fontFamily: 'Cairo')
                                  ),
                                  Text(
                                      "التاريخ : 1/12/2024", 
                                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFFB4B4B4), fontFamily: 'Cairo')
                                  ),
                              ],
                          ),
                        ],
                      ),
                    ),
                    
                    verticalSpace(20.h),
                    
                    // Fees Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                            ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الرسوم",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFFC4C4C4),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          verticalSpace(16.h),
                          _buildFeeRow("السعر", "${price.toInt()} ريال"),
                          _buildFeeRow("الضرائب", "15%", subtitle: "*السعر شامل ضريبة القيمة المضافة"),
                          verticalSpace(16.h),
                          Divider(color: Colors.grey[100], thickness: 1),
                          verticalSpace(16.h),
                          _buildFeeRow("المجموع الكلي", "${total.toInt()} ريال", isTotal: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Back to Home Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Reset stack to main layout at index 1 (My Requests / Office)
                    // then push request details so back button goes to index 1
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.homeLayout,
                      (route) => false,
                      arguments: 1, // My Requests or Office tab
                    );
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EliteRequestDetailsScreen(request: request),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37), // Golden color
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        "عرض تفاصيل نوع الخدمة", 
                        style: TextStyle(
                          fontSize: 16.sp, 
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        )
                      ),
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

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: valueColor ?? const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value, {bool isTotal = false, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 16.sp : 13.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? const Color(0xFFD4AF37) : const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
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
              fontSize: 10.sp,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ],
    );
  }
}
