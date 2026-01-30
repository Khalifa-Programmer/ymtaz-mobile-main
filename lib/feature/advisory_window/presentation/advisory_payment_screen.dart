import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../../../core/widgets/webpay_new.dart';
import '../../layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../layout/account/presentation/widgets/user_profile_row.dart';
import '../logic/advisory_cubit.dart';
import 'advisor_time_selection.dart';

class AdvisoryPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = getit<AdvisoryCubit>();
    return BlocConsumer<AdvisoryCubit, AdvisoryState>(
      listener: (context, state) {
        if (state is AdvisorReservationLoading) {
          showLoadingDialog(context);
        } else if (state is AdvisorReservationLoaded) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebPaymentScreen(
                      link: state.data.data!.paymentUrl!)));
        } else if (state is AdvisorReservationError) {
          Navigator.pop(context);
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "مراجعة طلبك",
              style: TextStyles.cairo_14_bold,
            ),
            verticalSpace(5.h),
            Text(
              "ملخص طلبك للحصول على استشارة دقيقة",
              style: TextStyles.cairo_12_semiBold
                  .copyWith(color: appColors.grey15),
            ),
            verticalSpace(10.h),
            Divider(
              color: appColors.grey2,
              thickness: 1,
            ),
            verticalSpace(10.h),
            Text(
              "بيانات المحامي المختار",
              style: TextStyles.cairo_12_bold,
            ),
            verticalSpace(20.h),
            lawyerData(),
            verticalSpace(20.h),
            Text(
              "بيانات الاستشارة",
              style: TextStyles.cairo_12_bold,
            ),
            verticalSpace(20.h),
            advisoryData(),
            verticalSpace(50.h),
            Container(
              width: double.infinity,
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: appColors.primaryColorYellow,
                  child: Text(
                    "إرسال الطلب",
                    style: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.white),
                  ),
                  onPressed: () {
                    Map<String, Object?> map = {
                      "sub_price_id": cubit.selectedLevel!.id,
                      "description": cubit.description,
                      "lawyer_id": cubit.selectedLawyer!.lawyer!.id,
                    };
                    FormData newRequestData = FormData.fromMap(map);

                    if ( cubit.isNeedAppointment) {
                      newRequestData.fields.add(MapEntry("date", cubit.selectedDate!));
                      newRequestData.fields.add(MapEntry("from", cubit.selectedFrom!));
                      newRequestData.fields.add(MapEntry("to", cubit.selectedTo!));
                    }

                    if ( cubit.imagesDocs.isNotEmpty) {
                      for (int i = 0; i < cubit.imagesDocs.length; i++) {
                        newRequestData.files.add(MapEntry(
                          "files[$i]",
                          MultipartFile.fromFileSync(cubit.imagesDocs[i].path!),
                        ));
                      }
                    }

                    if ( cubit.recordPath != null && cubit.recordPath!.isNotEmpty) {
                      print(cubit.recordPath);
                      newRequestData.files.add(MapEntry(
                        "voice_file",
                        MultipartFile.fromFileSync(cubit.recordPath!),
                      ));
                    }




                    context.read<AdvisoryCubit>().createAdvisoryRequest(newRequestData);
                  }),
            ),
          ],
        );
      },
    );
  }

  Widget lawyerData() {
    var cubit = getit<AdvisoryCubit>();
    if (cubit.selectedLawyer == null || cubit.selectedLawyer!.lawyer == null) {
      return SizedBox.shrink(); // Return an empty widget if data is null
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          lawyerImage(cubit.selectedLawyer!.lawyer!),
          const SizedBox(width: 10),
          lawyerDetails(cubit.selectedLawyer!.lawyer!),
        ],
      ),
    ]);
  }

  Widget lawyerDetails(var lawyer) {
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
              "${lawyer.region?.name ?? ''} - ${lawyer.city?.title ?? ''}",
              style:
                  TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
            ),
          ],
        ),
      ],
    );
  }

  Widget lawyerImage(var lawyer) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: getColor(lawyer.currentRank?.borderColor ?? ''),
          radius: 26.0.sp,
          child: CachedNetworkImage(
            imageUrl: lawyer.image?.isEmpty ?? true
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
        Positioned(
          bottom: -8.0,
          left: 0,
          right: 35.w,
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 10.sp,
              backgroundColor: appColors.white,
              child: SvgPicture.network(
                lawyer.currentRank?.image ?? '',
                width: 12.0.w,
                height: 12.0.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  advisoryData() {
    var cubit = getit<AdvisoryCubit>();
    if (cubit.selectedLawyer == null || cubit.selectedLawyer!.subCategory == null) {
      return SizedBox.shrink(); // Return an empty widget if data is null
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "نوع الاستشارة",
            style:
                TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
          ),
          verticalSpace(5.h),
          Text(
            cubit.selectedLawyer!.subCategory!.name!,
            style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "نوع الوسيلة",
            style:
                TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
          ),
          verticalSpace(5.h),
          Text(
            cubit.isNeedAppointment ? "موعد مرئية" : "استشارة مكتوبة",
            style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "سعر الاستشارة",
            style:
                TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
          ),
          verticalSpace(5.h),
          Text(
            "${cubit.selectedLawyer!.price} ريال",
            style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
        ]),
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
          ),
        );
      },
    );
  }
}
