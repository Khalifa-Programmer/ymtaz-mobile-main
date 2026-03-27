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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            _buildBadge(
                              "5 أيام", 
                              backgroundColor: const Color(0xFFE9EDEF),
                              textColor: const Color(0xFF0F2D37),
                            ),
                            horizontalSpace(10.w),
                            _buildBadge(
                              "متوسط الأهمية - ${offer.price ?? 2500} رس",
                              backgroundColor: const Color(0xFFFAF6E9),
                              textColor: const Color(0xFFD4AF37),
                            ),
                          ],
                        ),
                        
                        verticalSpace(24.h),
                        Divider(color: Colors.grey[100], thickness: 1),
                        verticalSpace(24.h),
                        
                        // Description text
                        Text(
                          request.description ?? "لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات لطلب استشارة قانونية فيما يتعلق بتصميم وتقييم العقود وتأسيس الشركات.",
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
                        Navigator.pushNamed(
                          context, 
                          Routes.elitePayment, 
                          arguments: {
                            'request': request,
                            'offer': offer,
                          }
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37), // Golden color from image
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
                  
                  // Ignore Button (Redesigned matching image: text then icon in RTL means icon on right)
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F4), // Very light pink
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
