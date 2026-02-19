import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../../core/constants/colors.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          horizontalSpace(10.w),
          PolarChart(data),
          horizontalSpace(70.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('منتظر',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              verticalSpace(5.h),
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('تم الانتهاء',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              verticalSpace(5.h),
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('متأخر',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          horizontalSpace(50.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data['pending'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              verticalSpace(5.h),
              Text(data['done'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              verticalSpace(5.h),
              Text(data['late'] == null ? "0" : data['late'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          // SHOW DATA FROM POLAR CHART WITH COLOR
        ],
      ),
    );
  }
}

class AnalyticsTotalCard extends StatelessWidget {
  const AnalyticsTotalCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          horizontalSpace(10.w),
          PolarChart(data),
          horizontalSpace(70.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('الخدمات',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              verticalSpace(5.h),
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('الاستشارات',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              verticalSpace(5.h),
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  horizontalSpace(5.w),
                  Text('المواعيد',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          horizontalSpace(50.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data['pending'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              verticalSpace(5.h),
              Text(data['done'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              verticalSpace(5.h),
              Text(data['late'] == null ? "0" : data['late'].toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          // SHOW DATA FROM POLAR CHART WITH COLOR
        ],
      ),
    );
  }
}

class PolarChart extends StatelessWidget {
  const PolarChart(this.data, {super.key});

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
                      'الإجمالي',
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
    if (key == 'total' ||
        key != 'percentageChange' ||
        key != 'changeDirection' ||
        key != 'amounts' ||
        key != 'late') {
      return;
    }
    sections.add(PieChartSectionData(
      value: value.toDouble(),
      title: '$key: $value',
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
  const PolarTotalChart(this.data, {super.key});

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
                      'الإجمالي',
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
      title: '$key: $value',
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
