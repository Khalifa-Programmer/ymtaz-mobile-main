import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/features_widgets.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/time_remainig_progress.dart';

import '../../../core/constants/assets.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/custom_button.dart';
import '../logic/packages_and_sbuscriptions_cubit.dart';
import '../logic/packages_and_sbuscriptions_state.dart';
import 'all_packages_screen.dart';

class MyPackage extends StatelessWidget {
  const MyPackage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = getit<PackagesAndSubscriptionsCubit>().myPackageModel!.data!;
    return BlocConsumer<PackagesAndSubscriptionsCubit,
        PackagesAndSbuscriptionsState>(
      listener: (context, state) {
        if (state is LoadingBuy) {
          // show loading dialog
        } else if (state is LoadedBuy) {
          // var dataSub = state.data;
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PaymentScreen(
          //             link: dataSub!.data!.paymentUrl!.toString(), data: dataSub)));
        } else if (state is ErrorBuy) {
          AnimatedSnackBar.material(
            state.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الباقة",
                            style: TextStyles.cairo_12_bold
                                .copyWith(color: appColors.grey15)),
                        verticalSpace(5.h),
                        Row(
                          children: [
                            Text(
                              data.package!.name!,
                              style: TextStyles.cairo_14_bold,
                            ),
                            horizontalSpace(5.w),
                            Text(
                              "${data.package!.duration!} ${getDurationType(data.package!.durationType!)}",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.grey15),
                            ),
                          ],
                        ),
                        verticalSpace(10.h),
                        Divider(color: appColors.grey15, thickness: 0.2),
                        verticalSpace(10.h),
                      ],
                    ),
                    ConditionalBuilder(
                      fallback: (context) {
                        return SizedBox();
                      },
                      builder: (context) => Row(
                        children: [
                          Container(
                            height: 30.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              color: appColors.blue100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          horizontalSpace(10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الاستشارات",
                                style: TextStyles.cairo_12_bold,
                              ),
                              Text(
                                "من من منتجات الباقة",
                                style: TextStyles.cairo_10_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                            ],
                          ),
                          Spacer(),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '${data.remainingAdvisoryServices}',
                                  style: TextStyles.cairo_20_bold.copyWith(
                                      color: appColors.primaryColorYellow),
                                ),
                                TextSpan(
                                    text:
                                        '/${data.package!.numberOfAdvisoryServices}',
                                    style:
                                        TextStyles.cairo_10_semiBold.copyWith(
                                      color: appColors.blue100,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      condition: data.package!.numberOfServices != 0,
                    ),
                    ConditionalBuilder(
                      fallback: (context) {
                        return SizedBox();
                      },
                      builder: (context) => Column(
                        children: [
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Container(
                                height: 30.h,
                                width: 6.w,
                                decoration: BoxDecoration(
                                  color: appColors.darkYellow10,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "الخدمات",
                                    style: TextStyles.cairo_12_bold,
                                  ),
                                  Text(
                                    "من منتجات الباقة",
                                    style: TextStyles.cairo_10_semiBold
                                        .copyWith(color: appColors.grey15),
                                  ),
                                ],
                              ),
                              Spacer(),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${data.remainingServices}',
                                      style: TextStyles.cairo_20_bold.copyWith(
                                          color: appColors.primaryColorYellow),
                                    ),
                                    TextSpan(
                                        text:
                                            '/${data.package!.numberOfServices}',
                                        style: TextStyles.cairo_10_semiBold
                                            .copyWith(
                                          color: appColors.blue100,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                        ],
                      ),
                      condition: data.package!.numberOfServices != 0,
                    ),
                    ConditionalBuilder(
                      fallback: (context) {
                        return SizedBox();
                      },
                      builder: (context) => Column(
                        children: [
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Container(
                                height: 30.h,
                                width: 6.w,
                                decoration: BoxDecoration(
                                  color: appColors.grey20,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "المواعيد",
                                    style: TextStyles.cairo_12_bold,
                                  ),
                                  Text(
                                    "من منتجات الباقة",
                                    style: TextStyles.cairo_10_semiBold
                                        .copyWith(color: appColors.grey15),
                                  ),
                                ],
                              ),
                              Spacer(),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${data.remainingReservations}',
                                      style: TextStyles.cairo_20_bold.copyWith(
                                          color: appColors.primaryColorYellow),
                                    ),
                                    TextSpan(
                                        text:
                                            '/${data.package!.numberOfReservations}',
                                        style: TextStyles.cairo_10_semiBold
                                            .copyWith(
                                          color: appColors.blue100,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                        ],
                      ),
                      condition: data.package!.numberOfReservations != 0,
                    ),

                    if (data.package!.numberOfServices != 0 &&
                        data.package!.numberOfAdvisoryServices != 0 &&
                        data.package!.numberOfReservations != 0)
                      Column(
                        children: [
                          Divider(color: appColors.grey15, thickness: 0.2),
                          verticalSpace(10.h),
                        ],
                      ),
                    Row(
                      children: [
                        TimeRemainingProgress(
                          startDate: data.startDate!,
                          endDate: data.endDate!,
                        ),
                        horizontalSpace(10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${daysRemaining(data.endDate!)} يوم ",
                              style: TextStyles.cairo_12_bold,
                            ),
                            verticalSpace(2.h),
                            Text(
                              "على التجديد",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.grey15),
                            ),
                          ],
                        ),
                        // Spacer(),
                        // CupertinoButton(
                        //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                        //   minSize: 30.h,
                        //   onPressed: () {
                        //     if (state is! LoadingBuy) {}
                        //   },
                        //   color: appColors.blue100,
                        //   child: state is LoadingBuy
                        //       ? CupertinoActivityIndicator(
                        //           color: appColors.white,
                        //         )
                        //       : Text(
                        //           'تجديد الباقة',
                        //           style: TextStyles.cairo_12_bold.copyWith(
                        //             color: appColors.white,
                        //           ),
                        //         ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllPackagesScreen()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),

                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 10.h),
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.pack,
                            width: 30.w,
                            height: 30.h,
                          ),
                          horizontalSpace(10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                'هل ترغب بمعرفة الباقات والعروض؟',
                                style: TextStyles.cairo_12_bold
                                    .copyWith(color: appColors.blue100),
                              ),
                              verticalSpace(3.h),
                              Text(
                                textAlign: TextAlign.center,
                                'استكشفها الآن',
                                style: TextStyles.cairo_11_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: appColors.blue100),
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              ConditionalBuilder(
                condition: data.package!.permissions!.isNotEmpty,
                builder: (BuildContext context) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
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
                          offset:
                              const Offset(0, 3), // Offset in x and y direction
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مميزات الباقة',
                          style: TextStyles.cairo_12_bold.copyWith(
                            color: appColors.grey15,
                          )
                        ),
                        SizedBox(height: 15.h),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return getFeatureRowById(
                                data.package!.permissions![index].id!,
                                data.package!.permissions![index].name!);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10.h);
                          },
                          itemCount: data.package!.permissions!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: 15.h),

                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) {
                  return SizedBox();
                },
              ),
              ConditionalBuilder(
                fallback: (context) {
                  return SizedBox();
                },
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                      height: 500.h, child: MyTabsScreen(data: data));
                },
                condition: data.package!.services!.isNotEmpty &&
                    data.package!.advisoryServicesTypes!.isNotEmpty &&
                    data.package!.reservations!.isNotEmpty,
              ),

            ],
          ),
        );
      },
    );
  }

  String getDurationType(param0) {
    switch (param0) {
      case 1:
        return 'يوم';
      case 2:
        return 'أسبوع';
      case 3:
        return 'شهر';
      case 4:
        return 'سنة';
      default:
        return '';
    }
  }
}

