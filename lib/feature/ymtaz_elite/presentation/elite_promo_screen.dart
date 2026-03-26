import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_consultants_response.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';

class ElitePromoScreen extends StatefulWidget {
  const ElitePromoScreen({super.key});

  @override
  State<ElitePromoScreen> createState() => _ElitePromoScreenState();
}

class _ElitePromoScreenState extends State<ElitePromoScreen> {
  @override
  void initState() {
    super.initState();
    getit<YmtazEliteCubit>().getElitePromoTexts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<YmtazEliteCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: buildBlurredAppBar(context, 'طلب لفريقك الاستشاري'),
      body: SafeArea(
        child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
          builder: (context, state) {
            if (state is YmtazElitePromoTextsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final promoData = context.read<YmtazEliteCubit>().elitePromoTexts;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        verticalSpace(20.h),
                        // Elite Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF6E9),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.workspace_premium, color: const Color(0xFFD4AF37), size: 18.sp),
                              horizontalSpace(8.w),
                              Text(
                                "نخبة",
                                style: TextStyle(
                                  color: const Color(0xFFD4AF37),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(30.h),
                        // Description 1 (Header from dynamic API)
                        Text(
                          promoData?.getValue('advisory-top-section') ?? "توفر خدمة \"النخبة - فريقك الاستشاري\" تجربة مميزة من خلال تقديم حلول استشارية وتنفيذية شاملة تعتمد على التعاون بين نخبة من الخبراء والمستشارين باستخدام أحدث التقنيات لتحقيق رضا العملاء بأعلى معايير الجودة.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFB4B4B4),
                            height: 1.6,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        verticalSpace(30.h),
                        // Triple Cards (Statistics from dynamic API)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard("عدد المحامين", promoData?.getValue('advisory-between-lawyer-section') ?? '4-5 محامي', Icons.groups),
                            _buildStatCard("المدة", promoData?.getValue('advisory-between-time-section') ?? '2-10 أيام', Icons.access_time),
                            _buildStatCard("السعر", "من ${promoData?.getValue('advisory-between-price-section') ?? '200 ر.س'}", Icons.style),
                          ],
                        ),
                        verticalSpace(30.h),
                        // Description 2 (Footer from dynamic API)
                        Text(
                          promoData?.getValue('advisory-bottom-section') ?? "توفر خدمة \"النخبة - فريقك الاستشاري\" تجربة مميزة من خلال تقديم حلول استشارية وتنفيذية شاملة تعتمد على التعاون بين نخبة من الخبراء والمستشارين باستخدام أحدث التقنيات لتحقيق رضا العملاء بأعلى معايير الجودة.",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFB4B4B4),
                            height: 1.8,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        verticalSpace(20.h),
                      ],
                    ),
                  ),
                ),
                // Bottom Button
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushReplacementNamed(Routes.eliteRequestScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "اطلب الآن",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 24.sp),
          verticalSpace(8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFFB4B4B4),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
