import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/presentation/gamification/points_screen.dart';

import '../../../../../core/constants/colors.dart';

class Gamification extends StatelessWidget {
  const Gamification(
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: getit<MyAccountCubit>()..getPointsRules(),
                child: PointsGamificationScreen(
                  daysStreak: daysStreak,
                  points: points,
                  xp: xp,
                  currentLevel: currentLevel,
                  currentRank: currentRank,
                  xpUntilNextLevel: xpUntilNextLevel,
                ),
              ),
            ));
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.rank),
                horizontalSpace(5.w),
                Text('الرتبة الحالية', style: TextStyles.cairo_14_semiBold),
                horizontalSpace(5.w),
                Spacer(),
                Text(currentRank,
                    style: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.primaryColorYellow)),
              ],
            ),
            verticalSpace(10.h),
            SizedBox(
              height: 8.h,
              child: LinearProgressIndicator(
                value: (xp / xpUntilNextLevel),
                backgroundColor: appColors.grey3,
                borderRadius: BorderRadius.circular(10),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    appColors.primaryColorYellow),
              ),
            ),
            verticalSpace(10.h),
            Row(
              children: [
                Text(xp.toString(), style: TextStyles.cairo_14_semiBold),
                horizontalSpace(5.w),
                Text('/', style: TextStyles.cairo_14_semiBold),
                horizontalSpace(5.w),
                Text(xpUntilNextLevel.toString(),
                    style: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.primaryColorYellow)),
              ],
            ),
            verticalSpace(10.h),
            Divider(color: appColors.grey5.withOpacity(0.3)),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.starPoints,
                          color: Colors.deepOrange,
                        ),
                        horizontalSpace(5.w),
                        Text(daysStreak.toString(),
                            style: TextStyles.cairo_14_bold),
                      ],
                    ),
                    Text('يوم',
                        style: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.grey5)),
                  ],
                ),
                Container(
                  height: 30.h,
                  width: 1.w,
                  color: appColors.grey5.withOpacity(0.3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.target),
                        horizontalSpace(2.w),
                        Text(points.toString(),
                            style: TextStyles.cairo_14_bold),
                      ],
                    ),
                    Text('نقطة',
                        style: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.grey5)),
                  ],
                ),
                Container(
                  height: 30.h,
                  width: 1.w,
                  color: appColors.grey5.withOpacity(0.3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.flash),
                        horizontalSpace(5.w),
                        Text(xp.toString(), style: TextStyles.cairo_14_bold),
                      ],
                    ),
                    Text('نقاط الخبرة',
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey5)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
