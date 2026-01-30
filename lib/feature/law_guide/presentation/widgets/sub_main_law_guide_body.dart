import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/feature/law_guide/logic/law_guide_cubit.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../core/constants/assets.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../data/model/law_guide_sub_main_response.dart';
import '../laws_from_sub.dart';

class SubMainLawGuideBodyWidget extends StatelessWidget {
  const SubMainLawGuideBodyWidget({super.key, required this.mainId});

  final String mainId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: appColors.primaryColorYellow,
      onRefresh: () async {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: getit<LawGuideCubit>()
                .lawGuideSubMainResponse!
                .data!
                .subCategories!
                .isEmpty
            ? const NodataFound()
            : Column(
                children: [
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5.5,
                      crossAxisCount: 1,
                      crossAxisSpacing: 8.0.w,
                      mainAxisSpacing: 8.0.h,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    itemCount: getit<LawGuideCubit>()
                        .lawGuideSubMainResponse!
                        .data!
                        .subCategories!
                        .length,
                    itemBuilder: (context, index) {
                      return _buildCategoryItem(context, index);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    SubCategory data = getit<LawGuideCubit>()
        .lawGuideSubMainResponse!
        .data!
        .subCategories![index];

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LawsFromSub(
                title: data.name!,
                subId: data.id.toString(),
                arPdfUrl: data.pdfFileAr,
                enPdfUrl: data.pdfFileEn,
                enwordUrl: data.wordFileEn,
                arwordUrl: data.wordFileAr,
              ),
            ));
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
              AppAssets.forensicGuide ?? '',
              width: 24.sp,
              height: 24.sp,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            horizontalSpace(15.w),
            Expanded(
              child: Text(data.name!,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyles.cairo_13_bold.copyWith(
                    color: appColors.blue100,
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: appColors.primaryColorYellow.withOpacity(0.5)),
              child: Text("${data.count ?? ""} مادة",
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
