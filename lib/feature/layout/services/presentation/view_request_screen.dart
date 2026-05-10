import 'package:audioplayers/audioplayers.dart';
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
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../core/widgets/moyasar_payment_screen.dart';
import '../../../../core/widgets/webpay_new.dart';
import '../../../../core/widgets/new_payment_success.dart';
import '../../../advisory_window/presentation/advisor_time_selection.dart';
import '../../../digital_guide/presentation/digetal_providers_screen.dart';
import '../logic/services_cubit.dart';
import '../../../../core/helpers/file_helper.dart';
import '../../../../core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_clients_response.dart' as digital_office;
import 'package:yamtaz/feature/digital_office/view/client_profile_screen.dart';

class ViewOfferScreen extends StatelessWidget {
  const ViewOfferScreen(
      {super.key, required this.currentState, required this.offer});

  final String currentState;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final userType = CacheHelper.getData(key: 'userType');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildBlurredAppBar(
        context,
        'تفاصيل الطلب',
      ),
      body: BlocProvider.value(
        value: getit<ServicesCubit>(),
        child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {
            state.whenOrNull(
              respondToOffer: () {
                _showLoadingDialog(context);
              },
              respondToOfferSuccess: (data) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoyasarPaymentScreen(
                              amount: data.data!.serviceRequest!.price ?? "0",
                              description: "دفع عرض خدمة ${data.data!.serviceRequest!.description ?? ''}",
                              transactionId: data.data!.transactionId,
                              metadata: {
                                'service_request_id': data.data!.serviceRequest!.id!.toString(),
                                'type': 'service_offer',
                              },
                            ))).then((result) {
                  if (result == 'success' && context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewSuccessPayment()),
                      (route) => false,
                    );
                  }
                });
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
                  _buildBreadcrumbSection(offer),
                  _buildDetailsContainer(context, "تفاصيل الخدمة", [
                    _buildDetailRow(Icons.confirmation_number_outlined, "نوع الخدمة",
                        offer.service!.title!),
                    _buildDetailRow(Icons.attach_money, "السعر",
                        "${offer.price ?? "لا يوجد عرض مقدم"} ريال"),
                    _buildDetailRow(Icons.label_important_outline_rounded,
                        "مستوى الطلب", offer.priority?.title ?? "مجاني"),
                    _buildDetailRow(Icons.calendar_month, "تاريخ الطلب",
                        getTimeDate(offer.createdAt.toString())),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "حالة الطلب للمحامي",
                        getOfferStatusText(offer.status!)),
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
                    if (offer.files!.isNotEmpty) ...[
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
                  _buildDetailsContainer(context, 
                      userType == 'provider' ? "بيانات العميل" : "بيانات المحامي", [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage: NetworkImage(FileHelper.resolveUrl(
                                  (userType == 'provider' ? offer.account?.image : offer.lawyer?.image) == null
                                      ? 'https://ymtaz.sa/uploads/person.png'
                                      : (userType == 'provider' ? offer.account!.image! : offer.lawyer!.image!))),
                            ),
                            horizontalSpace(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (userType == 'provider' ? offer.account?.name : offer.lawyer?.name) ?? "",
                                    style: TextStyles.cairo_14_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                  Text(
                                    userType == 'provider' ? "عميل" : "محامي",
                                    style: TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(16.h),
                        SizedBox(
                          width: double.infinity,
                          height: 35.h,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: appColors.blue90,
                            onPressed: () {
                              if (userType == 'provider') {
                                if (offer.account != null) {
                                  final client = digital_office.Client(
                                    id: offer.account!.id?.toString(),
                                    name: offer.account!.name,
                                    image: offer.account!.image,
                                    gender: offer.account!.gender,
                                    currentLevel: offer.account!.currentLevel,
                                    city: offer.account!.city != null ? digital_office.AccurateSpecialty(id: offer.account!.city!.id, title: offer.account!.city!.title) : null,
                                    country: offer.account!.country != null ? digital_office.Country(id: offer.account!.country!.id, name: offer.account!.country!.name) : null,
                                    region: offer.account!.region != null ? digital_office.Country(id: offer.account!.region!.id, name: offer.account!.region!.name) : null,
                                    nationality: offer.account!.nationality != null ? digital_office.Country(id: offer.account!.nationality!.id, name: offer.account!.nationality!.name) : null,
                                    currentRank: offer.account!.currentRank != null ? digital_office.CurrentRank(id: offer.account!.currentRank!.id, name: offer.account!.currentRank!.name, image: offer.account!.currentRank!.image) : null,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClientProfileScreen(client: client),
                                    ),
                                  );
                                }
                              } else {
                                if (offer.lawyer?.id != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DigitalProvidersScreen(
                                        idLawyer: offer.lawyer!.id!.toString(),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              "عرض",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildBreadcrumbSection(Offer offer) {
    final parts = <String>[];
    if (offer.priority?.title != null && offer.priority!.title!.isNotEmpty) {
      parts.add(offer.priority!.title!);
    }
    if (offer.service?.title != null && offer.service!.title!.isNotEmpty) {
      parts.add(offer.service!.title!);
    }

    if (parts.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: appColors.primaryColorYellow.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: appColors.primaryColorYellow.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.route_rounded,
                size: 16.sp,
                color: appColors.primaryColorYellow,
              ),
              horizontalSpace(8.w),
              Text(
                "مسار النوع المختار",
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.blue100,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          verticalSpace(8.h),
          Wrap(
            spacing: 4.w,
            runSpacing: 4.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(parts.length * 2 - 1, (i) {
              if (i.isOdd) {
                return Icon(
                  Icons.arrow_back_ios,
                  size: 10.sp,
                  color: appColors.grey15,
                );
              }
              final index = i ~/ 2;
              return Text(
                parts[index],
                style: TextStyles.cairo_14_semiBold.copyWith(
                  color: index == parts.length - 1
                      ? appColors.primaryColorYellow
                      : appColors.blue100,
                  fontSize: 12.sp,
                ),
              );
            }),
          ),
        ],
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
                    child: Text("قبول ودفع الطلب",
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.white)),
                    onPressed: () {
                      FormData data = FormData.fromMap({
                        "offer_id": offer.id,
                        "action": "accept",
                      });
                      getit<ServicesCubit>()
                          .myServicesClientOffersRespond(data);
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
                      getit<ServicesCubit>()
                          .myServicesClientOffersRespond(data);
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
      itemCount: offer.files!.length,
      itemBuilder: (context, index) {
        final file = offer.files![index];
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
      itemCount: offer.files!.length,
      itemBuilder: (context, index) {
        final file = offer.files![index];
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
                  Expanded(child: _buildSlider(position, duration, audioPlayer)),
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
}
