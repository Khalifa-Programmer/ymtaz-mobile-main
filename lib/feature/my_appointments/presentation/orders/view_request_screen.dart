import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/my_appointments/data/model/appointment_offers_client.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_cubit.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../core/widgets/webpay_new.dart';
import '../../../advisory_window/presentation/advisor_time_selection.dart';

class ViewAppointmentOfferScreen extends StatelessWidget {
  const ViewAppointmentOfferScreen(
      {super.key, required this.currentState, required this.offer});

  final String currentState;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildBlurredAppBar(
        context,
        'تفاصيل الطلب',
      ),
      body: BlocProvider.value(
        value: getit<AppointmentsCubit>(),
        child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
          listener: (context, state) {
            state.whenOrNull(
              respondToOffer: () {
                _showLoadingDialog(context);
              },
              respondToAppointmentOfferSuccess: (data) {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebPaymentScreen(
                              link: data.data!.paymentUrl!,
                            )));
              },
              requestServiceError: (error) {
                showSnackBar(context, error);
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
                        offer.reservationType!.name!),
                    _buildDetailRow(FontAwesomeIcons.dollar, "السعر",
                        "${offer.price ?? "لا يوجد عرض مقدم"} ريال"),
                    _buildDetailRow(Icons.label_important_outline_rounded,
                        "مستوى الطلب", offer.importance?.title ?? "مجاني"),
                    _buildDetailRow(Icons.calendar_month, "تاريخ الطلب",
                        getTimeDate(offer.createdAt.toString())),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "حالة الطلب للمحامي",
                        getOfferStatusText(offer.status!)),
                    _buildDetailRow(Icons.calendar_month, "يوم المقابلة",
                        getTimeDate(offer.day.toString())),
                    _buildDetailRow(Icons.calendar_month, "موعد المقابلة",
                        getTime(offer.from.toString())),
                  ]),
                  _buildDetailsContainer(context, "تفاصيل الطلب", [
                    const Text("الموضوع",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColors.grey15)),
                    Text(
                      offer.description!,
                      style: TextStyles.cairo_14_semiBold
                          .copyWith(color: appColors.blue100),
                    ),
                    if (offer.file != null) ...[
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
                  offer.status=='accepted'?
                  _buildDetailsContainer(context, "تفاصيل المقابلة", [
                    _buildDetailRow(Icons.calendar_month, "يوم المقابلة",
                        getTimeDate(offer.day.toString())),
                    _buildDetailRow(Icons.calendar_month, "موعد المقابلة",
                        getTime(offer.from.toString())),
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
                                  openMap(offer.latitude!, offer.longitude!);
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
                                child: Text("عرض رمز الحضور",
                                    style: TextStyles.cairo_12_bold
                                        .copyWith(color: appColors.white)),
                                onPressed: () {
                                  _viewAttendCodeDialog(context, "X17HO3");
                                }),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                  ]) : const SizedBox(),
                  _buildDetailsContainer(context, "بيانات المحامي", [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15.r,
                          backgroundImage: NetworkImage(
                              offer.lawyerId!.image == null
                                  ? 'https://api.ymtaz.sa/uploads/person.png'
                                  : offer.lawyerId!.image!),
                        ),
                        horizontalSpace(10.w),
                        Text(
                          offer.lawyerId!.name!,
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                    verticalSpace(10.h),
                    offer.status! == "pending-acceptance"
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
        const Text("السعر المرسل من المحامي",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: appColors.grey15)),
        verticalSpace(10.h),
        Row(
          children: [
            Text("${offer.price} ريال",
                style: TextStyles.cairo_16_bold
                    .copyWith(color: appColors.blue100)),
          ],
        ),
        verticalSpace(10.h),
        const Text("الموقع المقترح للمقابلة من قبل المحامي",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: appColors.grey15)),
        verticalSpace(10.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 35.h,
                child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    color: appColors.blue90,
                    child: Text("عرض مكان المقابله",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.white)),
                    onPressed: () {
                      openMap(offer.latitude!, offer.longitude!);
                    }),
              ),
            ),
          ],
        ),
        verticalSpace(20.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 35.h,
                child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    color: appColors.green,
                    child: Text("قبول العرض",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.white)),
                    onPressed: () {
                      FormData data = FormData.fromMap({
                        "offer_id": offer.id,
                        "action": "accept",
                      });
                      getit<AppointmentsCubit>()
                          .respondToAppointmentOffer(data);
                    }),
              ),
            ),
            horizontalSpace(10.w),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 35.h,
                child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    color: appColors.red5.withOpacity(0.4),
                    child: Text("رفض العرض",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.red)),
                    onPressed: () {
                      FormData data = FormData.fromMap({
                        "offer_id": offer.id,
                        "action": "decline",
                      });
                      getit<AppointmentsCubit>()
                          .respondToAppointmentOffer(data);
                    }),
              ),
            ),
          ],
        )
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
    var file = offer.file;
    return InkWell(
      onTap: () => _openFileInBrowser(file.toString()),
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

  void _openFileInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
                horizontalSpace(16.sp),
                const Text("جاري إرسال الرد على العرض"),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _viewAttendCodeDialog(BuildContext context, String code) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("كود الحضور"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("كود الحضور هو "),
              Text(
                textDirection: TextDirection.ltr,
                  "${code[0]} ${code[1]} ${code[2]} ${code[3]} ${code[4]} ${code[5]}",
                  style: TextStyles.cairo_20_bold),
              verticalSpace(20.h),
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
                          child: Text("نسخ الكود",
                              style: TextStyles.cairo_12_bold
                                  .copyWith(color: appColors.white)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
