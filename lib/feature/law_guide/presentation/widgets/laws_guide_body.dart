import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../data/model/law_response.dart';
import '../../logic/law_guide_cubit.dart';
import '../about_guide.dart';
import '../law_data_screen.dart';
import 'loading_widget.dart';

class LawsGuideBodyWidget extends StatelessWidget {
  const LawsGuideBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lawGuideCubit = getit<LawGuideCubit>();

    return BlocProvider.value(
      value: lawGuideCubit,
      child: BlocConsumer<LawGuideCubit, LawGuideState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            color: appColors.primaryColorYellow,
            onRefresh: () async {
              await lawGuideCubit.getLawsGuideSubFromSub(
                lawGuideCubit.lawResponse!.data!.lawGuide!.id!.toString(),
              );
            },
            child: lawGuideCubit.lawResponse == null ||
                    lawGuideCubit
                        .lawResponse!.data!.lawGuide!.laws!.data!.isEmpty
                ? const NodataFound()
                : SizedBox(
                    height: 0.8.sh,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!lawGuideCubit.isLoading &&
                            !lawGuideCubit.isLoadingMore &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 100) {
                          lawGuideCubit.getLawsGuideSubFromSub(
                            lawGuideCubit.lawResponse!.data!.lawGuide!.id!
                                .toString(),
                            loadMore: true,
                          );
                        }
                        return true;
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 65.h),
                              itemCount: lawGuideCubit.lawResponse!.data!
                                      .lawGuide!.laws!.data!.length +
                                  (lawGuideCubit.isLoadingMore ? 1 : 0) +
                                  1,
                              // زيادة 1 للعنصر الجديد
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  // العنصر الأول هو "مقدمة النظام"
                                  return CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AboutGuide(
                                              title: getit<LawGuideCubit>()
                                                  .lawResponse!
                                                  .data!
                                                  .lawGuide!
                                                  .name!,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      height: 60.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shadows: [
                                          BoxShadow(
                                            color: Colors.black12
                                                .withOpacity(0.04),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: appColors.primaryColorYellow
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            border: Border.all(
                                                width: 1,
                                                color: appColors.darkYellow10)),
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: -100,
                                              top: -200,
                                              child: Container(
                                                width: 300,
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: appColors
                                                      .primaryColorYellow
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: -100,
                                              bottom: -200,
                                              child: Container(
                                                width: 300,
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: appColors
                                                      .primaryColorYellow
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25.w,
                                                  vertical: 10.h),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        AppAssets
                                                                .forensicGuide ??
                                                            '',
                                                        width: 24.sp,
                                                        height: 24.sp,
                                                        placeholderBuilder:
                                                            (context) =>
                                                                const CircularProgressIndicator(),
                                                      ),
                                                      horizontalSpace(15.w),
                                                      Text(
                                                        "مقدمة النظام",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Cairo',
                                                          color:
                                                              appColors.blue100,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                }

                                // العنصر العادي في القائمة
                                int adjustedIndex = index -
                                    1; // تعديل الفهرس للوصول إلى العناصر الصحيحة
                                if (lawGuideCubit.isLoadingMore &&
                                    adjustedIndex ==
                                        lawGuideCubit.lawResponse!.data!
                                            .lawGuide!.laws!.data!.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: SkeletonLoader(),
                                  );
                                }

                                return _buildCategoryItem(
                                    context, adjustedIndex);
                              },
                            ),
                          ),
                          if (lawGuideCubit.isLoading)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appColors.primaryColorYellow),
                                  ),
                                  SizedBox(height: 16),
                                  Text("جارٍ تحميل المحتوى...",
                                      style:
                                          TextStyle(color: appColors.grey15)),
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
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    Datum data =
        getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.laws!.data![index];

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LawDataScreen(
              data: getit<LawGuideCubit>()
                  .lawResponse!
                  .data!
                  .lawGuide!
                  .laws!
                  .data!,
              index: index,
              title: getit<LawGuideCubit>().lawResponse!.data!.lawGuide!.name!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4.h,
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? appColors.blue90
                      : appColors.primaryColorYellow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: SvgPicture.asset(
                          AppAssets.forensicGuide ?? '',
                          width: 24.sp,
                          height: 24.sp,
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.name!.trim(),
                                    textAlign: TextAlign.start,
                                    style: TextStyles.cairo_13_bold.copyWith(
                                      color: appColors.blue100,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                if (data.changes != null &&
                                    data.changes!.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.w),
                                    child: Icon(
                                      Icons.edit_note_sharp,
                                      color: appColors.primaryColorYellow,
                                      size: 20.sp,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              data.law!.trim(),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.cairo_12_semiBold.copyWith(
                                color: appColors.grey15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
