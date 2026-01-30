import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../feature/my_appointments/data/model/avaliable_appointment_lawyer_model.dart';
import '../../../digital_guide/presentation/digetal_providers_screen.dart';
import '../../../layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../../layout/account/presentation/widgets/user_profile_row.dart';

class LawyerCard extends StatelessWidget {
  const LawyerCard(this.lawyer, this.service, this.price, this.importance, this.isSelected, this.onSelect, {super.key});

  final Lawyer lawyer;
  final ReservationType service;
  final  importance;
  final String price;
  final bool isSelected;
  final Function(Lawyer) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w , vertical: 20.h),
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
                "المستوى : ${importance!.name!}",
                style: TextStyles.cairo_12_bold.copyWith(
                  color: appColors.blue100,
                ),
              ),

            ],
          ),
          verticalSpace(10.h),
          Text(

            "${lawyer.about!}",
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
                  title: isSelected ? "حذف المحامي" : "اختيار المحامي",
                  onPress: () {
                    onSelect(lawyer);
                  },
                  bgColor: isSelected ? appColors.red : appColors.blue100,
                  fontSize: 10.sp,
                  height: 30.h,
                  borderColor: isSelected ? appColors.red : appColors.blue100,
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                flex: 1,
                child: CustomButton(
                  title: "تفاصيل",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DigitalProvidersScreen(
                          idLawyer: lawyer.id!.toString(),
                        ),
                      ),
                    );
                  },
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
              "${lawyer.name}",
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.blue100,
              ),
            ),
            horizontalSpace(3.0.w),
            lawyer.hasBadge == "blue"
                ? Icon(
              Icons.verified,
              color: CupertinoColors.activeBlue,
              size: 15,
            )
                : lawyer.hasBadge == "gold"
                ? const Icon(
              Icons.verified,
              color: Color(0xffd0b101),
              size: 15,
            )
                : SizedBox(),
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
              "${lawyer.region!.name!} - ${lawyer.city!.title!}",
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
          backgroundColor: getColor(lawyer.currentRank!.borderColor!),
          radius: 26.0.sp,
          child: CachedNetworkImage(
            imageUrl: lawyer.image!.isEmpty
                ? "https://api.ymtaz.sa/uploads/person.png"
                : lawyer.image!,
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
                lawyer.currentRank!.image!,
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
