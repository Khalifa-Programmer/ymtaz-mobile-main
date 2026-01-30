import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/gamification/gamification.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../../core/di/dependency_injection.dart';
import '../../../logic/my_account_cubit.dart';
import '../../../logic/my_account_state.dart';
import '../../widgets/user_profile_row.dart';

class SeeMyProfileClient extends StatelessWidget {
  const SeeMyProfileClient({super.key});

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
                LocaleKeys.myAccount.tr(),
                style: TextStyles.cairo_14_bold,
              ),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () {
                return context.read<MyAccountCubit>().refresh();
              },
              color: appColors.primaryColorYellow,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: ConditionalBuilder(
                      condition: state is! LoadingGetProvider,
                      builder: (BuildContext context) => Animate(
                            effects: [FadeEffect(delay: 200.ms)],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: getColor(
                                              myAccountCubit
                                                  .clientProfile!
                                                  .data!
                                                  .account!
                                                  .currentRank!
                                                  .borderColor!),
                                          radius: 53.0.sp,
                                          child: CachedNetworkImage(
                                            imageUrl: myAccountCubit
                                                    .clientProfile!
                                                    .data!
                                                    .account!
                                                    .photo ??
                                                "https://api.ymtaz.sa/uploads/person.png",
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
                                            errorWidget:
                                                (context, url, error) =>
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
                                              child: SvgPicture.network(
                                                myAccountCubit
                                                    .clientProfile!
                                                    .data!
                                                    .account!
                                                    .currentRank!
                                                    .image!,
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
                                      padding: EdgeInsets.only(top: 14.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            myAccountCubit.clientProfile!.data!
                                                .account!.name!,
                                            style: TextStyles.cairo_18_bold
                                                .copyWith(
                                                    color: appColors.blue100),
                                          ),
                                        ],
                                      ),
                                    ),
                                    verticalSpace(5.h),
                                    Text(
                                      myAccountCubit
                                          .clientProfile!.data!.account!.email!,
                                      style: TextStyles.cairo_14_semiBold
                                          .copyWith(color: appColors.grey5),
                                    ),
                                    verticalSpace(10.h),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.greenAccent.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "طالب خدمة",
                                        style: TextStyles.cairo_14_bold
                                            .copyWith(
                                                color: CupertinoColors
                                                    .activeGreen),
                                      ),
                                    ),
                                    Gamification(
                                      daysStreak: context
                                              .read<MyAccountCubit>()
                                              .clientProfile!
                                              .data!
                                              .account!
                                              .daysStreak ??
                                          0,
                                      points: context
                                          .read<MyAccountCubit>()
                                          .clientProfile!
                                          .data!
                                          .account!
                                          .points!,
                                      xp: context
                                          .read<MyAccountCubit>()
                                          .clientProfile!
                                          .data!
                                          .account!
                                          .xp!,
                                      xpUntilNextLevel: context
                                          .read<MyAccountCubit>()
                                          .clientProfile!
                                          .data!
                                          .account!
                                          .xpUntilNextLevel!,
                                      currentLevel: context
                                          .read<MyAccountCubit>()
                                          .clientProfile!
                                          .data!
                                          .account!
                                          .currentLevel!,
                                      currentRank: context
                                          .read<MyAccountCubit>()
                                          .clientProfile!
                                          .data!
                                          .account!
                                          .currentRank!
                                          .name!,
                                    ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.personalInformation.tr(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: appColors.grey15,
                                            ),
                                          ),
                                          verticalSpace(20.h),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.earthAsia,
                                                color: appColors
                                                    .primaryColorYellow,
                                                size: 20.sp,
                                              ),
                                              horizontalSpace(10.w),
                                              Text(
                                                LocaleKeys.country.tr(),
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color: appColors.grey5),
                                              ),
                                              const Spacer(),
                                              Text(
                                                myAccountCubit
                                                        .clientProfile!
                                                        .data!
                                                        .account
                                                        ?.country
                                                        ?.name ??
                                                    "غير مختارة",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color:
                                                            appColors.blue100),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20.h),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.earthAsia,
                                                color: appColors
                                                    .primaryColorYellow,
                                                size: 20.sp,
                                              ),
                                              horizontalSpace(10.w),
                                              Text(
                                                "المنطقة",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color: appColors.grey5),
                                              ),
                                              Spacer(),
                                              Text(
                                                myAccountCubit
                                                        .clientProfile!
                                                        .data!
                                                        .account!
                                                        .city
                                                        ?.title ??
                                                    "غير مختارة",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color:
                                                            appColors.blue100),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20.h),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.earthAsia,
                                                color: appColors
                                                    .primaryColorYellow,
                                                size: 20.sp,
                                              ),
                                              horizontalSpace(10.w),
                                              Text(
                                                LocaleKeys.city.tr(),
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color: appColors.grey5),
                                              ),
                                              Spacer(),
                                              Text(
                                                myAccountCubit
                                                        .clientProfile!
                                                        .data!
                                                        .account
                                                        ?.region
                                                        ?.name ??
                                                    "غير مختارة",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color:
                                                            appColors.blue100),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20.h),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.idCard,
                                                color: appColors
                                                    .primaryColorYellow,
                                                size: 20.sp,
                                              ),
                                              horizontalSpace(10.w),
                                              Text(
                                                LocaleKeys.nationality.tr(),
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color: appColors.grey5),
                                              ),
                                              Spacer(),
                                              Text(
                                                myAccountCubit
                                                        .clientProfile!
                                                        .data!
                                                        .account!
                                                        .nationality
                                                        ?.name ??
                                                    "غير مختارة",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color:
                                                            appColors.blue100),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20.h),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range_rounded,
                                                color: appColors
                                                    .primaryColorYellow,
                                                size: 20.sp,
                                              ),
                                              horizontalSpace(10.w),
                                              Text(
                                                "تاريخ الانضمام",
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color: appColors.grey5),
                                              ),
                                              Spacer(),
                                              Text(
                                                getDate(myAccountCubit
                                                    .clientProfile!
                                                    .data!
                                                    .account!
                                                    .createdAt!),
                                                style: TextStyles
                                                    .cairo_14_semiBold
                                                    .copyWith(
                                                        color:
                                                            appColors.blue100),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20.h),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      fallback: (BuildContext context) => const Center(
                            child: CupertinoActivityIndicator(),
                          )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
