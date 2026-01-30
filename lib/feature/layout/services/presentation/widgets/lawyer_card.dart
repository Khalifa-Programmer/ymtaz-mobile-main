import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/layout/services/data/model/available_lawyers_for_service_model.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../digital_guide/presentation/digetal_providers_screen.dart';
import '../../../account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../../account/presentation/widgets/user_profile_row.dart';

class LawyerCard extends StatelessWidget {
  const LawyerCard(this.lawyer, this.service, this.price, this.importance,
      this.isSelected, this.onSelect,
      {super.key});

  final Lawyer lawyer;
  final Service service;
  final Importance importance;
  final String price;
  final bool isSelected;
  final Function(Lawyer) onSelect;

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
                "المستوى : ${importance.title!}",
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

  void showPrePaymentBottomSheet(BuildContext context, Service item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: appColors.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              verticalSpace(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تفاصيل الدفع",
                    style: TextStyles.cairo_18_bold
                        .copyWith(color: appColors.blue100),
                  ),
                  IconButton(
                    color: appColors.blue100,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              verticalSpace(10.h),
              const Divider(color: appColors.grey),
              verticalSpace(10.h),
              _buildRow("اسم الخدمة", item.title ?? ""),
              verticalSpace(10.h),
              _buildRow("مستوى الطلب", importance.title ?? "مستوى غير محدد"),
              verticalSpace(10.h),
              const Divider(color: appColors.grey),
              verticalSpace(10.h),
              _buildRow("المجموع الكلي", "${price} ريال"),
              verticalSpace(10.h),
              _buildRow('الضرائب', '15%'),
              verticalSpace(3.h),
              const Text("*السعر شامل ضريبة القيمة المضافة"),
              verticalSpace(20.h),
              // CustomButton(
              //   bgColor: appColors.blue100,
              //   borderColor: appColors.blue100,
              //   fontWeight: FontWeight.bold,
              //   height: 40.h,
              //   fontSize: 12.sp,
              //   title: 'ادفع الآن',
              //   onPress: () {
              //     FormData form = FormData.fromMap({
              //       "service_id": getit<ServicesCubit>().selectedServiceId,
              //       "priority": getit<ServicesCubit>().selectedPriority,
              //       'lawyer_id': lawyer.id,
              //       "accept_rules": "1",
              //     });
              //     if (getit<ServicesCubit>().documentFile != null) {
              //       form.files.add(MapEntry(
              //           "file",
              //           MultipartFile.fromFileSync(
              //               getit<ServicesCubit>().documentFile!.path)));
              //     }
              //     getit<ServicesCubit>().requestService(form);
              //   },
              // ),
              verticalSpace(20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value,
      {Color color = appColors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        Text(
          value,
          style: TextStyles.cairo_14_regular.copyWith(color: color),
        ),
      ],
    );
  }
}
