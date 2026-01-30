import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';

import '../../logic/my_account_cubit.dart';
import 'gamification_rules.dart';

class PointsGamificationScreen extends StatelessWidget {
  const PointsGamificationScreen(
      {super.key,
      required this.daysStreak,
      required this.points,
      required this.xp,
      required this.currentLevel,
      required this.currentRank,
      required this.xpUntilNextLevel});

  final int daysStreak;
  final int points;
  final int xp;
  final int currentLevel;
  final int xpUntilNextLevel;
  final String currentRank;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('النقاط',
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
          ),
          body: ConditionalBuilder(
            condition: state is SuccessPointsRules,
            builder: (BuildContext context) {
              var rules = (state as SuccessPointsRules).data;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        margin: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.rank),
                                horizontalSpace(5.w),
                                Text('الرتبة الحالية',
                                    style: TextStyles.cairo_14_semiBold),
                                horizontalSpace(5.w),
                                Spacer(),
                                Text(currentRank,
                                    style: TextStyles.cairo_14_bold.copyWith(
                                        color: appColors.primaryColorYellow)),
                              ],
                            ),
                            verticalSpace(10.h),
                            SizedBox(
                              height: 8.h,
                              child: LinearProgressIndicator(
                                value: xp / xpUntilNextLevel,
                                backgroundColor: appColors.grey3,
                                borderRadius: BorderRadius.circular(10),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    appColors.primaryColorYellow),
                              ),
                            ),
                            verticalSpace(10.h),
                            Row(
                              children: [
                                Text(xp.toString(),
                                    style: TextStyles.cairo_14_semiBold),
                                horizontalSpace(5.w),
                                Text('/', style: TextStyles.cairo_14_semiBold),
                                horizontalSpace(5.w),
                                Text(xpUntilNextLevel.toString(),
                                    style: TextStyles.cairo_14_bold.copyWith(
                                        color: appColors.primaryColorYellow)),
                              ],
                            ),
                            verticalSpace(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // --- Box 1: Days Streak ---
                                Expanded(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minHeight: 85.h),
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            4.w), // Small gap between boxes
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: const Offset(3, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Takes only needed space
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.starPoints,
                                          color: Colors.deepOrangeAccent,
                                          height: 24
                                              .h, // Explicit height for the SVG to keep it consistent
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(daysStreak.toString(),
                                            style: TextStyles.cairo_14_bold),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('يوم متواصل',
                                              style: TextStyles
                                                  .cairo_14_semiBold
                                                  .copyWith(
                                                      color: appColors.grey5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // --- Box 2: Points ---
                                Expanded(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minHeight: 85.h),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: const Offset(3, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(AppAssets.target,
                                            height: 24.h),
                                        SizedBox(height: 4.h),
                                        Text(points.toString(),
                                            style: TextStyles.cairo_14_bold),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('نقطة',
                                              style: TextStyles
                                                  .cairo_14_semiBold
                                                  .copyWith(
                                                      color: appColors.grey5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // --- Box 3: XP ---
                                Expanded(
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minHeight: 85.h),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: const Offset(3, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(AppAssets.flash,
                                            height: 24.h),
                                        SizedBox(height: 4.h),
                                        Text(xp.toString(),
                                            style: TextStyles.cairo_14_bold),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('نقاط الخبرة',
                                              style: TextStyles
                                                  .cairo_14_semiBold
                                                  .copyWith(
                                                      color: appColors.grey5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 220.h,
                        // color: appColors.red,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 50.h,
                                right: -50,
                                child:
                                    SvgPicture.asset(AppAssets.achieveUnlock)),
                            Positioned(
                              top: 50.h,
                              right: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'فتح الإنجاز',
                                    style: TextStyles.cairo_14_semiBold,
                                  ),
                                  verticalSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$xp',
                                        style: TextStyles.cairo_18_bold
                                            .copyWith(
                                                color: appColors
                                                    .primaryColorYellow),
                                      ),
                                      horizontalSpace(5.w),
                                      Text(
                                        '/',
                                        style: TextStyles.cairo_12_bold
                                            .copyWith(color: appColors.grey5),
                                      ),
                                      Text(
                                        '$xpUntilNextLevel',
                                        style: TextStyles.cairo_12_bold
                                            .copyWith(color: appColors.grey5),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(10.h),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      'قم بمشاركة التطبيق مع أصدقائك وأحصل على المزيد من النقاط',
                                      style: TextStyles.cairo_12_bold
                                          .copyWith(color: appColors.grey5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 30.h,
                                right: -150,
                                child: Container(
                                  height: 150.h,
                                  width: 400.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 50,
                                          spreadRadius: 1,
                                          color: Colors.deepOrange
                                              .withOpacity(0.15))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GamificationRulesPage(rules: rules),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 4.r,
                                blurRadius: 9.r,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 4.h,
                                      child: SvgPicture.asset(
                                        AppAssets.levelUp,
                                        width: 30.w,
                                        height: 30.w,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        height: 40.h,
                                        width: 59.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 20.r,
                                                spreadRadius: 2.r,
                                                color: Colors.deepOrange
                                                    .withOpacity(0.3))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              horizontalSpace(20.w),
                              Text(
                                "قواعد الاكتساب",
                                style: TextStyles.cairo_12_bold,
                              ),
                              Spacer(),
                              Icon(CupertinoIcons.right_chevron)
                            ],
                          ),
                        ),
                      ),
                      // verticalSpace(20.h),
                      // ListView(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   children: [
                      //     Text(
                      //       "المهام",
                      //       style: TextStyles.cairo_14_bold,
                      //     ),
                      //     verticalSpace(10.h),
                      //     Container(
                      //       decoration: ShapeDecoration(
                      //         color: Colors.white,
                      //         shadows: [
                      //           BoxShadow(
                      //             color: Colors.black12.withOpacity(0.04),
                      //             // Shadow color
                      //             spreadRadius: 3,
                      //             // Spread radius
                      //             blurRadius: 10,
                      //             // Blur radius
                      //             offset:
                      //             const Offset(0, 3), // Offset in x and y direction
                      //           ),
                      //         ],
                      //         shape: RoundedRectangleBorder(
                      //           // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //
                      //           borderRadius: BorderRadius.circular(4.r),
                      //         ),
                      //       ),
                      //       child: ListTile(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         title: Text(
                      //           'اطلب',
                      //           style: TextStyles.cairo_12_semiBold.copyWith(
                      //             color: appColors.grey20,
                      //           ),
                      //         ),
                      //         subtitle: Text(
                      //           'توكيل محام',
                      //           style: TextStyles.cairo_12_bold.copyWith(
                      //             color: appColors.blue100,
                      //           ),
                      //         ),
                      //         trailing: Text(
                      //           '
                      //           100 نقطة',
                      //           style: TextStyles.cairo_14_bold.copyWith(
                      //             color: appColors.primaryColorYellow,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     verticalSpace(10.h),
                      //     Container(
                      //       decoration: ShapeDecoration(
                      //         color: Colors.white,
                      //         shadows: [
                      //           BoxShadow(
                      //             color: Colors.black12.withOpacity(0.04),
                      //             // Shadow color
                      //             spreadRadius: 3,
                      //             // Spread radius
                      //             blurRadius: 10,
                      //             // Blur radius
                      //             offset:
                      //             const Offset(0, 3), // Offset in x and y direction
                      //           ),
                      //         ],
                      //         shape: RoundedRectangleBorder(
                      //           // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //
                      //           borderRadius: BorderRadius.circular(4.r),
                      //         ),
                      //       ),
                      //       child: ListTile(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         title: Text(
                      //           'اطلب',
                      //           style: TextStyles.cairo_12_semiBold.copyWith(
                      //             color: appColors.grey20,
                      //           ),
                      //         ),
                      //         subtitle: Text(
                      //           'ترجمة عقد',
                      //           style: TextStyles.cairo_12_bold.copyWith(
                      //             color: appColors.blue100,
                      //           ),
                      //         ),
                      //         trailing: Text(
                      //           '100 نقطة',
                      //           style: TextStyles.cairo_14_bold.copyWith(
                      //             color: appColors.primaryColorYellow,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     verticalSpace(10.h),
                      //     Container(
                      //       decoration: ShapeDecoration(
                      //         color: Colors.white,
                      //         shadows: [
                      //           BoxShadow(
                      //             color: Colors.black12.withOpacity(0.04),
                      //             // Shadow color
                      //             spreadRadius: 3,
                      //             // Spread radius
                      //             blurRadius: 10,
                      //             // Blur radius
                      //             offset:
                      //             const Offset(0, 3), // Offset in x and y direction
                      //           ),
                      //         ],
                      //         shape: RoundedRectangleBorder(
                      //           // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //
                      //           borderRadius: BorderRadius.circular(4.r),
                      //         ),
                      //       ),
                      //       child: ListTile(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         title: Text(
                      //           'شارك',
                      //           style: TextStyles.cairo_12_semiBold.copyWith(
                      //             color: appColors.grey20,
                      //           ),
                      //         ),
                      //         subtitle: Text(
                      //           'شارك التطبيق',
                      //           style: TextStyles.cairo_12_bold.copyWith(
                      //             color: appColors.blue100,
                      //           ),
                      //         ),
                      //         trailing: Text(
                      //           '100 نقطة',
                      //           style: TextStyles.cairo_14_bold.copyWith(
                      //             color: appColors.primaryColorYellow,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      verticalSpace(30.h),
                    ],
                  ),
                ),
              );
            },
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
