import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_cubit.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_state.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/package_slider.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';

class AllPackagesScreen extends StatelessWidget {
  const AllPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:
          getit<PackagesAndSubscriptionsCubit>()..getPackages(),
      child: BlocConsumer<PackagesAndSubscriptionsCubit,
          PackagesAndSbuscriptionsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("الباقات والاشتراكات",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition:
                  getit<PackagesAndSubscriptionsCubit>().packagesModel != null,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: PackageSlider(
                            packages: getit<PackagesAndSubscriptionsCubit>()
                                .packagesModel!
                                .data!
                                .packages!,
                          )),
                      SizedBox(height: 16.h),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return Center(child: CupertinoActivityIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
