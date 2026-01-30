import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/feature/advisory_window/presentation/widgets/selections_level.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../../../recorder_player_widget.dart';
import '../logic/advisory_cubit.dart';

enum RecordingState { idle, recording, recorded }

class AdvisoryRequestDetailsScreen extends StatefulWidget {
  AdvisoryRequestDetailsScreen({super.key});

  @override
  _AdvisoryRequestDetailsScreenState createState() =>
      _AdvisoryRequestDetailsScreenState();
}

class _AdvisoryRequestDetailsScreenState
    extends State<AdvisoryRequestDetailsScreen> {
  final TextEditingController externalController = TextEditingController();
  List<PlatformFile> _files = [];

  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();

  String? recordingPath;

  @override
  void initState() {
    super.initState();
  }





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

  void _validateAndSubmit() {
    final advisoryCubit = getit<AdvisoryCubit>();
    if (advisoryCubit.selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب اختيار مستوى الطلب')),
      );
      return;
    }
    if (externalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب كتابة تفاصيل الاستشارة')),
      );
      return;
    }

    // save request to cubit
    advisoryCubit.saveRequest({
      "sub_price_id": advisoryCubit.selectedAccurateData!.id,
      "level": advisoryCubit.selectedLevel!.id,
      "details": externalController.text,
      "files": _files,
      "recording": recordingPath ?? "",
    });

    advisoryCubit.nextStep();
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _playerController.dispose();
    externalController.dispose();
    super.dispose();
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
    return BlocConsumer<AdvisoryCubit, AdvisoryState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final advisoryCubit = getit<AdvisoryCubit>();
        final selectedAccurateData = advisoryCubit.selectedAccurateData;
        final selectedLevel = advisoryCubit.selectedLevel;
        if (selectedAccurateData == null ) {
          return Center(child: Text("No accurate data or level selected"));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "تفاصيل طلبك",
                style: TextStyles.cairo_14_bold,
              ),
              verticalSpace(5.h),
              Text(
                "تفاصيل طلبك للحصول على استشارة دقيقة",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.grey15),
              ),
              verticalSpace(20.h),
              Text("مستوى الطلب ", style: TextStyles.cairo_12_bold),
              CustomCheckSelectLevel(
                items: selectedAccurateData.levels!,
                onChanged: (item) {
                  advisoryCubit.selectedLevel = item;
                },
              ),
              Text("تفاصيل الاستشارة", style: TextStyles.cairo_12_bold),
              CustomTextFieldPrimary(
                hintText: "الموضوع",
                multiLine: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "الموضوع مطلوب";
                  }
                  return null;
                },
                externalController: externalController,
                title: "اكتب تفاصيل الاستشارة",
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
                          border:
                              Border.all(color: appColors.primaryColorYellow),
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
                    child: Text(
                      "التالي",
                      style: TextStyles.cairo_14_bold
                          .copyWith(color: appColors.white),
                    ),
                    onPressed: _validateAndSubmit),
              ),
              verticalSpace(50.h),
            ],
          ),
        );
      },
    );
  }
}
