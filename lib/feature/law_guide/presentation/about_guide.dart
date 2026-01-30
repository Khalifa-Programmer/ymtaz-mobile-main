import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/spacing.dart';
import '../logic/law_guide_cubit.dart';

class AboutGuide extends StatelessWidget {
  const AboutGuide({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: getit<LawGuideCubit>(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(title,
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
          ),
          body: BlocConsumer<LawGuideCubit, LawGuideState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(24.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20.h),
                        Center(
                          child: SvgPicture.asset(
                            AppAssets.logo,
                            color: appColors.primaryColorYellow,
                            width: 40.w,
                            height: 40.w,
                          ),
                        ),
                        verticalSpace(30.h),
                        Row(
                          children: [
                            Text(
                              "مقدمة النظام",
                              style: TextStyles.cairo_14_bold
                                  .copyWith(color: appColors.blue100),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          getit<LawGuideCubit>()
                              .lawResponse!
                              .data!
                              .lawGuide!
                              .about!,
                          textAlign: TextAlign.justify,
                          style: TextStyles.cairo_12_semiBold.copyWith(
                            color: appColors.blue100,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(24.sp),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.04),
                                // Shadow color
                                spreadRadius: 3,
                                // Spread radius
                                blurRadius: 10,
                                // Blur radius
                                offset: const Offset(
                                    0, 3), // Offset in x and y direction
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "الاسم",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  Spacer(),
                                  Text(
                                    getit<LawGuideCubit>()
                                        .lawResponse!
                                        .data!
                                        .lawGuide!
                                        .name!,
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "تاريخ الإصدار",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${getDate(getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.releasedAt!.toString())}م / ${getDate(getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.releasedAtHijri!.toString())}هـ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "تاريخ النشر",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${getDate(getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.publishedAt!.toString())}م / ${getDate(getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.publishedAtHijri!.toString())}هـ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "الحالة",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  Spacer(),
                                  Text(
                                    getit<LawGuideCubit>()
                                                .lawResponse!
                                                .data!
                                                .lawGuide!
                                                .status! ==
                                            "1"
                                        ? "ساري"
                                        : "غير ساري",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(
                                            color: getit<LawGuideCubit>()
                                                        .lawResponse!
                                                        .data!
                                                        .lawGuide!
                                                        .status! ==
                                                    "1"
                                                ? appColors.primaryColorYellow
                                                : appColors.red),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "أداة إصدار النظام",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  horizontalSpace(10.w),
                                  Expanded(
                                    child: Text(
                                      maxLines: 4,
                                      getit<LawGuideCubit>()
                                          .lawResponse!
                                          .data!
                                          .lawGuide!
                                          .releaseTool!,
                                      style: TextStyles.cairo_12_semiBold
                                          .copyWith(
                                              color: appColors.blue100,
                                              overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
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
          ),
        ));
  }
}
