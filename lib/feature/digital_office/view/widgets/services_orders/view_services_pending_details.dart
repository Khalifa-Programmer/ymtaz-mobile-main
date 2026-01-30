import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/services_orders/offer_bottom_sheet.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../data/models/service_lawyer_offres_response.dart';

class ServiceScreenPendingDetailsClient extends StatefulWidget {
  ServiceScreenPendingDetailsClient({super.key, required this.offer});

  final Declined offer;
  File? documentFile;

  @override
  State<ServiceScreenPendingDetailsClient> createState() =>
      _ServiceScreenSetailsClientState();
}

class _ServiceScreenSetailsClientState
    extends State<ServiceScreenPendingDetailsClient> {
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
                //   respondToOffer: (){
                //     _showLoadingDialog(context);
                //   },
                //   respondToOfferSuccess: (data){
                //     Navigator.of(context).pop();
                //
                //     getit<ServicesCubit>().getServicesDataFirst();
                //     Navigator.of(context).pop();
                //
                //
                //   },
                //   requestServiceError: (error){
                //     showSnackBar(context, error);
                //   },
                );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  verticalSpace(110.h),
                  _buildDetailsContainer(context, "تفاصيل الخدمة", [
                    _buildDetailRow(FontAwesomeIcons.ticket, "نوع الخدمة",
                        widget.offer.service!.title!),
                    _buildDetailRow(FontAwesomeIcons.dollar, "السعر",
                        "${widget.offer.price ?? "لا يوجد عرض مقدم"} ريال"),
                    _buildDetailRow(Icons.label_important_outline_rounded,
                        "مستوى الطلب", widget.offer.priority?.title ?? "مجاني"),
                    _buildDetailRow(Icons.calendar_month, "تاريخ الطلب",
                        getTimeDate(widget.offer.createdAt.toString())),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "حالة الطلب ",
                        getOfferStatusText(widget.offer.status!)),
                  ]),
                  _buildDetailsContainer(context, "تفاصيل طلب مقدم الخدمة", [
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
                    if (widget.offer.files!.isNotEmpty) ...[
                      verticalSpace(20.w),
                      const Text("المرفقات",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: appColors.grey15)),
                      verticalSpace(10.h),
                      _buildFilesList(context),
                      _buildAudioFilesList(context),
                    ],
                  ]),
                  _buildDetailsContainer(context, "بيانات طالب الخدمة", [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15.r,
                          backgroundImage: NetworkImage(
                              widget.offer.account?.image == null
                                  ? 'https://api.ymtaz.sa/uploads/person.png'
                                  : widget.offer.account!.image!),
                        ),
                        horizontalSpace(10.w),
                        Text(
                          widget.offer.account?.name?? " ",
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                    verticalSpace(10.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: getOfferStatusColor(widget.offer.status!)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Center(
                        child: Text(getOfferStatusText(widget.offer.status!),
                            style: TextStyles.cairo_12_bold.copyWith(
                              color: getOfferStatusColor(widget.offer.status!),
                            )),
                      ),
                    ),
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
        const Text("قم بتقديم سعر لطالب الخدمة",
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
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.offer.files!.length,
      itemBuilder: (context, index) {
        final file = widget.offer.files![index];
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
      },
      separatorBuilder: (BuildContext context, int index) =>
          verticalSpace(10.h),
    );
  }

  Widget _buildAudioFilesList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.offer.files!.length,
      itemBuilder: (context, index) {
        final file = widget.offer.files![index];
        if (file.isVoice == 1 && file.isReply == 0) {
          return Column(
            children: [
              _buildAudioWave(file.file.toString(), context),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void _openFileInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildAudioWave(String url, BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    Duration duration = Duration.zero;
    Duration position0 = Duration.zero;

    audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      position0 = p;
    });

    return Column(
      children: [
        StreamBuilder<Duration>(
          stream: audioPlayer.onPositionChanged,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            return Container(
              decoration: BoxDecoration(
                color: appColors.lightYellow10,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: appColors.primaryColorYellow),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAudioControls(audioPlayer, url),
                  _buildSlider(position, duration, audioPlayer),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAudioControls(AudioPlayer audioPlayer, String url) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () async {
            try {
              await audioPlayer.play(UrlSource(url));
            } catch (e) {
              debugPrint('Error playing audio: $e');
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          onPressed: () {
            audioPlayer.stop();
          },
        ),
      ],
    );
  }

  Widget _buildSlider(
      Duration position, Duration duration, AudioPlayer audioPlayer) {
    return Column(
      children: [
        Slider(
          value: position.inSeconds.toDouble(),
          max: duration.inSeconds.toDouble(),
          onChanged: (value) async {
            final newPosition = Duration(seconds: value.toInt());
            await audioPlayer.seek(newPosition);
          },
          activeColor: appColors.primaryColorYellow,
          inactiveColor: appColors.grey15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDuration(position)),
            Text(_formatDuration(duration)),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
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
        return OfferBottomSheet(
          id: id,
        );
      },
    );
  }
}
