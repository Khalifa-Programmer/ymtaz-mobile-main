import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/law_by_id_response.dart';
import '../logic/law_guide_cubit.dart';

class LawByIdScreen extends StatelessWidget {
  const LawByIdScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LawGuideCubit>()..getLawById(id),
      child: BlocConsumer<LawGuideCubit, LawGuideState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: getit<LawGuideCubit>().lawByIdResponse != null,
            builder: (BuildContext context) {
              var data = getit<LawGuideCubit>().lawByIdResponse!.data!;
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(data.law!.name!,
                      style: TextStyles.cairo_14_bold.copyWith(
                        color: appColors.black,
                      )),
                ),
                body: BlocConsumer<LawGuideCubit, LawGuideState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Animate(
                        effects: [FadeEffect(delay: 200.ms)],
                        child: SingleChildScrollView(
                          child: ConditionalBuilder(
                            condition: data.law != null,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  verticalSpace(20.h),
                                  SvgPicture.asset(
                                    AppAssets.logo,
                                    color: appColors.primaryColorYellow,
                                    width: 40.w,
                                    height: 40.w,
                                  ),
                                  verticalSpace(10.h),
                                  Animate(effects: [
                                    FadeEffect(delay: 200.ms),
                                  ], child: LawDataBody(data: data)),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(24.sp),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shadows: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.04),
                                                // Shadow color
                                                spreadRadius: 3,
                                                // Spread radius
                                                blurRadius: 10,
                                                // Blur radius
                                                offset: const Offset(0,
                                                    3), // Offset in x and y direction
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                              // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "الاسم",
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    data.law!.lawGuide!.name!,
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
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
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    getDate(data.law!.lawGuide!
                                                        .releasedAt!
                                                        .toString()),
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
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
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    getDate(data.law!.lawGuide!
                                                        .publishedAt!
                                                        .toString()),
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "تاريخ الإصدار هجري",
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    getDate(data.law!.lawGuide!
                                                        .releasedAtHijri!
                                                        .toString()),
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "تاريخ النشر هجري",
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    getDate(data.law!.lawGuide!
                                                        .publishedAtHijri!
                                                        .toString()),
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
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
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    data.law!.lawGuide!
                                                                .status! ==
                                                            "1"
                                                        ? "ساري"
                                                        : "غير ساري",
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: data.law!.lawGuide!
                                                                        .status! ==
                                                                    "1"
                                                                ? appColors
                                                                    .primaryColorYellow
                                                                : appColors
                                                                    .red),
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
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    data.law!.lawGuide!
                                                        .releaseTool!,
                                                    style: TextStyles
                                                        .cairo_12_semiBold
                                                        .copyWith(
                                                            color: appColors
                                                                .blue100),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                            fallback: (BuildContext context) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            },
                          ),
                        ));
                  },
                ),
              );
            },
            fallback: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("جاري تحميل البيانات",
                      style: TextStyles.cairo_14_bold.copyWith(
                        color: appColors.black,
                      )),
                ),
                body: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LawDataBody extends StatelessWidget {
  const LawDataBody({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(delay: 200.ms),
      ],
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.law!.name!,
                    style: const TextStyle(
                      color: appColors.blue100,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.copy_rounded,
                    color: appColors.primaryColorYellow,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: """
⚖️ يمتاز | دليل الأنظمة
•⁠  ⁠اسم النظام: ${data.law!.lawGuide!.name}
•⁠  ⁠اسم المادة: ${data.law!.name}
•⁠  ⁠نص المادة: ${data.law}

${data.law!.changes == null || data.law!.changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${data.law!.changes}"}

⏳ تصفح تطبيق يمتاز الآن :
 https://onelink.to/bb6n4x"""));
                  },
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.share_rounded,
                    color: appColors.primaryColorYellow,
                  ),
                  onPressed: () async {
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    Share.share(
                      """
⚖️ يمتاز | دليل الأنظمة

•⁠  ⁠اسم النظام: ${data.law!.lawGuide!.name}
•⁠  ⁠اسم المادة: ${data.law!.name}
•⁠  ⁠نص المادة: ${data.law}

${data.law!.changes == null || data.law!.changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${data.law!.changes}"}

⏳ تصفح تطبيق يمتاز الآن :
 https://onelink.to/bb6n4x""",
                      subject: 'يمتاز',
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                ),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.translate_rounded,
                      color: appColors.primaryColorYellow,
                    ),
                    onPressed: () async {}),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: appColors.grey1,
                border: Border.all(color: appColors.grey2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.law!.name!,
                      style: const TextStyle(
                        color: appColors.blue100,
                        fontSize: 14,
                      )),
                  const SizedBox(height: 10),
                  Text(data.law!.changes ?? "",
                      style: const TextStyle(
                        color: appColors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
