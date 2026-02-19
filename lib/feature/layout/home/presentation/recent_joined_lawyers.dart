import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/home/presentation/recent_lawyers/recent_lawyer_screen.dart';

import '../../../../core/widgets/users_images.dart';
import '../logic/home_cubit.dart';
import '../logic/home_state.dart';

class RecentJoinedLawyers extends StatelessWidget {
  const RecentJoinedLawyers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var advisories = getit<HomeCubit>().advisoriesNew;
        return advisories != null
            ? advisories.isEmpty
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          appColors.primaryColorYellow.withOpacity(0.5),
                          appColors.lightYellow10,
                          appColors.lightYellow10.withOpacity(0.8),
                          appColors.primaryColorYellow.withOpacity(0.2),
                        ],
                        stops: [0.0, 0.2, 0.4, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(
                      //   color: appColors.blue70,
                      //   width: 1,
                      // ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${advisories.length}+",
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.blue100,
                                    ),
                                  ),
                                  Text(
                                    "منضم حديثاَ",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.blue100,
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RecentLawyers(advisories);
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'ابدأ الآن',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w500,
                                        color: appColors.blue100,
                                      ),
                                    ),
                                    horizontalSpace(5.w),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14.sp,
                                      color: appColors.blue100,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5.h),
                        Container(
                          height: 40.h,
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: UsersImagesWidget(
                            imageList: advisories
                                .map((lawyer) =>
                                    lawyer.photo ??
                                    "https://api.ymtaz.sa/Male.png")
                                .toList(),
                            totalCount: advisories.length,
                            imageRadius: 12.w,
                            // يمكنك تعديل نصف القطر حسب الحاجة
                            imageCount: 9,
                            // الحد الأقصى لعدد الصور المعروضة
                            imageBorderWidth: 1.5.w,
                            overlapDistance: 30.w, // المسافة بين الصور
                          ),
                        ),
                        verticalSpace(10.h),
                      ],
                    ),
                  )
            : Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      4,
                      (index) => Container(
                            width: 20.w,
                            height: 20.h,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          )),
                ),
              );
      },
    );
  }
}
