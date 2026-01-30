import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../layout/account/presentation/widgets/user_profile_row.dart';

class LawyerCardAdvisory extends StatelessWidget {
  const LawyerCardAdvisory() : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
          side: BorderSide(
            color: appColors.grey2,
            width: 1,
          ),

          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              lawyerImage(),
              const SizedBox(width: 10),
              lawyerDetails(),
            ],
          ),
          verticalSpace(10.h),
          Divider(
            color: appColors.grey2,
            thickness: 1,
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Text(
                "المستوى : عادي",
                style: TextStyles.cairo_12_regular.copyWith(
                  color: appColors.blue100,
                ),
              ),
              Spacer(), // Add spacing between elements
              Text(
                "٢٠٠٠ ريال",
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.primaryColorYellow,
                ),
              ),
            ],
          ),
          verticalSpace(10.h),
          Text(
            "محامي متخصص في البرمجة والتكنولوجيا والعقود الالكترونية",
            style: TextStyles.cairo_12_regular.copyWith(
              color: appColors.grey15,
            ),
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  title: "طلب الإستشارة",
                  onPress: () {},
                  bgColor: appColors.blue100,
                  fontSize: 10.sp,
                  height: 30.h,
                  borderColor: appColors.blue100,
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                flex: 1,
                child: CustomButton(
                  title: "تفاصيل",
                  onPress: () {},
                  fontSize: 10.sp,
                  height: 30.h,
                  bgColor: appColors.white,
                  titleColor: appColors.blue100,
                  borderColor: appColors.blue100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget lawyerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "محمد ماجد التهامي",
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.blue100,
              ),
            ),
            horizontalSpace(3.0.w),
            const Icon(
              Icons.verified,
              color: Color(0xffd0b101),
              size: 15,
            )
          ],
        ),
        verticalSpace(4.h),
        Row(
          children: [
            Icon(
              CupertinoIcons.location_solid,
              color: appColors.primaryColorYellow,
              size: 15.sp,
            ),
            horizontalSpace(5.w),
            Text(
              "مصر - مصر",
              style:
                  TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
            ),
          ],
        ),
      ],
    );
  }

  Widget lawyerImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: appColors.grey,
          radius: 26.0.sp,
          child: CachedNetworkImage(
            imageUrl: "https://api.ymtaz.sa/uploads/person.png",
            imageBuilder: (context, imageProvider) => Container(
              width: 48.0.w,
              height: 48.0.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                imageShimmer(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),

        // SVG positioned at the bottom center, half outside the CircleAvatar
        Positioned(
          bottom: -8.0,
          // Adjust to position half of the SVG outside the avatar
          left: 0,
          right: 35.w,
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 10.sp,
              backgroundColor: appColors.white,
              child: SvgPicture.network(
                "https://api.ymtaz.sa/uploads/ranks/BrownShield.svg",
                width: 12.0.w, // Adjust width according to your design
                height: 12.0.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
