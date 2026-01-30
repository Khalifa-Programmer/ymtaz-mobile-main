import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/spacing.dart';

class ForensicGuideCategoryScreen extends StatelessWidget {
  const ForensicGuideCategoryScreen(
      {super.key, Object? index, required this.data});

  final JudicialGuidesMainCategory data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.name!,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: ConditionalBuilder(
          condition: data.subCategories == null || data.subCategories!.isEmpty,
          builder: (context) {
            return const Center(
              child: NodataFound(),
            );
          },
          fallback: (context) {
            return _buildBody();
          }),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      color: appColors.primaryColorYellow,
      onRefresh: () async {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 5.5,
            crossAxisCount: 1,
            crossAxisSpacing: 8.0.w,
            mainAxisSpacing: 8.0.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          itemCount: data.subCategories!.length,
          itemBuilder: (context, index) {
            return _buildCategoryItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.forensicGuideSubCategoryDetails,
            arguments: data.subCategories![index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 4.h,
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? appColors.primaryColorYellow
                    : appColors.blue90,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            horizontalSpace(20.w),
            SvgPicture.asset(
              AppAssets.guide ?? '',
              width: 24.sp,
              height: 24.sp,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            horizontalSpace(15.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.subCategories![index].name!,
                    textAlign: TextAlign.center,
                    style: TextStyles.cairo_13_bold.copyWith(
                      color: appColors.blue100,
                    )),
                verticalSpace(5),
                Text(
                  data.subCategories![index].region!.name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyles.cairo_12_semiBold.copyWith(
                    color: appColors.grey20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: appColors.primaryColorYellow.withOpacity(0.5)),
              child: Text(
                  data.subCategories![index].judicialGuides!.length.toString(),
                  style: TextStyles.cairo_12_bold.copyWith(
                    color: appColors.blue90,
                  )),
            ),
            horizontalSpace(24.w),
          ],
        ),
      ),
    );
  }
}
