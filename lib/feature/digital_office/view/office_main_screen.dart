import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/balance_card.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/my_orders_card.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/user_profile_row.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/router/routes.dart';
import '../../layout/account/logic/my_account_cubit.dart';
import '../logic/office_provider_cubit.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('المكتب الإلكتروني',
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
                return RefreshIndicator(
                  color: appColors.blue100,
                  onRefresh: () {
                    return getit<OfficeProviderCubit>().getAnalytics();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserProfileRow(
                                  paddingTop: 0,
                                  imageUrl: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .client!
                                      .photo!,
                                  name: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .client!
                                      .name!,
                                  isVerified: getit<MyAccountCubit>()
                                          .userDataResponse!
                                          .data!
                                          .client!
                                          .digitalGuideSubscription ==
                                      1,
                                  color: getColor(getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .client!
                                      .currentRank!
                                      .borderColor!),
                                  image: getit<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .client!
                                      .currentRank!
                                      .image!),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "مقدم خدمة",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(10.h),
                        getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .client!
                                    .digitalGuideSubscription ==
                                1
                            ? const BalanceCard()
                            : const SubscripeCard(),
                        verticalSpace(24.h),
                        TabsAnalysis(data: data!),
                        verticalSpace(20.h),
                        const MyOrdersItemsCard(),
                        verticalSpace(30.h),
                        getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .client!
                                    .digitalGuideSubscription ==
                                0
                            ? Container(
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
                                    Text(
                                      textAlign: TextAlign.center,
                                      'قم بالتخصيص حتى تتمكن من تلقي الطلبات',
                                      style: TextStyles.cairo_12_semiBold
                                          .copyWith(color: appColors.blue100),
                                    ),
                                    verticalSpace(10.h),
                                    CustomButton(
                                      title: "التخصيص",
                                      onPress: () {
                                        context.pushNamed(Routes.adjustScreen);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : CustomButton(
                                title: "التخصيص",
                                onPress: () {
                                  context.pushNamed(Routes.adjustScreen);
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (BuildContext context) => const Center(
                child: CupertinoActivityIndicator(),
              ),
            ));
      },
    );
  }
}

class PolarChart extends StatelessWidget {
  PolarChart(this.data);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double centerSpaceRadius =
              max(constraints.biggest.shortestSide / 20, 40);
          double sectionRadius = constraints.biggest.shortestSide / 10;

          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'الاجمالي',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: appColors.blue100,
                      ),
                    ),
                    Text(
                      "${data['total']}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PieChart(
                PieChartData(
                  sections: getSections(sectionRadius, data),
                  centerSpaceRadius: centerSpaceRadius,
                  sectionsSpace: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<PieChartSectionData> getSections(double sectionRadius, servicesData) {
  final List<PieChartSectionData> sections = [];

  // Data from the JSON

  // Adding sections for services
  servicesData.forEach((key, value) {
    if (key == 'total') return;
    sections.add(PieChartSectionData(
      value: value.toDouble(),
      title: '$key: ${value}',
      showTitle: false,
      color: getColorForKey(key),
      radius: sectionRadius,
      titleStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    ));
  });

  return sections;
}

Color getColorForKey(String key) {
  switch (key) {
    case 'done':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'late':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

// total

class PolarTotalChart extends StatelessWidget {
  PolarTotalChart(this.data);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double centerSpaceRadius =
              max(constraints.biggest.shortestSide / 20, 40);
          double sectionRadius = constraints.biggest.shortestSide / 10;

          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'الاجمالي',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: appColors.blue100,
                      ),
                    ),
                    Text(
                      "${data['total']}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PieChart(
                PieChartData(
                  sections: getSections(sectionRadius, data),
                  centerSpaceRadius: centerSpaceRadius,
                  sectionsSpace: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<PieChartSectionData> getTotalSections(double sectionRadius, servicesData) {
  final List<PieChartSectionData> sections = [];

  // Data from the JSON

  // Adding sections for services
  servicesData.forEach((key, value) {
    if (key == 'total') return;
    sections.add(PieChartSectionData(
      value: value.toDouble(),
      title: '$key: ${value}',
      showTitle: false,
      color: getColorForKey(key),
      radius: sectionRadius,
      titleStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    ));
  });

  return sections;
}

Color getTotalColorForKey(String key) {
  switch (key) {
    case 'done':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'late':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
