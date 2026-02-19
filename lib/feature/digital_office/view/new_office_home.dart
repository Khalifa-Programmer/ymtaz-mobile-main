import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/work_experience_screen.dart';
import 'package:yamtaz/feature/layout/home/presentation/home_screen.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/account/presentation/gamification/points_screen.dart';
import 'package:yamtaz/feature/notifications/logic/notification_cubit.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/lawyer_package_card.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/time_remainig_progress.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';
import '../logic/office_provider_state.dart';
import 'my_clients.dart';

class NewOfficeHome extends StatefulWidget {
  const NewOfficeHome({super.key});

  @override
  State<NewOfficeHome> createState() => _NewOfficeHomeState();
}

class _NewOfficeHomeState extends State<NewOfficeHome> {
  @override
  void initState() {
    super.initState();

    // Perform actions after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getit<NotificationCubit>().getNotifications();

      // Fetch user type once to avoid redundant calls
      final userType = CacheHelper.getData(key: 'userType');

      if (showDialogComplete) {
        if (userType == 'provider') {
          _checkProviderProfileCompletion();
        }
      }
    });
  }

  // Check provider profile completion and show dialog if necessary
  void _checkProviderProfileCompletion() {
    final userDataResponse = getit<MyAccountCubit>().userDataResponse;

    if (userDataResponse != null &&
        (userDataResponse.data!.account!.profileComplete == 0 ||
            userDataResponse.data!.account!.profileComplete == null)) {
      showCustomDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final myOfficeResponseModel =
            context.read<OfficeProviderCubit>().myOfficeResponseModel;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildBlurredUserAppBar(context, 'الرئيسية'),
          body: SingleChildScrollView(
            child: ConditionalBuilder(
              condition: getit<MyAccountCubit>().userDataResponse != null &&
                  myOfficeResponseModel != null,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      SizedBox(height: 115.h),
                      CardComponent(),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                    value: getit<MyAccountCubit>(),
                                    child: WorkExperienceScreen()),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.r),
                              bottomRight: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                appColors.primaryColorYellow.withOpacity(0.1),
                                appColors.lightYellow10.withOpacity(0.2),
                                Colors.orangeAccent.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.work,
                                  color: appColors.blue100, size: 15.sp),
                              horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الخبرات العملية',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.blue100,
                                    ),
                                  ),
                                  Text(
                                    'قم بإضافة خبراتك العملية لإظهارها في ملفك',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: appColors.blue100,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                  color: appColors.blue100, size: 15.sp),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ProductsCard(),
                      SizedBox(height: 20.h),
                      LawyerPackageCard(
                          package: getit<MyAccountCubit>()
                              .userDataResponse!
                              .data!
                              .account!
                              .package),
                      SizedBox(height: 20.h),
                      myOfficeResponseModel == null
                          ? Skeletonizer(
                              enabled: true,
                              child: TabsAnalysis(data: OfficeData()))
                          : TabsAnalysis(data: myOfficeResponseModel.data!),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyClients(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.r),
                              bottomRight: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF2280FF).withOpacity(0.1),
                                Color(0xFFCE7182).withOpacity(0.2),
                                Colors.orangeAccent.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'منطقة العملاء',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.blue100,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Icon(Icons.arrow_forward_ios,
                                  color: appColors.blue100, size: 15.sp),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                          width: 350.w,
                          padding: EdgeInsets.all(1.5.r),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                appColors.primaryColorYellow.withOpacity(0.5),
                                appColors.white,
                              ],
                              end: Alignment.bottomLeft,
                              begin: Alignment.topRight,
                              stops: [0.1, 0.3],
                            ),
                            borderRadius:
                                BorderRadius.circular(20.r), // تحديد الحواف
                          ),
                          child: myOfficeResponseModel == null
                              ? Skeletonizer(
                                  enabled: true,
                                  child: TabsAnalysis(data: OfficeData()))
                              : StatisticsCard(
                                  data: myOfficeResponseModel.data!)),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
  }
}

