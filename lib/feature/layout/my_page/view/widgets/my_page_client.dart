import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/my_orders_card.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../auth/login/data/models/login_provider_response.dart';
import '../../../../package_and_subscriptions/presentation/all_packages_screen.dart';
import '../../../../package_and_subscriptions/presentation/widgets/time_remainig_progress.dart';
import '../../../services/presentation/widgets/item_widget.dart';
import '../../logic/my_page_cubit.dart';
import '../../logic/my_page_state.dart';

class MyPageClient extends StatelessWidget {
  const MyPageClient({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: appColors.primaryColorYellow,
      onRefresh: () {
        context.read<MyPageCubit>().getMyPageData();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<MyPageCubit, MyPageState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: ConditionalBuilder(
                condition: getit<MyPageCubit>().myPageResponseModel != null &&
                    getit<MyPageCubit>().lastAddedModel != null,
                builder: (context) => Animate(
                    effects: [FadeEffect(delay: 200.ms)],
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpace(20.h),
                                LawyerPackageCard(
                                    package: getit<MyAccountCubit>()
                                        .clientProfile!
                                        .data!
                                        .account!
                                        .package),
                                verticalSpace(20.h),
                                TabsAnalysis(
                                    data: getit<MyPageCubit>()
                                        .myPageResponseModel!
                                        .data!
                                        .analytics!),
                                verticalSpace(20.h),
                                const MyOrdersItemsClientCard(),
                                verticalSpace(20.h),
                                // add taps here
                                DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        indicatorColor:
                                            appColors.primaryColorYellow,
                                        labelColor:
                                            appColors.primaryColorYellow,
                                        unselectedLabelColor: appColors.grey2,
                                        tabs: const [
                                          Tab(text: 'الأكثر طلباً'),
                                          Tab(text: 'المضاف حديثاً'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 500.h,
                                        child: TabBarView(
                                          children: [
                                            // Most Bought Tab
                                            SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  verticalSpace(10.h),
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.mostBought
                                                          ?.advisoryServices
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .mostBought!
                                                        .advisoryServices!
                                                        .map(
                                                          (service) =>
                                                              ItemCardWidget(
                                                            index:
                                                                service.id ?? 0,
                                                            name:
                                                                service.name ??
                                                                    '',
                                                            description: null,
                                                            total:
                                                                '${service.minPrice} - ${service.maxPrice} ريال',
                                                            id: service.id ?? 0,
                                                            iconPath: AppAssets
                                                                .advisories,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .advisoryScreen),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.mostBought
                                                          ?.services
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(15.h),
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .mostBought!
                                                        .services!
                                                        .map(
                                                          (service) =>
                                                              ItemCardWidget(
                                                            index:
                                                                service.id ?? 0,
                                                            name:
                                                                service.title ??
                                                                    '',
                                                            description:
                                                                null,
                                                            total:
                                                                '${service.minPrice} - ${service.maxPrice} ريال',
                                                            id: service.id ?? 0,
                                                            iconPath: AppAssets
                                                                .services,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .services),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.mostBought
                                                          ?.appointments
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(15.h),
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .mostBought!
                                                        .appointments!
                                                        .map(
                                                          (appointment) =>
                                                              ItemCardWidget(
                                                            index: appointment
                                                                    .id ??
                                                                0,
                                                            name: appointment
                                                                    .name ??
                                                                '',
                                                            total:
                                                                '${appointment.minPrice} - ${appointment.maxPrice} ريال',
                                                            id: appointment
                                                                    .id ??
                                                                0,
                                                            iconPath: AppAssets
                                                                .appointments,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .appointmentYmatz),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                ],
                                              ),
                                            ),

                                            // Latest Created Tab
                                            SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  verticalSpace(10.h),
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.latestCreated
                                                          ?.advisoryServices
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .latestCreated!
                                                        .advisoryServices!
                                                        .map(
                                                          (service) =>
                                                              ItemCardWidget(
                                                            index:
                                                                service.id ?? 0,
                                                            name:
                                                                service.name ??
                                                                    '',
                                                            description: null,
                                                            total:
                                                                '${service.minPrice} - ${service.maxPrice} ريال',
                                                            id: service.id ?? 0,
                                                            iconPath: AppAssets
                                                                .advisories,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .advisoryScreen),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.latestCreated
                                                          ?.services
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(15.h),
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .latestCreated!
                                                        .services!
                                                        .map(
                                                          (service) =>
                                                              ItemCardWidget(
                                                            index:
                                                                service.id ?? 0,
                                                            name:
                                                                service.title ??
                                                                    '',
                                                            description:
                                                                null,
                                                            total:
                                                                '${service.minPrice} - ${service.maxPrice} ريال',
                                                            id: service.id ?? 0,
                                                            iconPath: AppAssets
                                                                .services,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .services),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                  if (getit<MyPageCubit>()
                                                          .lastAddedModel
                                                          ?.data
                                                          ?.latestCreated
                                                          ?.appointments
                                                          ?.isNotEmpty ??
                                                      false) ...[
                                                    verticalSpace(15.h),
                                                    verticalSpace(10.h),
                                                    ...getit<MyPageCubit>()
                                                        .lastAddedModel!
                                                        .data!
                                                        .latestCreated!
                                                        .appointments!
                                                        .map(
                                                          (appointment) =>
                                                              ItemCardWidget(
                                                            index: appointment
                                                                    .id ??
                                                                0,
                                                            name: appointment
                                                                    .name ??
                                                                '',
                                                            total:
                                                                '${appointment.minPrice} - ${appointment.maxPrice} ريال',
                                                            id: appointment
                                                                    .id ??
                                                                0,
                                                            iconPath: AppAssets
                                                                .appointments,
                                                            onPressed: () => context
                                                                .pushNamed(Routes
                                                                    .appointmentYmatz),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(20.h),
                                    ],
                                  ),
                                ),
                              ],
                            )))),
                fallback: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CupertinoActivityIndicator()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LawyerPackageCard extends StatelessWidget {
  const LawyerPackageCard({super.key, required this.package});

  final Subscription? package;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: package != null,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(Routes.packages);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
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
            child: Row(
              children: [
                horizontalSpace(10.w),
                TimeRemainingProgress(
                  startDate: DateTime.parse(package!.startDate!.toString()),
                  endDate: DateTime.parse(package!.endDate!.toString()),
                ),
                horizontalSpace(10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${daysRemaining(DateTime.parse(package!.endDate!))} يوم ",
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
                horizontalSpace(15.w),
                Container(
                  height: 30.h,
                  width: 1.w,
                  color: appColors.grey15,
                ),
                horizontalSpace(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الباقة الحالية",
                      style: TextStyles.cairo_12_bold,
                    ),
                    verticalSpace(2.h),
                    Text(
                      package!.package!.name!,
                      style: TextStyles.cairo_12_semiBold
                          .copyWith(color: appColors.grey15),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: appColors.blue100),
              ],
            ),
          ),
        );
      },
      fallback: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllPackagesScreen()));
          },
          child: Container(
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
                          'هل ترغب بمعرفة الباقات و المميزات ؟',
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
        );
      },
    );
  }
}
