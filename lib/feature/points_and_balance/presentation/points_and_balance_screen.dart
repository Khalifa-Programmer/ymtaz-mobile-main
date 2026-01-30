import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/points_and_balance/presentation/balance_screen.dart';
import 'package:yamtaz/feature/points_and_balance/presentation/points_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';

class PointsAndBalanceScreen extends StatelessWidget {
  const PointsAndBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // flexibleSpace: ClipRect(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 60.w, sigmaY: 100.h),
            //     child: Container(
            //       color: Colors.transparent,
            //     ),
            //   ),
            // ),

            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text("الرصيد والنقاط",
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
            bottom: TabBar(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                unselectedLabelColor: appColors.blue100,
                unselectedLabelStyle: TextStyles.cairo_12_bold.copyWith(
                  color: appColors.blue100,
                ),
                physics: const BouncingScrollPhysics(),
                dividerColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding:
                    EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
                labelStyle: TextStyles.cairo_12_bold.copyWith(
                  color: appColors.white,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: appColors.blue100,
                  boxShadow: [
                    BoxShadow(
                      color: appColors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("الرصيد"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("النقاط"),
                    ),
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            BalanceScreen(),
            PointsScreen(),
          ]),
        ));
  }
}
