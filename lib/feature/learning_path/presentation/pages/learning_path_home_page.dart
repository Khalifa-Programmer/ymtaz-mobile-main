import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/learning_path/presentation/widgets/widgets.dart';

class LearningPathHomePage extends StatefulWidget {
  const LearningPathHomePage({super.key});

  @override
  State<LearningPathHomePage> createState() => _LearningPathHomePageState();
}

class _LearningPathHomePageState extends State<LearningPathHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ملفي',
          style: TextStyles.cairo_18_bold.copyWith(
            color: appColors.blue100,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appColors.lightYellow10,
          ),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: appColors.grey2),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: appColors.grey10,
                ),
                SizedBox(width: 4.w),
                Text(
                  'الدعم الفني',
                  style: TextStyles.cairo_12_medium.copyWith(
                    color: appColors.grey10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: const Column(
            children: [
              UserProfileWidget(),
              UpgradeButtonWidget(),
              DailyProgressWidget(),
              LearningPathWidget(),
              ExpertSectionWidget(),
              StatisticsWidget(),
              SupportButtonWidget(),
              InviteFriendsWidget(),
            ],
          ),
        ),
      ),
    );
  }
} 
