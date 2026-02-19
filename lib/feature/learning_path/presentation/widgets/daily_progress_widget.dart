import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/learning_path/presentation/widgets/week_day_item_widget.dart';

class DailyProgressWidget extends StatefulWidget {
  const DailyProgressWidget({super.key});

  @override
  State<DailyProgressWidget> createState() => _DailyProgressWidgetState();
}

class _DailyProgressWidgetState extends State<DailyProgressWidget> {
  String _selectedTab = 'يومي';
  final int _goalProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 'اسبوعي';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: _selectedTab == 'اسبوعي' 
                          ? appColors.white 
                          : appColors.grey1,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'اسبوعي',
                      style: TextStyles.cairo_14_medium.copyWith(
                        color: appColors.blue100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 'يومي';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: _selectedTab == 'يومي' 
                          ? appColors.white 
                          : appColors.grey1,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'يومي',
                      style: TextStyles.cairo_14_medium.copyWith(
                        color: appColors.blue100,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: appColors.grey2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'تعديل هدفك',
                  style: TextStyles.cairo_12_medium.copyWith(
                    color: appColors.grey10,
                  ),
                ),
              ),
              Text(
                'اقرأ وتدرب كل يوم لتحقيق أهدافك.',
                style: TextStyles.cairo_12_medium.copyWith(
                  color: appColors.blue100,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: appColors.grey2),
                      ),
                    ),
                    Container(
                      width: 32.h,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            appColors.primaryColorYellow,
                            appColors.darkYellow90,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appColors.primaryColorYellow.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'الهدف اليومي',
                    style: TextStyles.cairo_14_semiBold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'فصول',
                        style: TextStyles.cairo_12_regular.copyWith(
                          color: appColors.grey10,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$_goalProgress/1',
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: appColors.blue100,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'تدريبات',
                        style: TextStyles.cairo_12_regular.copyWith(
                          color: appColors.grey10,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$_goalProgress/2',
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: appColors.blue100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeekDayItemWidget(day: 'الجمعة', isRest: true),
              WeekDayItemWidget(day: 'الخميس'),
              WeekDayItemWidget(day: 'الأربعاء'),
              WeekDayItemWidget(day: 'الثلاثاء'),
              WeekDayItemWidget(day: 'الإثنين', isComplete: true),
              WeekDayItemWidget(day: 'الأحد', isSelected: true, isComplete: true),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: appColors.red5,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'يوم الراحة',
                    style: TextStyles.cairo_10_medium.copyWith(
                      color: appColors.red,
                    ),
                  ),
                ),
                Text(
                  'عمل رائع، استمر بالتقدم!',
                  style: TextStyles.cairo_12_medium.copyWith(
                    color: appColors.blue100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
