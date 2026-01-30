import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/recorder_player_widget.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/alerts.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/primary/text_form_primary.dart';
import '../../../core/widgets/spacing.dart';
import '../logic/ymtaz_elite_cubit.dart';
import 'elite_request_success_screen.dart';

class EliteRequestScreen extends StatefulWidget {
  EliteRequestScreen({super.key});

  @override
  State<EliteRequestScreen> createState() => _EliteRequestScreenState();
}

class _EliteRequestScreenState extends State<EliteRequestScreen> {
  final TextEditingController externalController = TextEditingController();
  List<PlatformFile> _files = [];

  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();

  String? recordingPath;

  Future<void> _pickFiles() async {
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

  void _onRecordingComplete(String? path) {
    setState(() {
      recordingPath = path;
    });
  }

  void _validateAndSubmit() async {
    if (externalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب كتابة تفاصيل الطلب')),
      );
      return;
    }

    final eliteCubit = BlocProvider.of<YmtazEliteCubit>(context);
    if (eliteCubit.selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب اختيار نوع الخدمة')),
      );
      return;
    }

    final formData = FormData.fromMap({
      "elite_service_category_id": eliteCubit.selectedCategoryId.toString(),
      "description": externalController.text,
    });

    // Add files if any
    for (var i = 0; i < _files.length; i++) {
      final file = _files[i];
      formData.files.add(MapEntry(
        'files[$i][file]',
        await MultipartFile.fromFile(file.path!),
      ));
      formData.fields.add(MapEntry('files[$i][is_voice]', 'false'));
    }

    // Add voice recording if exists
    if (recordingPath != null) {
      formData.files.add(MapEntry(
        'files[${_files.length}][file]',
        await MultipartFile.fromFile(recordingPath!),
      ));
      formData.fields.add(MapEntry(
        'files[${_files.length}][is_voice]',
        'true',
      ));
    }

    await eliteCubit.sendEliteRequest(formData);
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteRequestLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
        } else if (state is YmtazEliteRequestSuccess) {
          Navigator.pop(context);
          context.pushNamedAndRemoveUntil(Routes.homeLayout,
              predicate: (route) => false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EliteRequestSuccessScreen(
                request: state.request,
              ),
            ),
          );
        } else if (state is YmtazEliteRequestError) {
          Navigator.pop(context); // Dismiss loading dialog
          AppAlerts.showAlert(
            context: context,
            message: state.message,
            buttonText: 'حسناً',
            type: AlertType.error,
          );
        }
      },
      child: Scaffold(
        appBar: buildBlurredAppBar(context, "تفاصيل الطلب"),
        body: Animate(
          effects: [FadeEffect(duration: 500.ms)],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تفاصيل طلبك",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "تفاصيل طلبك للحصول على خدمة دقيقة",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(20.h),
                  // Text("مستوى الطلب ", style: TextStyles.cairo_12_bold),
                  // CustomCheckSelectLevel(
                  //   items: selectedAccurateData.levels!,
                  //   onChanged: (item) {
                  //     advisoryCubit.selectedLevel = item;
                  //   },
                  // ),
                  Text("تفاصيل الطلب", style: TextStyles.cairo_12_bold),
                  CustomTextFieldPrimary(
                    hintText: "تفاصيل الطلب",
                    multiLine: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "الموضوع مطلوب";
                      }
                      return null;
                    },
                    externalController: externalController,
                    title: "اكتب تفاصيل الطلب",
                  ),
                  if (_files.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الملفات المرفقة (إختياري)",
                            style: TextStyles.cairo_12_bold),
                        verticalSpace(10.h),
                        GestureDetector(
                          onTap: _pickFiles,
                          child: Container(
                            width: double.infinity,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: appColors.lightYellow10,
                              border: Border.all(
                                  color: appColors.primaryColorYellow),
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
                            border:
                                Border.all(color: appColors.primaryColorYellow),
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
                                      style: TextStyles.cairo_12_bold.copyWith(
                                          color: appColors.primaryColorYellow),
                                    ),
                                    onPressed: () {
                                      _pickFiles();
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  verticalSpace(20.h),
                  RecorderPlayerWidget(
                    onRecordingComplete: _onRecordingComplete,
                    recorderController: _recorderController,
                    playerController: _playerController,
                  ), // Use the custom component
                  verticalSpace(20.h),
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: appColors.primaryColorYellow,
                        onPressed: _validateAndSubmit,
                        child: Text(
                          "التالي",
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.white),
                        )),
                  ),
                  verticalSpace(50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
