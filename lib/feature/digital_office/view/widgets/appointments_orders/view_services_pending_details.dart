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
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../data/models/appointment_offers_lawyer.dart';
import 'offer_bottom_sheet.dart';

class AppointmetnsPendingDetailsClientScrenn extends StatefulWidget {
  AppointmetnsPendingDetailsClientScrenn({super.key, required this.offer});

  final Offer offer;
  File? documentFile;

  @override
  State<AppointmetnsPendingDetailsClientScrenn> createState() =>
      _ServiceScreenSetailsClientState();
}

class _ServiceScreenSetailsClientState
    extends State<AppointmetnsPendingDetailsClientScrenn> {
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
                        widget.offer.importance?.title ?? "مجاني"),
                    _buildDetailRow(Icons.calendar_month, "تاريخ الطلب",
                        getTimeDate(widget.offer.createdAt.toString())),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "حالة الطلب ",
                        getOfferStatusText(widget.offer.status!)),
                  ]),
                  _buildDetailsContainer(context, "تفاصيل طلب مقدم الموعد", [
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
                  _buildDetailsContainer(context, "بيانات طالب الموعد", [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15.r,
                          backgroundImage: NetworkImage(
                              widget.offer.accountId!.image == null
                                  ? 'https://api.ymtaz.sa/uploads/person.png'
                                  : widget.offer.accountId!.image!),
                        ),
                        horizontalSpace(10.w),
                        Text(
                          widget.offer.accountId!.name!,
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                    verticalSpace(10.h),
                    widget.offer.status! == "pending-offer"
                        ? _buildOfferContainer(context)
                        : const SizedBox(),
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

  Widget _buildOfferContainer(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("قم بتقديم سعر لطالب الموعد",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: appColors.blue100)),
        verticalSpace(5.h),
        const Text("ملحوظة : لا يمكنك تغيير السعر بعد الإرسال",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: appColors.grey15)),
        verticalSpace(10.h),
        verticalSpace(10.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 35.h,
                child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    color: appColors.green,
                    child: Text("تقديم عرض",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.white)),
                    onPressed: () {
                      _showOfferPriceBottomSheet(
                          context, widget.offer.id.toString());
                    }),
              ),
            ),
            horizontalSpace(10.w),
            Expanded(
              flex: 2,
              child: Container(
                height: 35.h,
                child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    color: appColors.red5.withOpacity(0.4),
                    child: Text("رفض الطلب",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.red)),
                    onPressed: () {
                      _showOfferPriceBottomSheet(
                          context, widget.offer.id.toString());
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

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
        return AppointmetnsOfferBottomSheet(
          id: id,
        );
      },
    );
  }
}