class ProductsCard extends StatelessWidget {
  const ProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: appColors.white,
        // gradient: const LinearGradient(
        //   colors: [
        //     Color(0xFFF3F9FF),
        //     Color(0xFFFFFAF2),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: Offset(0, 2.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الطلبات",
            style:
                TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildProductItem('الاستشارات', AppAssets.advisoryOrder, () {
                context.pushNamed(Routes.myAdvisoriesOffice);
              }),
              buildProductItem('الخدمات', AppAssets.serviceOrder, () {
                context.pushNamed(Routes.myServicesOffice);
              }),
              buildProductItem('المواعيد', AppAssets.appointmentOrder, () {
                context.pushNamed(Routes.myAppointmentOffice);
              }),
            ],
          ),
          // todo elite card
          // verticalSpace(10.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     buildProductItem('طلبات النخبة', AppAssets.crown, () {
          //       context.pushNamed(Routes.eliteRequestsClients);
          //     }),
          //
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget buildProductItem(String title, String svg, Function onTap) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0.9),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appColors.primaryColorYellow.withOpacity(0.5),
                    appColors.white,
                  ],
                  end: Alignment.bottomLeft,
                  begin: Alignment.topRight,
                  stops: [0.1, 0.3],
                ),
                borderRadius: BorderRadius.circular(10.r), // تحديد الحواف
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFF3F9FF),
                      Color(0xFFFFFAF2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  svg,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyles.cairo_12_bold,
            ),
          ],
        ),
      ),
    );
  }
}

class SystemsCard extends StatelessWidget {
  const SystemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: appColors.white,
        // gradient: const LinearGradient(
        //   colors: [
        //     Color(0xFFF3F9FF),
        //     Color(0xFFFFFAF2),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: Offset(0, 2.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الانظمة المساندة",
            style:
                TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildProductItem('دليل الانظمة', AppAssets.digitalGuideNew, () {
                context.pushNamed(Routes.lawGuide);
              }),
              buildProductItem('الدليل العدلي', AppAssets.judgeJuide, () {
                context.pushNamed(Routes.forensicGuide);
              }),
              buildProductItem('مكتبة يمتاز', AppAssets.booksNew, () {
                context.pushNamed(Routes.libraryGuide);
              }),
            ],
          )
        ],
      ),
    );
  }
}

Widget buildProductItem(String title, String svg, Function onTap) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0.9),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appColors.primaryColorYellow.withOpacity(0.5),
                  appColors.white,
                ],
                end: Alignment.bottomLeft,
                begin: Alignment.topRight,
                stops: [0.1, 0.3],
              ),
              borderRadius: BorderRadius.circular(10.r), // تحديد الحواف
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF3F9FF),
                    Color(0xFFFFFAF2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.r,
                    offset: Offset(0, 2.r),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                svg,
                width: 25,
                height: 25,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyles.cairo_12_bold,
          ),
        ],
      ),
    ),
  );
}


