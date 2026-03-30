import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';

class ElitePriceOfferScreen extends StatelessWidget {
  final Request request;
  final TypesImportance offer;

  const ElitePriceOfferScreen({super.key, required this.request, required this.offer});

  void _showIgnoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            verticalSpace(24.h),
            Text(
              "تجاهل العرض",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: const Color(0xFF0F2D37),
              ),
            ),
            verticalSpace(24.h),
            _buildActionOption(
              context,
              label: "طلب إعادة تسعير",
              icon: CupertinoIcons.refresh_thick,
              color: const Color(0xFFD4AF37),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.eliteRepricingRequest,
                  arguments: {
                    'request': request,
                    'offer': offer,
                  },
                );
              },
            ),
            verticalSpace(12.h),
            _buildActionOption(
              context,
              label: "رفض العرض نهائياً",
              icon: CupertinoIcons.xmark_circle,
              color: const Color(0xFFE54560),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RejectionReasonScreen(
                      offerId: offer.id?.toString() ?? '',
                    ),
                  ),
                );
              },
            ),
            verticalSpace(24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActionOption(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.chevron_left, size: 14.sp, color: Colors.grey),
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                color: const Color(0xFF0F2D37),
                fontWeight: FontWeight.w600,
              ),
            ),
            horizontalSpace(12.w),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          if (state.paymentUrl == "rejected") {
             // Already handled by popping in RejectionReasonScreen or similar
          } else {
             Navigator.pushNamed(
                context,
                Routes.elitePayment,
                arguments: {
                  'request': request,
                  'offer': offer,
                },
              );
          }
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message, style: const TextStyle(fontFamily: 'Cairo'))),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: buildBlurredAppBar(context, "عرض التسعير"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Label
                        Text(
                          "خدمة",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFC4C4C4),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        verticalSpace(4.h),
                        // Title
                        Text(
                          request.eliteServiceCategory?.name ?? "توكيل محامي",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F2D37),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        verticalSpace(16.h),
                        
                        // Badges Row
                        Row(
                          children: [
                            Flexible(
                              child: _buildBadge(
                                "5 أيام", 
                                backgroundColor: const Color(0xFFE9EDEF),
                                textColor: const Color(0xFF0F2D37),
                              ),
                            ),
                            horizontalSpace(10.w),
                            Flexible(
                              child: _buildBadge(
                                "متوسط الأهمية - ${offer.price ?? 2500} رس",
                                backgroundColor: const Color(0xFFFAF6E9),
                                textColor: const Color(0xFFD4AF37),
                              ),
                            ),
                          ],
                        ),
                        
                        verticalSpace(24.h),
                        Divider(color: Colors.grey[100], thickness: 1),
                        verticalSpace(24.h),
                        
                        // Description text
                        Text(
                          request.description ?? "لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات...",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFFA5A5A5),
                            fontFamily: 'Cairo',
                            height: 1.8,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Bottom Action Buttons
              Column(
                children: [
                  // Accept Button
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.read<YmtazEliteCubit>().approveOffer(
                              offer.id?.toString() ?? '',
                              'accepted',
                            );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            "قبول السعر", 
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
                  verticalSpace(12.h),
                  
                  // Ignore Button
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _showIgnoreOptions(context),
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F4),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "تجاهل", 
                              style: TextStyle(
                                fontSize: 16.sp, 
                                fontWeight: FontWeight.bold, 
                                fontFamily: 'Cairo',
                                color: const Color(0xFFE54560),
                              )
                            ),
                            horizontalSpace(12.w),
                            Icon(
                              CupertinoIcons.trash, 
                              color: const Color(0xFFE54560), 
                              size: 20.sp
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, {required Color backgroundColor, required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
