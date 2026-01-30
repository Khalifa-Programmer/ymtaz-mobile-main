import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/package_and_subscriptions/data/model/packages_model.dart';

import '../../../../core/widgets/custom_expantion_tile.dart';
import 'features_widgets.dart';

class PackageSlider extends StatelessWidget {
  final List<Package> packages;

  const PackageSlider({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    List<Package> sortedPackages = [
      ...packages.where((package) => package.subscribed!),
      // Add subscribed packages at the top
      ...packages
          .where((package) => !package
              .subscribed!) // Add non-subscribed packages, sorted by price
          .toList()
        ..sort(
            (a, b) => a.priceAfterDiscount!.compareTo(b.priceAfterDiscount!)),
    ];
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return PackageCard(package: sortedPackages[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 0.h);
        },
        itemCount: packages.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics());
  }
}

class PackageCard extends StatelessWidget {
  final Package package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
        color: appColors.white,
        border: Border.all(color: appColors.grey2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 9,
            offset: const Offset(3, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.services,
                    width: 24.w,
                    height: 24.h,
                    colorFilter:
                        ColorFilter.mode(appColors.grey20, BlendMode.srcIn)),
                horizontalSpace(5.w),
                Text(
                  package.name ?? 'اسم الباقة',
                  style: TextStyles.cairo_16_bold
                      .copyWith(color: appColors.blue100),
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: appColors.primaryColorYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "مقترح لك",
                    style: TextStyle(
                      color: appColors.primaryColorYellow,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 18.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${package.instructions}",
                  style: TextStyles.cairo_14_medium
                      .copyWith(color: appColors.blue100),
                ),
                SizedBox(height: 16.h),
                if (package.numberOfServices != 0 ||
                    package.numberOfAdvisoryServices != 0 ||
                    package.numberOfReservations != 0)
                  CustomExpansionTile(
                    title: 'مميزات الباقة',
                    initialGradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 69, 82, 1),
                        // التدرج الأول عند الإغلاق
                        Color.fromRGBO(0, 38, 46, 1),
                        // التدرج الثاني عند الإغلاق
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    expandedGradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 38, 46, 1), // التدرج الثاني عند الفتح
                        Color.fromRGBO(20, 69, 82, 1), // التدرج الأول عند الفتح
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    children: [
                      verticalSpace(10.h),
                      PackageFeatures(package: package),
                      verticalSpace(10.h),
                    ],
                  ),
                if (package.permissions!.isNotEmpty)
                  CustomExpansionTile(
                    title: 'مميزات الباقة',
                    initialGradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 69, 82, 1),
                        // التدرج الأول عند الإغلاق
                        Color.fromRGBO(0, 38, 46, 1),
                        // التدرج الثاني عند الإغلاق
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    expandedGradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 38, 46, 1), // التدرج الثاني عند الفتح
                        Color.fromRGBO(20, 69, 82, 1), // التدرج الأول عند الفتح
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    children: [
                      verticalSpace(10.h),
                      ...package.permissions!.map((permission) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 16.w),
                          child: getFeatureRowById(
                              permission.id!, permission.name!),
                        );
                      }),
                      verticalSpace(10.h),
                    ],
                  ),
                SizedBox(height: 24.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: appColors.blue100,
                    ),
                    children: [
                      // عرض السعر قبل الخصم إذا كان هناك خصم
                      if (package.priceBeforeDiscount != null &&
                          package.priceBeforeDiscount! >
                              package.priceAfterDiscount!)
                        TextSpan(
                          text: '${package.priceBeforeDiscount} ر.س ',
                          style: TextStyles.cairo_20_semiBold.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration
                                .lineThrough, // خط وسط السعر قبل الخصم
                          ),
                        ),
                      if (package.priceBeforeDiscount != null &&
                          package.priceBeforeDiscount! >
                              package.priceAfterDiscount!)
                        TextSpan(
                          text: ' ',
                        ),

                      // عرض السعر بعد الخصم
                      TextSpan(
                        text: '${package.priceAfterDiscount} ر.س ',
                        style: TextStyles.cairo_24_bold.copyWith(
                          color: appColors.blue100,
                        ),
                      ),
                      TextSpan(
                        text: '/ شهر',
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      // عرض كونتينر "خصم" إذا كان هناك فرق بين السعرين

                      if (package.priceBeforeDiscount != null &&
                          package.priceBeforeDiscount! >
                              package.priceAfterDiscount!)
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'خصم',
                              style: TextStyles.cairo_12_semiBold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
            package.subscribed!
                ? CustomButton(
                    title: 'تم الاشتراك',
                    borderRadius: 25.r,
                    borderColor: appColors.grey2,
                    titleColor: appColors.grey15,
                    bgColor: appColors.grey2,
                  )

                // onPress: () {
                //       context.pushNamed(Routes.packageDetails,
                //           arguments: package);
                //     })
                : CustomButton(
                    title: 'اشترك الآن',
                    borderRadius: 25.r,
                    onPress: () {
                      context.pushNamed(Routes.packageDetails,
                          arguments: package);
                    })
          ],
        ),
      ),
    );
  }
}

class PackageFeatures extends StatefulWidget {
  final Package package;

  const PackageFeatures({
    required this.package,
    super.key,
  });

  @override
  State<PackageFeatures> createState() => _PackageFeaturesState();
}

class _PackageFeaturesState extends State<PackageFeatures> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> featureWidgets = [];

    // Build all feature widgets
    if (widget.package.numberOfAdvisoryServices! > 0) {
      featureWidgets.add(buildFeatureRow(
        2,'${widget.package.numberOfAdvisoryServices} استشارة شهرية',
      ));
      featureWidgets.add(SizedBox(height: 10.h));
    }

    if (widget.package.numberOfServices! > 0) {
      featureWidgets.add(buildFeatureRow(
        1,'${widget.package.numberOfServices} خدمة شهرية',
      ));
      featureWidgets.add(SizedBox(height: 10.h));
    }

    if (widget.package.numberOfReservations! > 0) {
      featureWidgets.add(buildFeatureRow(
        3,'${widget.package.numberOfReservations} موعد شهري',
      ));
      featureWidgets.add(SizedBox(height: 10.h));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show first two features or all features when expanded
        ...featureWidgets,
      ],
    );
  }
}



List<Map<String, dynamic>> services = [
  { 'id': 1, 'name': 'خدمة', 'icon': AppAssets.services },
  { 'id': 2, 'name': 'استشارة', 'icon': AppAssets.advisories },
  { 'id': 3, 'name': 'موعد', 'icon': AppAssets.appointments },

];

Widget buildFeatureRow(int id , String name) {
  // البحث عن الميزة بناءً على الـ id
  var feature = services.firstWhere(
        (service) => service['id'] == id,
    orElse: () => {'id': 0, 'name': 'ميزة غير موجودة', 'icon': 'assets/icons/default_icon.svg'},
  );

  // إرجاع Row يحتوي على الأيقونة والاسم
  return Padding(
    padding:  EdgeInsets.symmetric(
      horizontal: 16.w),
    child: Row(
      children: [
        SvgPicture.asset(
          feature['icon'],
          width: 20,
          height: 20,
          placeholderBuilder: (context) => CircularProgressIndicator(), // عرض مؤشر التحميل إذا كانت الأيقونة قيد التحميل
        ),
        SizedBox(width: 8),
        Expanded(child: Text(name, style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.blue100))),
      ],
    ),
  );
}