class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key, required this.data});

  final OfficeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3F9FF),
            Color(0xFFFFFAF2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: Offset(0, 2.r),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: appColors.primaryColorYellow.withOpacity(0.2),
                radius: 15,
                child: Icon(
                  Icons.trending_up,
                  color: appColors.primaryColorYellow,
                  size: 15,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'الإحصائيات',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              horizontalSpace(20.w),
              StatItem(
                title: 'الرصيد',
                amount: "${data.wallet!.total} ريال",
                change: ' ',
                isPositive: true,
              ),
              Spacer(),
              StatItem(
                title: 'الاستشارات',
                amount: '${data.advisoryServices!.amounts!.total} ريال',
                change: '${data.advisoryServices!.amounts!.percentageChange}%',
                isPositive:
                    data.advisoryServices!.amounts!.changeDirection == 'up',
              ),
              horizontalSpace(20.w),
            ],
          ),
          const Divider(height: 40, color: Colors.black26),
          Row(
            children: [
              horizontalSpace(20.w),
              StatItem(
                title: 'المواعيد',
                amount: '${data.appointments!.amounts!.total} ريال',
                change: '${data.appointments!.amounts!.percentageChange}%',
                isPositive: data.appointments!.amounts!.changeDirection == 'up',
              ),
              Spacer(),
              StatItem(
                title: 'الخدمات',
                amount: '${data.services!.amounts!.total} ريال',
                change: '${data.services!.amounts!.percentageChange}%',
                isPositive: data.services!.amounts!.changeDirection == 'up',
              ),
              horizontalSpace(20.w),
            ],
          ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String title;
  final String amount;
  final String change;
  final bool isPositive;

  const StatItem({
    super.key,
    required this.title,
    required this.amount,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              change,
              style: TextStyle(
                fontSize: 14.sp,
                color: isPositive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: isPositive ? Colors.green : Colors.red,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }
}

class CardComponent extends StatelessWidget {
  const CardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: getit<MyAccountCubit>().userDataResponse != null,
      builder: (BuildContext context) {
        return Container(
          width: 350.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              verticalSpace(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: getit<MyAccountCubit>()
                            .userDataResponse!
                            .data!
                            .account!
                            .currentRank!
                            .image!
                            .toString(),
                        width: 30.0.w,
                        height: 30.0.h,
                        placeholder: (context, url) => SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: const CircularProgressIndicator(strokeWidth: 2)),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          AppAssets.rank,
                          width: 30.0.w,
                          height: 30.0.h,
                        ),
                      ),
                      verticalSpace(5.h),
                      Text(
                        getit<MyAccountCubit>()
                            .userDataResponse!
                            .data!
                            .account!
                            .currentRank!
                            .name!
                            .toString(),
                        style: TextStyle(
                          color: appColors.primaryColorYellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Item(
                    icon: AppAssets.star,
                    value: getit<MyAccountCubit>()
                        .userDataResponse!
                        .data!
                        .account!
                        .daysStreak
                        .toString(),
                    label: 'يوم',
                    color: appColors.primaryColorYellow,
                  ),
                  Item(
                    icon: AppAssets.flash,
                    value: getit<MyAccountCubit>()
                        .userDataResponse!
                        .data!
                        .account!
                        .xp
                        .toString(),
                    label: 'نقاط الخبرة',
                    color: appColors.primaryColorYellow,
                  ),
                  Item(
                    icon: AppAssets.target,
                    value: getit<MyAccountCubit>()
                        .userDataResponse!
                        .data!
                        .account!
                        .points
                        .toString(),
                    label: 'نقطة',
                    color: appColors.primaryColorYellow,
                  ),
                ],
              ),
              verticalSpace(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: getit<MyAccountCubit>()..getPointsRules(),
                          child: PointsGamificationScreen(
                            daysStreak: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .daysStreak!,
                            points: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .points!,
                            xp: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .xp!,
                            currentLevel: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .currentLevel!,
                            currentRank: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .currentRank!
                                .name!,
                            xpUntilNextLevel: getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .account!
                                .xpUntilNextLevel!,
                          ),
                        ),
                      ));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF2280FF).withOpacity(0.1),
                        Color(0xFFCE7182).withOpacity(0.2),
                        Colors.orangeAccent.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مهام الترقي',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: appColors.blue100,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Icon(Icons.arrow_forward_ios,
                          color: appColors.blue100, size: 15.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      fallback: (BuildContext context) {
        return Shimmer(
          gradient: LinearGradient(
            colors: [
              Colors.grey[300]!,
              Colors.grey[100]!,
              Colors.grey[300]!,
            ],
            begin: Alignment(-1, -1),
            end: Alignment(1, 1),
            stops: const [0.4, 0.5, 0.6],
          ),
          child: Container(),
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color? color;

  const Item({super.key, 
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          color: color,
          width: 20.w,
          height: 20.h,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class NotifyCompelete extends StatelessWidget {
  const NotifyCompelete({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: getit<MyAccountCubit>()
          .userDataResponse!
          .data!
          .account!
          .experiences!
          .isEmpty,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyClients(),
                ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF2280FF).withOpacity(0.1),
                  Color(0xFFCE7182).withOpacity(0.2),
                  Colors.orangeAccent.withOpacity(0.2),
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_rounded,
                    color: appColors.blue100, size: 15.sp),
                horizontalSpace(10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أضف الخبرات العملية',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: appColors.blue100,
                      ),
                    ),
                    Text(
                      'لتحصل علىطلبات من عملائك وتقوية ملفك',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: appColors.blue100,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios,
                    color: appColors.blue100, size: 15.sp),
              ],
            ),
          ),
        );
      },
      fallback: (BuildContext context) {
        return Container();
      },
    );
  }
}
