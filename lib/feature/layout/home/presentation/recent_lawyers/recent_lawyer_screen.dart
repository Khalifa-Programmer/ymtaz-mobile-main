import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/layout/home/data/models/recent_joined_lawyers_model.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../digital_guide/presentation/digetal_providers_screen.dart';
import '../../../account/presentation/guest_screen.dart';

class RecentLawyers extends StatelessWidget {
  const RecentLawyers(this.homeData, {super.key});

  final List<NewAdvisory> homeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الدليل الرقمي",
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.separated(
            itemBuilder: (context, index) {
              var lawyer = homeData[index];
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  var userType = CacheHelper.getData(key: "userType");
                  if (userType == "client" || userType == "provider") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DigitalProvidersScreen(
                            idLawyer: lawyer.id.toString(),
                          ),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GestScreen(),
                        ));
                  }

                  // context.pushNamed(Routes.digitalGuideSearch, arguments: category);
                },
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(lawyer.photo ??
                              "https://api.ymtaz.sa/uploads/person.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${lawyer.name}",
                            style: TextStyles.cairo_14_bold.copyWith(
                              color: appColors.blue100,
                            )),
                        verticalSpace(6.h),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: appColors.primaryColorYellow,
                              size: 20.sp,
                            ),
                            horizontalSpace(0.w),
                            Text(lawyer.cityRel!.title ?? "",
                                style: TextStyles.cairo_12_semiBold),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 0.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: appColors.lightYellow10,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text("جديد",
                          style: TextStyles.cairo_12_semiBold.copyWith(
                            color: appColors.blue100,
                          )),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: const Divider(
                  thickness: 0.5,
                ),
              );
            },
            itemCount: homeData.length),
      ),
    );
  }
}
