import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/data/models/appointment_office_reservations_client.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/appointments_orders/attend_bottom_sheet.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../../core/widgets/app_bar.dart';

class AppointmentScreenSetailsClient extends StatefulWidget {
  AppointmentScreenSetailsClient({super.key, required this.offer});

  final Reservation offer;
  File? documentFile;

  @override
  State<AppointmentScreenSetailsClient> createState() =>
      _AppointmentScreenSetailsClientState();
}

class _AppointmentScreenSetailsClientState
    extends State<AppointmentScreenSetailsClient> {
  final TextEditingController externalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // يمنع التأثير على الحجم

      extendBodyBehindAppBar: true,
      appBar: buildBlurredAppBar(
        context,
        'تفاصيل الطلب',
      ),
      body: BlocProvider.value(
        value: getit<OfficeProviderCubit>(),
        child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listener: (context, state) {
            state.whenOrNull(
              loadedAppointmentOfferSend: (data) {
                Navigator.pop(context);
                Navigator.pop(context);
                getit<OfficeProviderCubit>().loadAppoinemtns();
                AppAlerts.showAlert(
                    context: context,
                    message: "تم ارسال العرض بنجاح",
                    buttonText: "موافق",
                    type: AlertType.success);
              },
              errorAppointmentOfferSend: (message) {
                AppAlerts.showAlert(
                    context: context,
                    message: message,
                    buttonText: "اعادة المحاولة",
                    type: AlertType.error);
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  verticalSpace(110.h),
                  _buildDetailsContainer(context, "تفاصيل الموعد", [
                    _buildDetailRow(FontAwesomeIcons.ticket, "نوع الموعد",
                        widget.offer.reservationType!.name!),
                    _buildDetailRow(FontAwesomeIcons.dollar, "السعر",
                        "${widget.offer.price ?? "لا يوجد عرض مقدم"} ريال"),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "مستوى الطلب",
                        widget.offer.reservationImportance?.title ?? "مجاني"),
                    _buildDetailRow(Icons.calendar_month, "تاريخ الطلب",
                        getTimeDate(widget.offer.createdAt.toString())),
                  ]),
                  _buildDetailsContainer(context, "تفاصيل طلب مقدم الموعد", [
                    const Text("موعد طالب الخدمة",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColors.grey15)),
                    verticalSpace(5.h),
                    const Text("الموضوع",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColors.grey15)),
                    Text(
                      widget.offer.description!,
                      style: TextStyles.cairo_14_semiBold
                          .copyWith(color: appColors.blue100),
                    ),
                    if (widget.offer.file != null) ...[
                      verticalSpace(20.w),
                      const Text("المرفقات",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: appColors.grey15)),
                      verticalSpace(10.h),
                      _buildFilesList(context),
                    ],
                  ]),
                  _buildDetailsContainer(context, "تفاصيل المقابلة", [
                    _buildDetailRow(Icons.calendar_month, "يوم المقابلة",
                        getTimeDate(widget.offer.date.toString())),
                    _buildDetailRow(Icons.calendar_month, "موعد المقابلة",
                        getTime(widget.offer.from.toString())),
                    _buildDetailRow(Icons.calendar_month, "مدة المقابلة",
                        widget.offer.hours.toString()),
                    verticalSpace(10.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 35.h,
                            child: CupertinoButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                color: appColors.blue90,
                                child: Text("عرض مكان المقابله",
                                    style: TextStyles.cairo_12_bold
                                        .copyWith(color: appColors.white)),
                                onPressed: () {
                                  openMap(widget.offer.latitude!,
                                      widget.offer.longitude!);
                                }),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 35.h,
                            child: CupertinoButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                color: appColors.blue90,
                                child: Text("تسجيل حضور",
                                    style: TextStyles.cairo_12_bold
                                        .copyWith(color: appColors.white)),
                                onPressed: () {
                                  _showOfferPriceBottomSheet(
                                      context, widget.offer.id.toString());
                                }),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                  ]),
                  _buildDetailsContainer(context, "بيانات طالب الموعد", [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15.r,
                          backgroundImage: NetworkImage(
                              widget.offer.account!.image == null
                                  ? 'https://api.ymtaz.sa/uploads/person.png'
                                  : widget.offer.account!.image!),
                        ),
                        horizontalSpace(10.w),
                        Text(
                          widget.offer.account!.name!,
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                  ]),
                  verticalSpace(50.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showOfferPriceBottomSheet(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      // Set to true for full-height bottom sheet
      builder: (BuildContext context) {
        return AppointmetnsAttendBottomSheet(
          id: id,
        );
      },
    );
  }

  // build widget to enter attend code in bootom app sheet
  Widget _buildEnterCode() {
    return Container(
      width: 180.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: appColors.blue90,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ادخل كود الحضور",
              style: TextStyles.cairo_12_bold.copyWith(color: appColors.white)),
          horizontalSpace(10.w),
          Icon(Icons.arrow_forward_ios, color: appColors.white, size: 20.sp),
        ],
      ),
    );
  }

  // build widget to enter attend code in bottom app sheet

  Widget _buildDetailsContainer(
      BuildContext context, String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.0.sp),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 17.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appColors.white,
        border: Border.all(color: appColors.grey2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(3, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.grey15)),
          verticalSpace(20.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: appColors.primaryColorYellow, size: 20.sp),
            horizontalSpace(10.w),
            Text(label,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.grey15)),
            const Spacer(),
            Text(value,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.blue100)),
          ],
        ),
        verticalSpace(20.h),
      ],
    );
  }

  Widget _buildFilesList(BuildContext context) {
    var file = widget.offer.file;
    if (file.isReply == 0 && file.isVoice == 0) {
      return InkWell(
        onTap: () => _openFileInBrowser(file.file.toString()),
        child: Row(
          children: [
            Icon(Icons.attach_file,
                color: appColors.primaryColorYellow, size: 20.sp),
            horizontalSpace(10.w),
            Text("اضغط للمشاهدة",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.blue100)),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  void _openFileInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
