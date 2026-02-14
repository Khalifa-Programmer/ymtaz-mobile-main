import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/gamification/gamification.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../digital_office/view/widgets/main_screen/balance_card.dart';
import '../client_profile/presentation/client_my_profile.dart';
import '../widgets/user_profile_row.dart';

class SeeMyProfileProvider extends StatelessWidget {
  const SeeMyProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<MyAccountCubit>()..loading(),
      child: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          MyAccountCubit myAccountCubit = getit<MyAccountCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "المعلومات الشخصية",
                style: TextStyles.cairo_14_bold,
              ),
              centerTitle: true,
            ),
            body: RefreshIndicator(
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
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: getColor(myAccountCubit
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .currentRank!
                                            .borderColor!),
                                        radius: 53.0.sp,
                                        child: CachedNetworkImage(
                                          imageUrl: myAccountCubit
                                                  .userDataResponse!
                                                  .data!
                                                  .account!
                                                  .photo!
                                                  .isEmpty
                                              ? "https://api.ymtaz.sa/uploads/person.png"
                                              : myAccountCubit.userDataResponse!
                                                  .data!.account!.photo!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 100.0.w,
                                            height: 100.0.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              imageShimmer(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
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
                                            child: CachedNetworkImage(
                                              imageUrl: myAccountCubit
                                                  .userDataResponse!
                                                  .data!
                                                  .account!
                                                  .currentRank!
                                                  .image!,
                                              width: 12.0.w,
                                              height: 12.0.h,
                                              placeholder: (context, url) =>
                                                  SizedBox(
                                                      width: 12.w,
                                                      height: 12.h,
                                                      child:
                                                          const CircularProgressIndicator(
                                                              strokeWidth: 2)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SvgPicture.asset(
                                                AppAssets.rank,
                                                width: 12.0.w,
                                                height: 12.0.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                              myAccountCubit
                                                  .userDataResponse!
                                                  .data!
                                                  .account!
                                                  .name!, // Static name
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: appColors
                                                    .primaryColorYellow,
                                              ),
                                            ),
                                            horizontalSpace(5.w),
                                            myAccountCubit
                                                        .userDataResponse!
                                                        .data!
                                                        .account!
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
                                        SizedBox(height: 5.h),
                                        Text(
                                          myAccountCubit.userDataResponse!.data!
                                              .account!.email!,
                                          style: TextStyles.cairo_14_semiBold
                                              .copyWith(color: appColors.grey5),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "5 / ${myAccountCubit.userDataResponse!.data!.account!.ratesAvg ?? "0"} ",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: appColors.grey5,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color:
                                                  appColors.primaryColorYellow,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                ],
                              ),
                            ),

                            Gamification(
                              daysStreak: context
                                      .read<MyAccountCubit>()
                                      .userDataResponse!
                                      .data!
                                      .account!
                                      .daysStreak ??
                                  0,
                              points: context
                                  .read<MyAccountCubit>()
                                  .userDataResponse!
                                  .data!
                                  .account!
                                  .points!,
                              xp: context
                                  .read<MyAccountCubit>()
                                  .userDataResponse!
                                  .data!
                                  .account!
                                  .xp!,
                              xpUntilNextLevel: context
                                  .read<MyAccountCubit>()
                                  .userDataResponse!
                                  .data!
                                  .account!
                                  .xpUntilNextLevel!,
                              currentLevel: context
                                  .read<MyAccountCubit>()
                                  .userDataResponse!
                                  .data!
                                  .account!
                                  .currentLevel!,
                              currentRank: context
                                  .read<MyAccountCubit>()
                                  .userDataResponse!
                                  .data!
                                  .account!
                                  .currentRank!
                                  .name!,
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
                                      (myAccountCubit.userDataResponse!.data!
                                                      .account!.about ==
                                                  null ||
                                              myAccountCubit.userDataResponse!
                                                  .data!.account!.about!.isEmpty ||
                                              myAccountCubit
                                                      .userDataResponse!
                                                      .data!
                                                      .account!
                                                      .about!
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "null")
                                          ? "-"
                                          : myAccountCubit.userDataResponse!
                                              .data!.account!.about!,
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
                                    spacing: 8.0.w, // spacing between chips
                                    runSpacing:
                                        4.0, // spacing between rows of chips
                                    children: myAccountCubit.userDataResponse!
                                        .data!.account!.sections!
                                        .map((section) {
                                      return Chip(
                                        side: BorderSide(
                                          color: appColors.primaryColorYellow
                                              .withOpacity(0.1),
                                          width: 1,
                                        ),
                                        color: WidgetStatePropertyAll<Color>(
                                            appColors.primaryColorYellow
                                                .withOpacity(0.1)),

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
                                        (myAccountCubit.userDataResponse!.data!
                                                        .account!.country?.name !=
                                                    null &&
                                                myAccountCubit
                                                        .userDataResponse!
                                                        .data!
                                                        .account!
                                                        .country!
                                                        .name!
                                                        .toLowerCase() !=
                                                    'null')
                                            ? myAccountCubit.userDataResponse!
                                                .data!.account!.country!.name!
                                            : '-',
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.earthAfrica,
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
                                        (myAccountCubit.userDataResponse!.data!
                                                        .account!.city?.title !=
                                                    null &&
                                                myAccountCubit
                                                        .userDataResponse!
                                                        .data!
                                                        .account!
                                                        .city!
                                                        .title!
                                                        .toLowerCase() !=
                                                    'null')
                                            ? myAccountCubit.userDataResponse!
                                                .data!.account!.city!.title!
                                            : '-',
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
                                        LocaleKeys.city.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        (myAccountCubit.userDataResponse!.data!
                                                        .account!.region?.name !=
                                                    null &&
                                                myAccountCubit
                                                        .userDataResponse!
                                                        .data!
                                                        .account!
                                                        .region!
                                                        .name!
                                                        .toLowerCase() !=
                                                    'null')
                                            ? myAccountCubit.userDataResponse!
                                                .data!.account!.region!.name!
                                            : '-',
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.idCard,
                                        color: appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        LocaleKeys.nationality.tr(),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        (myAccountCubit.userDataResponse!.data!
                                                        .account!.nationality?.name !=
                                                    null &&
                                                myAccountCubit.userDataResponse!
                                                        .data!
                                                        .account!
                                                        .nationality!
                                                        .name!
                                                        .toLowerCase() !=
                                                    'null')
                                            ? myAccountCubit.userDataResponse!
                                                .data!.account!.nationality!.name!
                                            : '-',
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
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
                                        (myAccountCubit.userDataResponse!.data!
                                                        .account!.degree?.title !=
                                                    null &&
                                                myAccountCubit
                                                        .userDataResponse!
                                                        .data!
                                                        .account!
                                                        .degree!
                                                        .title!
                                                        .toLowerCase() !=
                                                    'null')
                                            ? myAccountCubit.userDataResponse!
                                                .data!.account!.degree!.title!
                                            : '-',
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(20.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_sharp,
                                        color: appColors.primaryColorYellow,
                                        size: 20.sp,
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        "تاريخ الانضمام",
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.grey15),
                                      ),
                                      const Spacer(),
                                      Text(
                                        getDate(myAccountCubit.userDataResponse!
                                            .data!.account!.createdAt!),
                                        style: TextStyles.cairo_12_semiBold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            getit<MyAccountCubit>()
                                        .userDataResponse!
                                        .data!
                                        .account!
                                        .digitalGuideSubscription ==
                                    1
                                ? const SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: const SubscripeCard(),
                                  ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
