import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/core/widgets/webview_pdf.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/validators.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/primary/text_form_primary.dart';
import '../../../../main.dart';
import '../../../../yamtaz.dart';
import '../../data/models/services_from_provider_response.dart';
import '../../logic/office_provider_state.dart';

class ServiceScreenSetailsProvider extends StatefulWidget {
  ServiceScreenSetailsProvider(
      {super.key, required this.servicesRequirementsResponse});

  final ServiceRequest servicesRequirementsResponse;
  File? documentFile;

  @override
  State<ServiceScreenSetailsProvider> createState() =>
      _ServiceScreenSetailsProviderState();
}

class _ServiceScreenSetailsProviderState
    extends State<ServiceScreenSetailsProvider> {
  final TextEditingController externalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل الخدمة',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocProvider.value(
          value: getit<OfficeProviderCubit>(),
          child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedServicesReplyFromProviders: (value) {
                  context.pop();
                  widget.servicesRequirementsResponse.replay =
                      externalController.text;
                  widget.servicesRequirementsResponse.replayStatus = "تم الرد";
                  AppAlerts.showAlert(
                      context: context,
                      message: value.message!,
                      buttonText: "استمرار",
                      type: AlertType.success);
                },
                loadingServicesReplyFromProviders: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        surfaceTintColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                color: appColors.primaryColorYellow,
                              ),
                              horizontalSpace(16.sp),
                              const Text("جاري الرد على الخدمة"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                errorServicesReplyFromProviders: (value) {
                  context.pop();
                  AppAlerts.showAlert(
                      context: context,
                      message: value,
                      buttonText: "حاول مره اخرى",
                      type: AlertType.error);
                },
              );
            },
            builder: (context, state) {
              return Column(
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
                          "تفاصيل الخدمة",
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
                              "نوع الخدمة ",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.grey15),
                            ),
                            const Spacer(),
                            Text(
                              widget
                                  .servicesRequirementsResponse.service!.title!,
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
                              "${widget.servicesRequirementsResponse.price!} ريال",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.blue100),
                            ),
                          ],
                        ),
                        verticalSpace(20.h),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.time,
                              color: appColors.primaryColorYellow,
                              size: 20.sp,
                            ),
                            horizontalSpace(10.w),
                            Text(
                              "تاريخ الطلب ",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.grey15),
                            ),
                            const Spacer(),
                            Text(
                              getDate(widget
                                  .servicesRequirementsResponse.createdAt
                                  .toString()),
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
                              "مستوى الطلب",
                              style: TextStyles.cairo_12_semiBold
                                  .copyWith(color: appColors.grey15),
                            ),
                            const Spacer(),
                            Text(
                              widget.servicesRequirementsResponse.priority!
                                  .title!,
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
                        const Text(
                          "تفاصيل الرد على الخدمة",
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
                              style: TextStyles.cairo_14_semiBold
                                  .copyWith(color: appColors.grey5),
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
                                widget
                                    .servicesRequirementsResponse.replayStatus!,
                                style: TextStyles.cairo_14_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 6.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: widget
                                                    .servicesRequirementsResponse
                                                    .requestStatus ==
                                                0 ||
                                            widget.servicesRequirementsResponse
                                                    .requestStatus ==
                                                1 ||
                                            widget.servicesRequirementsResponse
                                                    .requestStatus ==
                                                2
                                        ? appColors.green
                                        : appColors.blue100.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  "قيد الانتظار",
                                  style: TextStyles.cairo_14_semiBold
                                      .copyWith(color: appColors.grey5),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 6.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: widget.servicesRequirementsResponse
                                                    .requestStatus ==
                                                2 ||
                                            widget.servicesRequirementsResponse
                                                    .requestStatus ==
                                                1
                                        ? appColors.green
                                        : appColors.blue100.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  "قيد الدراسة",
                                  style: TextStyles.cairo_14_semiBold
                                      .copyWith(color: appColors.grey5),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 6.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: widget.servicesRequirementsResponse
                                                .requestStatus ==
                                            2
                                        ? appColors.green
                                        : appColors.blue100.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  "مكتملة",
                                  style: TextStyles.cairo_14_semiBold
                                      .copyWith(color: appColors.grey5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                        const Text(
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
                              widget.servicesRequirementsResponse.description!,
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
                  verticalSpace(20.h),
                  Visibility(
                    visible: widget.servicesRequirementsResponse.replay != null,
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
                          Text(
                            "الرد على الخدمة",
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
                                    "الرد ",
                                    style: TextStyles.cairo_14_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                ],
                              ),
                              verticalSpace(10.w),
                              ReadMoreText(
                                widget.servicesRequirementsResponse.replay ??
                                    "",
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
                  verticalSpace(10.h),
                  Visibility(
                    visible: widget.servicesRequirementsResponse.file != null,
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
                                            link: widget
                                                .servicesRequirementsResponse
                                                .file!,
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
                  Visibility(
                    visible: widget.servicesRequirementsResponse.replay == null,
                    child: Container(
                      padding: EdgeInsets.all(20.0.sp),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0.sp, vertical: 20.h),
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
                            "الرد على الخدمة",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: appColors.grey15,
                            ),
                          ),
                          CustomTextFieldPrimary(
                              hintText: "اكتب الرد هنا",
                              validator: Validators.validateNotEmpty,
                              multiLine: true,
                              externalController: externalController,
                              title: "قم بالرد على الخدمة"),
                          verticalSpace(20.h),
                          ConditionalBuilder(
                            condition: widget.documentFile == null,
                            builder: (BuildContext context) => Animate(
                              effects: [FadeEffect(delay: 200.ms)],
                              child: GestureDetector(
                                onTap: () async => {
                                  hideKeyboard(navigatorKey.currentContext!),
                                  widget.documentFile = await context
                                      .read<OfficeProviderCubit>()
                                      .pickFile(),
                                  setState(() {})
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150.h,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: widget.documentFile != null
                                            ? appColors.blue100
                                            : appColors.grey3,
                                        borderRadius:
                                            BorderRadius.circular(12.sp),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppAssets.upload),
                                          verticalSpace(20.h),
                                          Text(
                                            widget.documentFile != null
                                                ? "تم إرفاق ملف"
                                                : "إرفاق ملف",
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              color: widget.documentFile != null
                                                  ? appColors.white
                                                  : appColors.blue100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Animate(
                                      effects: [FadeEffect(delay: 200.ms)],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // زاوية الحواف
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.check,
                                                  color: Colors.green),
                                              // علامة صح
                                              SizedBox(width: 8.0),
                                              // مسافة بين العلامة والنص
                                              Text("png, jpg, jpeg, pdf"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            fallback: (BuildContext context) =>
                                const SizedBox(),
                          ),
                          ConditionalBuilder(
                            condition: widget.documentFile != null,
                            builder: (BuildContext context) => Animate(
                              effects: [FadeEffect(delay: 200.ms)],
                              child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  leading: const Icon(
                                    Icons.file_copy,
                                    color: appColors.blue90,
                                  ),
                                  title: Text(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                    widget.documentFile!.path.split('/').last,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.black,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "حجم الملف: ${(widget.documentFile!.lengthSync() / 1024).toStringAsFixed(2)} KB",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: appColors.grey5,
                                        ),
                                      ),
                                      if (!widget.documentFile!.path
                                          .toLowerCase()
                                          .endsWith('.pdf'))
                                        Text(
                                          "اضغط للعرض",
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            color: appColors.grey5,
                                          ),
                                        ),
                                    ],
                                  ),
                                  onTap: () {
                                    if (widget.documentFile!.path
                                        .toLowerCase()
                                        .endsWith('.pdf')) {
                                    } else {
                                      viewImage(context, widget.documentFile!);
                                    }
                                  },
                                  trailing: GestureDetector(
                                    onTap: () {
                                      widget.documentFile = null;
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: appColors
                                            .red5, // Light red color for the circle background
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      // Adjust the padding as needed
                                      child: const Icon(
                                        Icons.delete,
                                        color: appColors.red,
                                      ),
                                    ),
                                  )),
                            ),
                            fallback: (BuildContext context) =>
                                const SizedBox(),
                          ),
                          CustomButton(
                              title: "ارسال الرد",
                              onPress: () {
                                if (externalController.text.isNotEmpty) {
                                  FormData formData = FormData.fromMap({
                                    "reply_content": externalController.text,
                                    "request_id":
                                        widget.servicesRequirementsResponse.id,
                                  });

                                  if (widget.documentFile != null) {
                                    formData.files.add(MapEntry(
                                        "files[0]",
                                        MultipartFile.fromFileSync(
                                            widget.documentFile!.path)));
                                  }
                                  getit<OfficeProviderCubit>()
                                      .replyServicesRequestFromClients(
                                          formData);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(50.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void viewImage(BuildContext context, File file) {}
}
