import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/spacing.dart';
import '../../layout/account/presentation/guest_screen.dart';

class ForensicGuideSubCategoryScreen extends StatelessWidget {
  const ForensicGuideSubCategoryScreen({super.key, required this.data});

  final SubCategory data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.name ?? "",
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: data.judicialGuides!.isEmpty ? const NodataFound() : _buildBody(),
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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          itemCount: data.judicialGuides!.length,
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
        var userType = CacheHelper.getData(key: 'userType');

        userType == 'guest'
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GestScreen(),
                ))
            : context.pushNamed(Routes.forensicGuideDetails,
                arguments: data.judicialGuides![index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5.h),
        // padding: const EdgeInsets.all(10),
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
          children: [
            Container(
              height: 60.h,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.judicialGuides![index].name ?? "",
                    maxLines: 3,
                    style: TextStyles.cairo_12_bold.copyWith(
                      color: appColors.black,
                    ),
                  ),
                  verticalSpace(5),
                  Text(
                    data.judicialGuides![index].city?.title ?? "",
                    maxLines: 3,
                    style: TextStyles.cairo_10_semiBold.copyWith(
                      color: appColors.grey20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
