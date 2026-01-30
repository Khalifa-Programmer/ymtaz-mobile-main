import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/validators.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/primary/text_form_primary.dart';
import '../../../advisory_window/presentation/call_screen.dart';
import '../../data/models/lawyer_advisory_requests_responnse.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';

class ViewAdvisoryDetails extends StatefulWidget {
  ViewAdvisoryDetails({super.key, required this.servicesRequirementsResponse});

  final Reservation servicesRequirementsResponse;

  @override
  State<ViewAdvisoryDetails> createState() => _ViewAdvisoryDetailsState();
}

class _ViewAdvisoryDetailsState extends State<ViewAdvisoryDetails> {
  final TextEditingController externalController = TextEditingController();

  List<PlatformFile> _files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل الاستشارة',
            style: TextStyles.cairo_14_bold.copyWith(color: appColors.black)),
      ),
      body: BlocProvider.value(
        value: getit<OfficeProviderCubit>(),
        child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listener: (context, state) {
            state.whenOrNull(
              loadedServicesReplyFromClients: (value) {
                context.pop();
                context.pop();
                AppAlerts.showAlert(
                    context: context,
                    message: value.message!,
                    buttonText: "استمرار",
                    type: AlertType.success);
              },
              loadingServicesReplyFromClients: () {
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
                            const CircularProgressIndicator(
                                color: appColors.primaryColorYellow),
                            horizontalSpace(16.sp),
                            const Text("جاري الرد على الخدمة"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              errorServicesReplyFromClients: (value) {
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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildDetailsContainer(context, "تفاصيل الاستشارة", [
                    _buildDetailRow(
                        FontAwesomeIcons.ticket,
                        "نوع الاستشارة",
                        widget.servicesRequirementsResponse.advisoryServicesSub!
                            .name!),
                    _buildDetailRow(
                        Icons.label_important,
                        "التخصص العام",
                        widget.servicesRequirementsResponse.advisoryServicesSub!
                            .generalCategory!.name!),
                    _buildDetailRow(
                        CupertinoIcons.video_camera_solid,
                        "نوع الوسيلة",
                        widget.servicesRequirementsResponse.advisoryServicesSub!
                            .generalCategory!.paymentCategoryType!.name!),
                    _buildDetailRow(FontAwesomeIcons.dollar, "السعر",
                        "${widget.servicesRequirementsResponse.price ?? 0} ريال"),
                    _buildDetailRow(
                        Icons.label_important_outline_rounded,
                        "مستوى الطلب",
                        widget.servicesRequirementsResponse.importance?.title ??
                            "مجاني"),
                    _buildDetailRow(
                        Icons.calendar_month,
                        "تاريخ الطلب",
                        getTimeDate(widget
                            .servicesRequirementsResponse.createdAt
                            .toString())),
                  ]),
                  _buildDetailsContainer(context, "تفاصيل الطلب", [
                    const Text("الموضوع",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColors.grey15)),
                    Text(
                      widget.servicesRequirementsResponse.description!,
                      // trimCollapsedText: 'عرض ا��مزيد',
                      // trimExpandedText: 'عرض اقل',
                      // moreStyle: TextStyles.cairo_14_bold
                      //     .copyWith(color: appColors.black),
                      style: TextStyles.cairo_14_semiBold
                          .copyWith(color: appColors.blue100),
                    ),
                    if (widget
                        .servicesRequirementsResponse.files!.isNotEmpty) ...[
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
                  _buildCallDetails(context),
                  _buildReplySection(context),
                  verticalSpace(50.h),
                ],
              ),
            );
          },
        ),
      ),
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
      itemCount: widget.servicesRequirementsResponse.files!.length,
      itemBuilder: (context, index) {
        final file = widget.servicesRequirementsResponse.files![index];
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
      itemCount: widget.servicesRequirementsResponse.files!.length,
      itemBuilder: (context, index) {
        final file = widget.servicesRequirementsResponse.files![index];
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

  Widget _buildCallDetails(BuildContext context) {
    return ConditionalBuilder(
      condition: widget.servicesRequirementsResponse.callId != null,
      builder: (context) => _buildDetailsContainer(context, "يوم الاستشارة", [
        _buildDetailRow(Icons.calendar_month, "يوم الاستشارة",
            getDate(widget.servicesRequirementsResponse.from!)),
        _buildDetailRow(Icons.timelapse, "وقت  بدء المكالمة",
            getTime(widget.servicesRequirementsResponse.from!)),
        _buildDetailRow(CupertinoIcons.time, "مدة الاستشارة",
            getTime(widget.servicesRequirementsResponse.from!)),
        verticalSpace(20.h),
        CustomButton(
          onPress: () async {
            try {
              var userType = CacheHelper.getData(key: 'userType');
              if (userType == 'client') {
                StreamVideo.reset();
                StreamVideo(
                  'd3cgunkh7jrg',
                  user: User.regular(
                      userId: getit<MyAccountCubit>()
                          .clientProfile!
                          .data!
                          .account!
                          .streamioId
                          .toString(),
                      name: getit<MyAccountCubit>()
                          .clientProfile!
                          .data!
                          .account!
                          .name),
                  userToken: getit<MyAccountCubit>()
                      .clientProfile!
                      .data!
                      .account!
                      .streamioToken,
                );
              } else {
                StreamVideo.reset();
                StreamVideo(
                  'd3cgunkh7jrg',
                  user: User.regular(
                      userId: getit<MyAccountCubit>()
                          .userDataResponse!
                          .data!
                          .account!
                          .streamioId
                          .toString(),
                      name: getit<MyAccountCubit>()
                          .userDataResponse!
                          .data!
                          .account!
                          .name),
                  userToken: getit<MyAccountCubit>()
                      .userDataResponse!
                      .data!
                      .account!
                      .streamioToken,
                );
              }

              var call = StreamVideo.instance.makeCall(
                callType: StreamCallType.custom("default"),
                id: widget.servicesRequirementsResponse.callId!,
              );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CallScreen(call: call),
                ),
              );

              await call.getOrCreate();
            } catch (e) {
              debugPrint('Error joining or creating call: $e');
              debugPrint(e.toString());
            }
          },
          title: 'بدء المكالمة',
          height: 35.h,
          fontSize: 12.sp,
        ),
      ]),
      fallback: (context) => const SizedBox(),
    );
  }

  Widget _buildReplySection(BuildContext context) {
    return Visibility(
      visible: widget.servicesRequirementsResponse.replySubject != null,
      replacement: _buildDetailsContainer(context, "الرد على الخدمة", [
        Text(
            "يمكنك الرد علىهذه الاستشارة عن طريق كتابة الرد هنا و إضافة مرفقات للرد , اذا كانت الاستشارة مرئية فالرد المكتوب يكون وسيلة لاضافة رد او ملخص حول موضوع الاستشارة",
            style:
                TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey5)),
        verticalSpace(10.h),
        CustomTextFieldPrimary(
          hintText: "اكتب الرد هنا",
          validator: Validators.validateNotEmpty,
          multiLine: true,
          externalController: externalController,
          title: "الرد على الاستشارة",
        ),
        verticalSpace(20.h),
        if (_files.isEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("الملفات المرفقة (إختياري)",
                  style: TextStyles.cairo_12_bold),
              verticalSpace(10.h),
              GestureDetector(
                onTap: () {
                  _pickFiles(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: appColors.lightYellow10,
                    border: Border.all(color: appColors.primaryColorYellow),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.upload,
                        width: 24.sp,
                        height: 24.sp,
                        color: appColors.primaryColorYellow,
                      ),
                      SizedBox(width: 10.w),
                      Text("ارفق ملف أو صورة",
                          style: TextStyles.cairo_12_semiBold),
                    ],
                  )),
                ),
              ),
            ],
          ),
        verticalSpace(10.h),
        if (_files.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("الملفات المرفقة (إختياري)",
                  style: TextStyles.cairo_12_bold),
              verticalSpace(10.h),
              Container(
                padding: EdgeInsets.all(10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appColors.primaryColorYellow),
                ),
                child: Column(
                  children: [
                    ..._files.map((file) {
                      int index = _files.indexOf(file);
                      return _buildFileListItem(file, index);
                    }).toList(),
                    Container(
                      color: appColors.white,
                      width: double.infinity,
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            "اضافة المزيد",
                            style: TextStyles.cairo_12_bold
                                .copyWith(color: appColors.primaryColorYellow),
                          ),
                          onPressed: () {
                            _pickFiles(context);
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        verticalSpace(20.h),
        CustomButton(
          title: "ارسال الرد",
          onPress: () async {
            if (externalController.text.isNotEmpty) {
              FormData formData = FormData.fromMap({
                "reply_subject": externalController.text,
                "reply_content": externalController.text,
                "id": widget.servicesRequirementsResponse.id,
                if (_files.isNotEmpty)
                  for (int i = 0; i < _files.length; i++)
                    "files[i]": await MultipartFile.fromFile(_files[i].path!),
              });

              getit<OfficeProviderCubit>()
                  .replyAdvisoryRequestFromClients(formData);
            }
          },
        ),
      ]),
      child: _buildDetailsContainer(context, "الرد على الخدمة", [
        Row(
          children: [
            Icon(Icons.description,
                color: appColors.primaryColorYellow, size: 20.sp),
            Text("الرد ",
                style: TextStyles.cairo_14_semiBold
                    .copyWith(color: appColors.grey5)),
          ],
        ),
        verticalSpace(10.w),
        ReadMoreText(
          widget.servicesRequirementsResponse.replyContent ?? "",
          trimCollapsedText: 'عرض المزيد',
          trimExpandedText: 'عرض اقل',
          moreStyle: TextStyles.cairo_14_bold.copyWith(color: appColors.black),
          style:
              TextStyles.cairo_14_semiBold.copyWith(color: appColors.blue100),
        ),
      ]),
    );
  }

  Future<void> _pickFiles(context) async {
    if (_files.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يمكنك إرفاق حتى 5 ملفات فقط')),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _files.addAll(result.files.take(5 - _files.length));
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  String getStatusText(int requestStatus) {
    Map<int, String> statusTextMap = {
      0: 'قيد الانتظار',
      1: 'قيد الدراسة',
      2: 'مكتملة',
    };
    return statusTextMap[requestStatus] ?? 'حالة غير معروفة';
  }

  void _openFileInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildFileListItem(PlatformFile file, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: appColors.grey5.withOpacity(0.5)),
        ),
        leading:
            Icon(file.extension == 'pdf' ? Icons.picture_as_pdf : Icons.image),
        title: Text(
          file.name,
          style: TextStyles.cairo_12_semiBold,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: IconButton(
          icon: Icon(CupertinoIcons.xmark),
          onPressed: () => _removeFile(index),
        ),
      ),
    );
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
}