class MyTabsScreen extends StatelessWidget {
  final dynamic data;

  const MyTabsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // تأكد من العدد الصحيح للـTabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            'المنتجات المتاحة',
            style: TextStyles.cairo_12_bold.copyWith(
              color: appColors.grey15,
            ),
          ),
          bottom: TabBar(
            indicatorColor: appColors.primaryColorYellow,
            labelStyle: TextStyles.cairo_12_bold,
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            unselectedLabelColor: const Color(0xFF808D9E),
            unselectedLabelStyle: TextStyles.cairo_12_semiBold,
            tabs: [
              Tab(text: 'الإستشارات'),
              Tab(text: 'الخدمات'),
              Tab(text: 'المواعيد'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListView(data.package!.advisoryServicesTypes!, 2, "إستشارة"),
            _buildListView(
                data.package!.services!, 1, data.package!.services![0].intro!),
            _buildListView(data.package!.reservations!, 3, "موعد",
                isReservation: true),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List items, int serviceType, String introText,
      {bool isReservation = false}) {
    return ConditionalBuilder(
      fallback: (context) => Center(child: CircularProgressIndicator()),
      // إضافة مؤشر تحميل أثناء الانتظار
      builder: (context) {
        return ListView.separated(
          itemBuilder: (context, index) {
            var item = items[index];
            return ServiceCard(
              title: isReservation ? item.name! : item.title!,
              price: "0",
              // يمكنك تعديل هذا الجزء بناءً على البيانات الفعلية
              intro: introText,
              onPress: () {},
              serviceType: serviceType,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 5.0);
          },
          itemCount: items.length,
          shrinkWrap: true,
        );
      },
      condition: items.isNotEmpty,
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final String intro;
  final VoidCallback onPress;
  final int serviceType;

  const ServiceCard({
    super.key,
    required this.title,
    required this.price,
    required this.intro,
    required this.onPress,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 9,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appColors.blue100,
                ),
              ),
              Spacer(),
              Text(
                "$price ريال",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: appColors.primaryColorYellow,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            intro,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: appColors.grey15,
            ),
          ),
          SizedBox(height: 10),
          CustomButton(
            title: serviceType == 1
                ? "طلب الخدمة"
                : serviceType == 2
                    ? "طلب إستشارة"
                    : "طلب موعد",
            onPress: onPress,
            height: 40,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            borderColor: appColors.primaryColorYellow,
            bgColor: Colors.white,
            titleColor: appColors.primaryColorYellow,
          ),
        ],
      ),
    );
  }
}
