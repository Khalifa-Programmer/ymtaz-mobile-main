import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';

import '../../../config/themes/styles.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../core/widgets/spacing.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../digital_guide/data/model/lawyer_model.dart';
import '../../layout/account/presentation/widgets/user_profile_row.dart';
import '../logic/digital_guide_cubit.dart';
import '../logic/digital_guide_state.dart';

class DigitalProvidersScreen extends StatefulWidget {
  const DigitalProvidersScreen({super.key, required this.idLawyer});

  final String idLawyer;

  @override
  State<DigitalProvidersScreen> createState() => _DigitalProvidersScreenState();
}

class _DigitalProvidersScreenState extends State<DigitalProvidersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildBlurredAppBar(context, "بيانات مقدم الخدمة"),
      body: BlocProvider.value(
        value: getit<DigitalGuideCubit>()
          ..getLawyerData(widget.idLawyer.toString()),
        child: BlocConsumer<DigitalGuideCubit, DigitalGuideState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: getit<DigitalGuideCubit>().lawyerModel != null,
              builder: (context) {
                var lawyer =
                    getit<DigitalGuideCubit>().lawyerModel!.data!.account;
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: headerProfile(lawyer!, context),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: appColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 4,
                                  blurRadius: 9,
                                  offset: const Offset(0, -2),
                                ),
                              ],
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelColor: appColors.primaryColorYellow,
                              unselectedLabelColor: appColors.grey5,
                              indicatorColor: appColors.primaryColorYellow,
                              tabs: const [
                                Tab(text: 'معلومات'),
                                Tab(text: 'خبرات عملية'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 300,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: personalData(lawyer),
                                ),
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: workExperienceData(lawyer),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (context) =>
                  const Center(child: CupertinoActivityIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget headerProfile(Account lawyer, BuildContext context) {
    return Container(
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
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: getColor(lawyer!.currentRank!.borderColor!),
                radius: 53.0.sp,
                child: CachedNetworkImage(
                  imageUrl: lawyer.image!.isEmpty
                      ? "https://api.ymtaz.sa/uploads/person.png"
                      : lawyer.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0.w,
                    height: 100.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      imageShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 0.0.h,
                left: 0,
                right: 60.w,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 10.sp,
                    backgroundColor: appColors.white,
                    child: SvgPicture.network(
                      lawyer.currentRank!.image!,
                      width: 12.0.w,
                      // Adjust width according to your design
                      height: 12.0.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      lawyer.name!,
                      // Static name
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                    horizontalSpace(5.w),
                    lawyer.hasBadge == "blue"
                        ? const Icon(
                            Icons.verified,
                            color: CupertinoColors.activeBlue,
                            size: 20,
                          )
                        : lawyer.hasBadge == "gold"
                            ? const Icon(
                                Icons.verified,
                                color: Color(0xffd0b101),
                                size: 20,
                              )
                            : SizedBox(),
                  ],
                ),
                const SizedBox(height: 10),
                // rating with star
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "5 / 0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColors.grey5,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: appColors.primaryColorYellow,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // rating with star
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: appColors.green,
                      size: 10,
                    ),
                    horizontalSpace(5.w),
                    Text(
                      "آخر ظهور ${getTimeDate(lawyer.lastSeen!)}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: appColors.grey5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget personalData(Account lawyer) {
    return Column(
      children: [
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
                "${lawyer.about}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.blue100,
                ),
              ),
              SizedBox(height: 15.h),
              const Text(
                "المهن",
                style: TextStyle(
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
                children: lawyer.sections!.map((section) {
                  return Chip(
                    side: BorderSide(
                      color: appColors.primaryColorYellow.withOpacity(0.1),
                      width: 1,
                    ),
                    color: WidgetStatePropertyAll<Color>(
                        appColors.primaryColorYellow.withOpacity(0.1)),

                    label: Text(
                      section.section!.title!,
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
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(10.w),
                  Text(
                    LocaleKeys.country.tr(),
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  const Spacer(),
                  Text(
                    lawyer.country!.name!,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                ],
              ),
              verticalSpace(20.h),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.earthAsia,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(10.w),
                  Text(
                    "المنطقة",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  const Spacer(),
                  Text(
                    lawyer.region!.name!,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                ],
              ),
              // verticalSpace(20.h),
              // Row(
              //   children: [
              //     Icon(
              //       FontAwesomeIcons.earthAsia,
              //       color: appColors.primaryColorYellow,
              //       size: 20.sp,
              //     ),
              //     horizontalSpace(10.w),
              //     Text(
              //       "المدينة",
              //       style: TextStyles.cairo_12_semiBold
              //           .copyWith(
              //           color: appColors.grey15),
              //     ),
              //     const Spacer(),
              //     Text(
              //       lawyer.city!.title!,
              //       style: TextStyles.cairo_12_semiBold
              //           .copyWith(
              //           color: appColors.blue100),
              //     ),
              //   ],
              // ),
              verticalSpace(20.h),
              Row(
                children: [
                  Icon(
                    Icons.grade_outlined,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(10.w),
                  Text(
                    LocaleKeys.academicDegree.tr(),
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  const Spacer(),
                  Text(
                    lawyer.degree!.title!,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget workExperienceData(Account lawyer) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخبرات العملية",
            style: TextStyles.cairo_12_medium.copyWith(color: appColors.grey15),
          ),
          SizedBox(height: 16.h),
          if (lawyer.experiences != null && lawyer.experiences!.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lawyer.experiences!.length,
              separatorBuilder: (context, index) => Divider(height: 20.h),
              itemBuilder: (context, index) {
                final experience = lawyer.experiences![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: appColors.blue100,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      experience.company ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.grey5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${DateFormat('MMM yyyy').format(experience.from ?? DateTime.now())} - ${experience.to != null ? DateFormat('MMM yyyy').format(experience.to!) : 'حتى الآن'}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.grey5,
                      ),
                    ),
                  ],
                );
              },
            )
          else
            Center(
              child: Text(
                'لا توجد خبرات عملية',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: appColors.grey5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
