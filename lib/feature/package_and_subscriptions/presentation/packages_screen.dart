import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_cubit.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_state.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/my_package.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/package_slider.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackagesAndSubscriptionsCubit, PackagesAndSbuscriptionsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("الباقات والاشتراكات",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: appColors.primaryColorYellow,
                labelStyle: TextStyles.cairo_14_bold,
                unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                unselectedLabelColor: const Color(0xFF808D9E),
                tabs: const [
                  Tab(text: 'باقاتي'),
                  Tab(text: 'الباقات المتاحة'),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: getit<PackagesAndSubscriptionsCubit>().packagesModel != null,
              builder: (BuildContext context) {
                final cubit = getit<PackagesAndSubscriptionsCubit>();
                final allPackages = cubit.packagesModel!.data!.packages!;
                final subscribedPackages = allPackages.where((p) => p.subscribed == true).toList();
                final availablePackages = allPackages.where((p) => p.subscribed == false).toList();

                return TabBarView(
                  children: [
                    // باقاتي (Subscribed Packages)
                    subscribedPackages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cube_box,
                                  size: 80.sp,
                                  color: appColors.grey15,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'لا توجد باقات مشترك بها',
                                  style: TextStyles.cairo_16_semiBold.copyWith(
                                    color: appColors.grey15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: PackageSlider(packages: subscribedPackages),
                          ),

                    // الباقات المتاحة (Available Packages)
                    availablePackages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cube_box,
                                  size: 80.sp,
                                  color: appColors.grey15,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'لا توجد باقات متاحة',
                                  style: TextStyles.cairo_16_semiBold.copyWith(
                                    color: appColors.grey15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: PackageSlider(packages: availablePackages),
                          ),
                  ],
                );
              },
              fallback: (BuildContext context) {
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          ),
        );
      },
    );
  }
}
