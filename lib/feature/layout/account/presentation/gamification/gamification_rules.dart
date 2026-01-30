import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../data/models/points_rules.dart';

class GamificationRulesPage extends StatelessWidget {
  const GamificationRulesPage({super.key, required this.rules});

  final PointsRules rules;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قواعد الاكتساب",
          style: TextStyles.cairo_14_bold.copyWith(
            color: appColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpace(20.h),
              _buildLevelUpIcon(),
              Container(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rules.data?.activities?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildTaskItem(
                      points: int.parse(
                          rules.data!.activities![index].experiencePoints!),
                      title: "تكتسب نقاط عند",
                      subtitle: rules.data!.activities![index].name!,
                      index: index,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalSpace(10.h);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelUpIcon() {
    return Stack(
      children: [
        Positioned(
          top: 30.h,
          right: 20.w,
          child: SvgPicture.asset(
            AppAssets.levelUp,
            width: 70.w,
            height: 70.h,
          ),
        ),
        Positioned(
          child: Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  spreadRadius: 2,
                  color: Colors.deepOrange.withOpacity(0.2),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(
      {required String title,
      required String subtitle,
      required int points,
      required int index}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            // Shadow color
            spreadRadius: 3,
            // Spread radius
            blurRadius: 10,
            // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        shape: RoundedRectangleBorder(
          // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? appColors.blue90
                      : appColors.primaryColorYellow,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r)),
                ),
              ),
              horizontalSpace(20.w),
              Text(subtitle,
                  textAlign: TextAlign.start,
                  style: TextStyles.cairo_13_bold.copyWith(
                    color: appColors.blue100,
                  )),
            ],
          ),
          Row(
            children: [
              Text(
                "$points نقطة",
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.primaryColorYellow,
                ),
              ),
              horizontalSpace(10.w),
            ],
          ),
        ],
      ),
    );
  }
}
