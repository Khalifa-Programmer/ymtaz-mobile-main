import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/spacing.dart';
import '../logic/forensic_guide_cubit.dart';
import '../logic/forensic_guide_state.dart';

class ForensicGuideScreen extends StatelessWidget {
  const ForensicGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ForensicGuideCubit>()..getJudicialGuide(),
      child: BlocConsumer<ForensicGuideCubit, ForensicGuideState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("الدليل العدلي",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body: ConditionalBuilder(
                condition:
                    getit<ForensicGuideCubit>().judicialGuideResponseModel ==
                        null,
                builder: (context) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                fallback: (context) {
                  return _buildBody();
                }),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      color: appColors.primaryColorYellow,
      onRefresh: () async {
        // getit<DigitalGuideCubit>().getDigitalGuide();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.85,
            crossAxisCount: 2,
            crossAxisSpacing: 8.0.w,
            mainAxisSpacing: 8.0.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          itemCount: getit<ForensicGuideCubit>()
              .judicialGuideResponseModel!
              .data!
              .judicialGuidesMainCategories!
              .length,
          itemBuilder: (context, index) {
            return _buildCategoryItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, index) {
    JudicialGuidesMainCategory data = getit<ForensicGuideCubit>()
        .judicialGuideResponseModel!
        .data!
        .judicialGuidesMainCategories![index];
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.forensicGuideCategory, arguments: data);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
              offset: const Offset(0, 3), // Offset in x and y direction
            ),
          ],
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: double.infinity,
              width: 4.h,
              decoration: BoxDecoration(
                color: index % 4 < 2
                    ? appColors.primaryColorYellow
                    : appColors.blue90,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.guide ?? '',
                    width: 24.sp,
                    height: 24.sp,
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                  ),
                  verticalSpace(4.h),
                  Text(data.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyles.cairo_11_bold.copyWith(
                        color: appColors.blue100,
                      )),
                  verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13.0.w, vertical: 2.0.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: appColors.primaryColorYellow.withOpacity(0.5)),
                    child: Text("${data.subCategories!.length}",
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: appColors.blue90,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: double.infinity,
              width: 4.h,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
