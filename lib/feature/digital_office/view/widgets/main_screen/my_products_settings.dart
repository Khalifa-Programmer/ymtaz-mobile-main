import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../layout/account/presentation/widgets/custom_list_tile.dart';
import '../../advisory_adjust/add_advisory.dart';
import '../../appointmets_adjust/add_appointments.dart';
import '../../sevices_adjust/add_services.dart';

class MyProductsSetting extends StatelessWidget {
  const MyProductsSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10.h),
        Text(
          'تخصيص المنتجات',
          style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
        ),
        verticalSpace(10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                  title: 'تخصيص الاستشارات',
                  icon: CupertinoIcons.add_circled_solid,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAdvisory(),
                        ));
                  }),
              CustomListTile(
                  title: 'تخصيص الخدمات',
                  icon: CupertinoIcons.add_circled_solid,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddServices(),
                        ));
                  }),
              CustomListTile(
                  title: 'تخصيص المواعيد',
                  icon: CupertinoIcons.add_circled_solid,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAppointments(),
                        ));
                  }),
            ],
          ),
        ),
        verticalSpace(10.h),
        Text(
          'تخصيص مواقيت العمل',
          style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
        ),
        verticalSpace(10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                  title: 'مواقيت العمل للاستشارات',
                  icon: CupertinoIcons.table_badge_more_fill,
                  onTap: () {
                    context.pushNamed(Routes.myWorkingHoursAdvisory);
                  }),
              // CustomListTile(
              //     title: 'مواقيت العمل للخدمات',
              //     icon: CupertinoIcons.table_badge_more_fill,
              //     onTap: () {
              //       context.pushNamed(Routes.myWorkingHoursServices);
              //     }),
              CustomListTile(
                  title: 'مواقيت العمل للمواعيد',
                  icon: CupertinoIcons.table_badge_more_fill,
                  onTap: () {
                    context.pushNamed(Routes.myWorkingHoursAppointmetns);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
