import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../l10n/locale_keys.g.dart';
import '../logic/advisory_committees_cubit.dart';
import '../logic/advisory_committees_state.dart';

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({super.key, required this.lawyer});

  final Advisor lawyer;

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المعلومات الشخصية",
          style: TextStyles.cairo_14_bold,
        ),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: getit<AdvisoryCommitteesCubit>()
          ..getLawyerdatabtid(widget.lawyer.id?.toString() ?? ""),

        child: BlocConsumer<AdvisoryCommitteesCubit, AdvisoryCommitteesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () {
                // Refresh logic here if needed for static data
                return Future.value();
              },
              color: Colors.yellow, // ColorsPalletes.primaryColorYellow,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Static image
                            Container(
                              padding: const EdgeInsets.all(20),
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
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.lawyer.photo ?? widget.lawyer.image ?? widget.lawyer.logo ??
                                                "https://api.ymtaz.sa/uploads/person.png",

                                            scale: 1.0),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.lawyer.name ?? "بدون اسم",

                                              // Static name
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: appColors
                                                    .primaryColorYellow,
                                              ),
                                            ),
                                            horizontalSpace(5.w),
                                            widget.lawyer
                                                        .digitalGuideSubscription ==
                                                    1
                                                ? const Icon(
                                                    Icons.verified,
                                                    color: CupertinoColors
                                                        .activeBlue,
                                                    size: 20,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // rating with star
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "5 / ${widget.lawyer.ratesAvg ?? "0"} ",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: appColors.grey5,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: appColors
                                                  .primaryColorYellow,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Static profile information
                            Container(
                              padding: const EdgeInsets.all(20),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.profileOverview.tr(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.grey15,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "${widget.lawyer.about}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.blue100,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    "المهن",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.grey15,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Wrap(
                                    spacing: 8.0.w,
                                    // spacing between chips
                                    runSpacing: 4.0,
                                    // spacing between rows of chips
                                    children:
                                        (widget.lawyer.sections ?? []).map((section) {

                                      return Chip(
                                        side: BorderSide(
                                          color: appColors
                                              .primaryColorYellow
                                              .withOpacity(0.1),
                                          width: 1,
                                        ),
                                        color: WidgetStatePropertyAll<Color>(
                                            appColors.primaryColorYellow
                                                .withOpacity(0.1)),

                                        label: Text(
                                          section.section?.title ?? "",

                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: appColors.blue100,
                                          ),
                                        ),
                                        // Add any additional styling here if needed
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(20.0.sp),
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
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.personalInformation.tr(),
                                    style: TextStyles.cairo_12_medium
                                        .copyWith(color: appColors.grey15),
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.earthAsia,
                                        color:
                                            appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        LocaleKeys.country.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.lawyer.country?.name ?? "",
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.blue100),

                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.earthAsia,
                                        color:
                                            appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        LocaleKeys.city.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.lawyer.region?.name ?? "",
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.blue100),

                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.idCard,
                                        color:
                                            appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        LocaleKeys.nationality.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.lawyer.nationality?.name ?? "",
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.blue100),

                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.grade_outlined,
                                        color:
                                            appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        LocaleKeys.academicDegree.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.lawyer.degree?.title ?? "",
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(
                                                color: appColors.blue100),

                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Static personal information
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                      controller: _tabController,
                                      indicatorColor:
                                          appColors.primaryColorYellow,
                                      labelStyle: TextStyles.cairo_14_bold,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      unselectedLabelColor:
                                          const Color(0xFF808D9E),
                                      unselectedLabelStyle:
                                      TextStyles.cairo_11_semiBold,
                                      tabs: const [
                                        Tab(
                                          text: 'الخدمات',
                                        ),
                                        Tab(
                                          text: 'الاستشارات',
                                        ),
                                        Tab(
                                          text: 'المواعيد',
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 300.h,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        ConditionalBuilder(
                                          condition: getit<
                                              AdvisoryCommitteesCubit>()
                                              .lawyerServicesResponseModel !=
                                              null,
                                          builder: (BuildContext context) =>
                                              ConditionalBuilder(
                                                condition: getit<
                                                    AdvisoryCommitteesCubit>()
                                                    .lawyerServicesResponseModel!
                                                    .data!
                                                    .lawyerServices!
                                                    .isNotEmpty,
                                                builder: (BuildContext context) =>
                                                                                        _servicesTab(),

                                                fallback: (BuildContext context) =>
                                                const Center(
                                                    child: Text(
                                                        "لا يوجد استشارات حاليا")),
                                              ),
                                          fallback: (BuildContext context) =>
                                          const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        ),

                                        ConditionalBuilder(
                                          condition: getit<
                                                      AdvisoryCommitteesCubit>()
                                                  .lawyerAdvisoryServicesResponseModel !=
                                              null,
                                          builder: (BuildContext context) =>
                                              ConditionalBuilder(
                                            condition: getit<
                                                    AdvisoryCommitteesCubit>()
                                                .lawyerAdvisoryServicesResponseModel!
                                                .data!
                                                .lawyerServices!
                                                .isNotEmpty,
                                            builder: (BuildContext context) =>
                                                _avisoryTab(),
                                            fallback: (BuildContext context) =>
                                                const Center(
                                                    child: Text(
                                                        "لا يوجد استشارات حاليا")),
                                          ),
                                          fallback: (BuildContext context) =>
                                              const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        ),
                                        const Center(
                                          child: Text("المواعيد"),
                                        ),
                                      ],
                                    ),
                                  )

                                  // Add static rows for country, city, nationality, phone, degree, email, etc.
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView _servicesTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ConditionalBuilder(
            condition: widget.lawyer.digitalGuideSubscription == 1,
            builder: (BuildContext context) => ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: getit<AdvisoryCommitteesCubit>()
                  .lawyerServicesResponseModel!
                  .data!
                  .lawyerServices!
                  .length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Map args = {
                      "lawyer": widget.lawyer,
                      "service": getit<AdvisoryCommitteesCubit>()
                          .lawyerServicesResponseModel!
                          .data!
                          .lawyerServices![index]
                    };
                    Navigator.of(context).pushNamed(
                        Routes.servicesReservationLawyerScreen,
                        arguments: args);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white, //
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          // Shadow color
                          spreadRadius: 1,
                          // Spread radius
                          blurRadius: 9,
                          // Blur radius
                          offset: const Offset(
                              3, 3), // Offset in x and y directions
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              getit<AdvisoryCommitteesCubit>()
                                  .lawyerServicesResponseModel!
                                  .data!
                                  .lawyerServices![index].title!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColors.blue100,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${getit<AdvisoryCommitteesCubit>()
                                  .lawyerServicesResponseModel!
                                  .data!
                                  .lawyerServices![index].lawyerPrices!.first.price.toString()} ريال",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: appColors.primaryColorYellow,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10.h),
                        Text(
                          getit<AdvisoryCommitteesCubit>()
                              .lawyerServicesResponseModel!
                              .data!
                              .lawyerServices![index].intro!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.5.h,
                            fontWeight: FontWeight.w600,
                            color: appColors.grey15,
                          ),
                        ),
                        verticalSpace(10.h),
                        CustomButton(
                          title: "طلب الخدمة",
                          onPress: () {
                            Map args = {
                              "lawyer": widget.lawyer,
                              "service": getit<AdvisoryCommitteesCubit>()
                                  .lawyerServicesResponseModel!
                                  .data!
                                  .lawyerServices![index]
                            };
                            Navigator.of(context).pushNamed(
                                Routes.servicesReservationLawyerScreen,
                                arguments: args);
                          },
                          height: 40.h,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          borderColor: appColors.primaryColorYellow,
                          bgColor: Colors.white,
                          titleColor: appColors.primaryColorYellow,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return verticalSpace(10.h);
              },
            ),
            fallback: (BuildContext context) => Center(
                child: Text("القنوات الرقمية غير مفعلة لهذا الحساب",
                    style: TextStyles.cairo_16_semiBold
                        .copyWith(color: appColors.grey5))),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _avisoryTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ConditionalBuilder(
            condition: getit<AdvisoryCommitteesCubit>()
                    .lawyerAdvisoryServicesResponseModel !=
                null,
            builder: (BuildContext context) => ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: getit<AdvisoryCommitteesCubit>()
                  .lawyerAdvisoryServicesResponseModel!
                  .data!
                  .lawyerServices!
                  .length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white, //
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          // Shadow color
                          spreadRadius: 1,
                          // Spread radius
                          blurRadius: 9,
                          // Blur radius
                          offset: const Offset(
                              3, 3), // Offset in x and y directions
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              getit<AdvisoryCommitteesCubit>()
                                  .lawyerAdvisoryServicesResponseModel!
                                  .data!
                                  .lawyerServices![index]
                                  .types!
                                  .first
                                  .title!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColors.blue100,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${getit<AdvisoryCommitteesCubit>().lawyerAdvisoryServicesResponseModel!.data!.lawyerServices![index].types!.first.advisoryServicesPrices!.first.price} ريال",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: appColors.primaryColorYellow,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10.h),
                        Text(
                          getit<AdvisoryCommitteesCubit>()
                              .lawyerAdvisoryServicesResponseModel!
                              .data!
                              .lawyerServices![index]
                              .instructions!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.5.h,
                            fontWeight: FontWeight.w600,
                            color: appColors.grey15,
                          ),
                        ),
                        verticalSpace(10.h),
                        // CustomButton(
                        //   title: "طلب الخدمة",
                        //   onPress: () {
                        //     Map args = {
                        //       "lawyer": widget.lawyer,
                        //       "service": widget.lawyer.services![index]
                        //     };
                        //     Navigator.of(context).pushNamed(
                        //         Routes.servicesReservationLawyerScreen,
                        //         arguments: args);
                        //   },
                        //   height: 40.h,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 14,
                        //   borderColor: ColorsPalletes.primaryColorYellow,
                        //   bgColor: Colors.white,
                        //   titleColor: ColorsPalletes.primaryColorYellow,
                        // ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return verticalSpace(10.h);
              },
            ),
            fallback: (BuildContext context) => Center(
                child: Text("القنوات الرقمية غير مفعلة لهذا الحساب",
                    style: TextStyles.cairo_16_semiBold
                        .copyWith(color: appColors.grey5))),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
