import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';
import 'package:yamtaz/feature/digital_office/view/sevices_adjust/add_services.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/user_profile_row.dart';

import '../../../core/constants/assets.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/router/routes.dart';
import '../../layout/account/logic/my_account_cubit.dart';
import '../../layout/account/presentation/widgets/custom_list_tile.dart';
import '../logic/office_provider_cubit.dart';
import 'advisory_adjust/add_advisory.dart';
import 'appointmets_adjust/add_appointments.dart';

class AdjustOfficeMain extends StatelessWidget {
  const AdjustOfficeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('التخصيص',
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition:
                getit<OfficeProviderCubit>().myOfficeResponseModel != null,
            builder: (BuildContext context) {
              var data =
                  getit<OfficeProviderCubit>().myOfficeResponseModel!.data;

              return ConditionalBuilder(
                condition: getit<MyAccountCubit>()
                        .userDataResponse!
                        .data!
                        .account!
                        .profileComplete ==
                    1,
                builder: (BuildContext context) {
                  return ListView(
                    children: [
                      verticalSpace(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Stack(
                          children: [
                            if (getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .account!
                                    .subscribed ==
                                false)
                              AdjustData(),
                            if (getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .account!
                                    .subscribed ==
                                false)
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 7.0, sigmaY: 7.0),
                                  child: Container(
                                    height: 600.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(
                                          0.04), // Adjust overlay color and opacity
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.lock,
                                          color: appColors.primaryColorYellow,
                                          size: 30.sp,
                                        ),
                                        verticalSpace(10.h),
                                        Text(
                                          'القنوات الرقمية غير مفعلة لهذا الحساب',
                                          style: TextStyle(
                                            color: appColors.blue100,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        verticalSpace(5.h),
                                        Text(
                                          'يلزمك تفعيل الاشتراك بإحدى الباقات المجانية أو المدفوعة لتتمكن من تخصيص المنتجات',
                                          style: TextStyle(
                                            color: appColors.blue100,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        verticalSpace(20.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: CustomButton(
                                            title: "استعراض الباقات",
                                            onPress: () {
                                              context
                                                  .pushNamed(Routes.packages);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (getit<MyAccountCubit>()
                              .userDataResponse!
                              .data!
                              .account!
                              .subscribed ==
                          true)
                        AdjustData(),
                    ],
                  );
                },
                fallback: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            verticalSpace(10.h),
                            GestureDetector(
                              onTap: () {
                                if (CacheHelper.getData(key: 'userType') ==
                                    'client') {
                                } else {
                                  context.pushNamed(Routes.profileProvider);
                                }
                              },
                              child: UserProfileRow(
                                  paddingTop: 0,
                                  imageUrl: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .photo!,
                                  name: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .name!,
                                  isVerified: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .hasBadge,
                                  color: getColor(getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .currentRank!
                                      .borderColor!),
                                  image: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .currentRank!
                                      .image!),
                            ),
                            verticalSpace(24.h),
                            TabsAnalysis(data: data!),
                            verticalSpace(20.h),
                            // const MyOrdersItemsCard(),
                            verticalSpace(30.h),
                          ],
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white.withOpacity(
                                    0.02), // Adjust overlay color and opacity
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.crown,
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                  verticalSpace(10.h),
                                  Text(
                                    'أهلاً بك في مكتبك الإلكتروني لأعمالك القانونية',
                                    style: TextStyle(
                                      color: appColors.blue100,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'لتتمكن من البدء بالعمل يلزمك استكمال ملفك الشخصي كمقدم خدمة معتمد لدى يمتاز',
                                    style: TextStyle(
                                      color: appColors.blue100,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  verticalSpace(40.h),
                                  CustomButton(
                                    title: "استكمال البيانات",
                                    onPress: () {
                                      context.pushNamed(
                                          Routes.editProviderInstruction);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            fallback: (BuildContext context) => const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            onPressed: () {
              context.pushNamed(Routes.support);
            },
            backgroundColor: appColors.primaryColorYellow,
            label: Text(
              'تحتاج مساعدة؟',
              style: TextStyles.cairo_12_bold.copyWith(color: appColors.white),
            ),
          ),
        );
      },
    );
  }
}

class AdjustData extends StatelessWidget {
  const AdjustData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10.h),
          Text(
            "تخصيص المنتجات",
            style: TextStyles.cairo_14_bold,
          ),
          verticalSpace(5.h),
          Text(
            "لتقديم خدماتك بشكل أفضل يمكنك تخصيص المنتجات التي تقدمها في مكتبك",
            style:
                TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
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
            "تخصيص مواعيد العمل",
            style: TextStyles.cairo_14_bold,
          ),
          verticalSpace(5.h),
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
              ],
            ),
          ),
          verticalSpace(10.h),
        ],
      ),
    );
  }
}

// total
