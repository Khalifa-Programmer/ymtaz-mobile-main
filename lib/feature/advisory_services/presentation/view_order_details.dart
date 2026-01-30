import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_services/data/model/all_advirsory_response.dart';
import 'package:yamtaz/feature/advisory_services/presentation/call_screen.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/widgets/webview_pdf.dart';

class ViewOrderDetails extends StatelessWidget {
  const ViewOrderDetails(
      {super.key, required this.servicesRequirementsResponse});

  final Reservation servicesRequirementsResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل الاستشارة',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0.sp),
              margin: EdgeInsets.all(20.0.sp),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تفاصيل الاستشارة",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey15,
                    ),
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.ticket,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "نوع الاستشارة ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        servicesRequirementsResponse.advisoryServicesId!.title!,
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.dollar,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "السعر ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        "${servicesRequirementsResponse.price ?? 0} ريال",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important_outline_rounded,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "مستوي الطلب",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        servicesRequirementsResponse.importance?.title ??
                            "مجاني",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0.sp),
              margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تفاصيل الرد علي الخدمة",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey15,
                    ),
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.quickreply_outlined,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "حالة الرد ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: appColors.blue100.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          getStatusText(
                              servicesRequirementsResponse.reply == null
                                  ? 0
                                  : 2),
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                ],
              ),
            ),
            ConditionalBuilder(
                condition: servicesRequirementsResponse.callId != null,
                builder: (context) => Container(
                      padding: EdgeInsets.all(20.0.sp),
                      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "يوم الاستشارة",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                getDate(servicesRequirementsResponse.from!),
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "وقت  بدء المكالمة ",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                getTime(servicesRequirementsResponse.from!),
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.time,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "مدة الاستشارة ",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                getTime(servicesRequirementsResponse.from!),
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(20.h),
                          CustomButton(
                            onPress: () async {
                              try {
                                var userType =
                                    CacheHelper.getData(key: 'userType');
                                if (userType == 'client') {
                                  StreamVideo.reset();
                                  await StreamVideo(
                                    'd3cgunkh7jrg',
                                    user: User.regular(
                                        userId: getit<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .client!
                                            .streamioId
                                            .toString(),
                                        name: getit<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .client!
                                            .name),
                                    userToken: getit<MyAccountCubit>()
                                        .clientProfile!
                                        .data!
                                        .client!
                                        .streamioToken,
                                  );
                                } else {
                                  StreamVideo.reset();
                                  await StreamVideo(
                                    'd3cgunkh7jrg',
                                    user: User.regular(
                                        userId: getit<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .client!
                                            .streamioId
                                            .toString(),
                                        name: getit<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .client!
                                            .name),
                                    userToken: getit<MyAccountCubit>()
                                        .userDataResponse!
                                        .data!
                                        .client!
                                        .streamioToken,
                                  );
                                }

                                var call = StreamVideo.instance.makeCall(
                                  // type: 'default',
                                  callType: StreamCallType.custom("default"),
                                  id: servicesRequirementsResponse.callId!,
                                );

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CallScreen(call: call),
                                  ),
                                );

                                await call.getOrCreate();
                              } catch (e) {
                                debugPrint(
                                    'Error joining or creating call: $e');
                                debugPrint(e.toString());
                              }
                            },
                            title: 'بدء المكالمة',
                            height: 35.h,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ),
                fallback: (context) => SizedBox()),
            verticalSpace(20.h),
            Container(
              padding: EdgeInsets.all(20.0.sp),
              margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "وصف الخدمة",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey15,
                    ),
                  ),
                  verticalSpace(20.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: appColors.primaryColorYellow,
                            size: 20.sp,
                          ),
                          Text(
                            "الوصف ",
                            style: TextStyles.cairo_14_semiBold
                                .copyWith(color: appColors.grey5),
                          ),
                        ],
                      ),
                      verticalSpace(10.w),
                      ReadMoreText(
                        servicesRequirementsResponse.description!,
                        trimCollapsedText: 'عرض المزيد',
                        trimExpandedText: 'عرض اقل',
                        moreStyle: TextStyles.cairo_14_bold
                            .copyWith(color: appColors.black),
                        style: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                      // Text(
                      //   servicesRequirementsResponse.description!,
                      //   style: TextStyles.cairo_14_semiBold
                      //       .copyWith(color: ColorsPalletes.blue100),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: servicesRequirementsResponse.reply != null,
              child: Container(
                padding: EdgeInsets.all(20.0.sp),
                margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20.h),
                    Text(
                      "الرد علي الخدمة",
                      style: TextStyles.cairo_16_bold
                          .copyWith(color: appColors.blue100),
                    ),
                    verticalSpace(10.h),
                    Container(
                      width: 130.w,
                      height: 2.h,
                      color: appColors.primaryColorYellow,
                    ),
                    verticalSpace(20.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: appColors.primaryColorYellow,
                              size: 20.sp,
                            ),
                            Text(
                              "الرد ",
                              style: TextStyles.cairo_14_semiBold
                                  .copyWith(color: appColors.grey5),
                            ),
                          ],
                        ),
                        verticalSpace(10.w),
                        ReadMoreText(
                          servicesRequirementsResponse.reply?.reply ?? "",
                          trimCollapsedText: 'عرض المزيد',
                          trimExpandedText: 'عرض اقل',
                          moreStyle: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.black),
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(20.h),
            Visibility(
              visible: servicesRequirementsResponse.file != null,
              child: Container(
                padding: EdgeInsets.all(20.0.sp),
                margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: appColors.primaryColorYellow,
                          size: 20.sp,
                        ),
                        Text(
                          "الملفات المرفقة",
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.grey5),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfWebView(
                                      link: servicesRequirementsResponse.file!,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: appColors.blue100.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              color: appColors.blue100,
                              size: 20.sp,
                            ),
                            horizontalSpace(10.w),
                            Text(
                              "ملف الوثيقة",
                              style: TextStyles.cairo_14_semiBold
                                  .copyWith(color: appColors.blue100),
                            ),
                            Spacer(),
                            Icon(
                              Icons.remove_red_eye_rounded,
                              color: appColors.blue100,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(50.h),
          ],
        ),
      ),
    );
  }

  String getStatusText(int requestStatus) {
    // Map لتحديد النص المقابل لكل requestStatus
    Map<int, String> statusTextMap = {
      0: 'قيد الانتظار',
      1: 'قيد الدراسة',
      2: 'مكتملة',
    };

    // تحقق مما إذا كانت القيمة موجودة في الخريطة
    return statusTextMap.containsKey(requestStatus)
        ? statusTextMap[requestStatus]!
        : 'حالة غير معروفة';
  }
}
