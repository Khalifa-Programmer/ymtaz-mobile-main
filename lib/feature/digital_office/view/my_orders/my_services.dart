import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';
import '../widgets/services_orders/my_services_clients_screen.dart';
import '../widgets/services_orders/pending_requests_screen.dart';

class MyServicesLawyerScreen extends StatelessWidget {
  const MyServicesLawyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "طلبات الخدمات",
                  style: TextStyles.cairo_16_bold.copyWith(
                    color: appColors.black,
                  ),
                ),
                bottom: TabBar(
                    indicatorColor: appColors.primaryColorYellow,
                    labelStyle: TextStyles.cairo_14_bold,
                    indicatorSize: TabBarIndicatorSize.tab,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    unselectedLabelColor: const Color(0xFF808D9E),
                    unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                    tabs: const [
                      Tab(
                        text: 'عروض',
                      ),
                      Tab(
                        text: 'قيد التفاوض',
                      ),
                      Tab(
                        text: 'طلباتك',
                      ),
                    ]),
              ),
              body: TabBarView(children: [
                ConditionalBuilder(
                  condition:
                      getit<OfficeProviderCubit>().pendingServicesRequest !=
                          null,
                  builder: (BuildContext context) {
                    return PendingRequestsScreen(
                        offers: getit<OfficeProviderCubit>()
                            .pendingServicesRequest!
                            .data!
                            .offers!
                            .pendingOffer!);
                  },
                  fallback: (BuildContext context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoActivityIndicator(),
                        ],
                      ),
                    );
                  },
                ),
                ConditionalBuilder(
                  condition:
                      getit<OfficeProviderCubit>().pendingServicesRequest !=
                          null,
                  builder: (BuildContext context) {
                    return PendingRequestsScreen(
                      offers: getit<OfficeProviderCubit>()
                          .pendingServicesRequest!
                          .data!
                          .offers!
                          .pendingAcceptance!,
                    );
                  },
                  fallback: (BuildContext context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoActivityIndicator(),
                        ],
                      ),
                    );
                  },
                ),
                ServicesOredersScreen(),
                // UnderStudyServices(),
              ]),
            ));
      },
    );
  }

  Widget shimmerWidget() {
    return Container(
      width: double.infinity,
      height: 50.h,
      color: Colors.white.withOpacity(0.2),
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 3.h,
            color: Colors.white,
          ),
          horizontalSpace(30.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10.h),
              Container(
                width: 200.w,
                height: 10.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              verticalSpace(5.h),
              Container(
                width: 250.w,
                height: 10.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              verticalSpace(10.h),
            ],
          ),
        ],
      ),
    );
  }
}
