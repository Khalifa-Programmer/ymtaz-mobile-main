import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/select_price_component.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/primary/text_form_primary.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../recorder_player_widget.dart';
import '../logic/services_cubit.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
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

  // void _validateAndSubmit() {
  @override
  void dispose() {
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
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildBlurredAppBar(context, "تفاصيل الخدمة"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: BlocConsumer<ServicesCubit, ServicesState>(
            listener: (context, state) {},
            builder: (context, state) {
              final serviseCubit = getit<ServicesCubit>();
              final selectedAccurateData = serviseCubit.selectedMainType;
              final levels = serviseCubit.selectedSubService?.ymtazLevelsPrices;
              if (selectedAccurateData == null || levels == null) {
                return Center(
                    child: Text("No accurate data or level selected"));
              }
              return ListView(
                children: [
                  verticalSpace(20.h),

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
                  Text("مستوى الطلب ", style: TextStyles.cairo_12_bold),
                  CustomCheckSelectLevelServices(
                    items: levels!,
                    onChanged: (item) {
                      serviseCubit.selectedLevel = item;
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
                        child: Text(
                          "التالي",
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.white),
                        ),
                        onPressed: () {
                          if (serviseCubit.selectedLevel != null &&
                              serviseCubit.selectedSubService != null) {
                            serviseCubit.requestData.fields.add(MapEntry(
                                "importance_id",
                                serviseCubit.selectedLevel!.level!.id
                                    .toString()));
                            serviseCubit.requestData.fields.add(MapEntry(
                                "service_id",
                                serviseCubit.selectedSubService!.id
                                    .toString()));
                            serviseCubit.requestData.fields.add(MapEntry(
                                "description", externalController.text));
                            if (_files.isNotEmpty) {
                              for (int i = 0; i < _files.length; i++) {
                                serviseCubit.requestData.files.add(MapEntry(
                                  "files[$i]",
                                  MultipartFile.fromFileSync(_files[i].path!,
                                      filename: _files[i].name),
                                ));
                              }
                            }
                            if (recordingPath != null &&
                                recordingPath!.isNotEmpty) {
                              serviseCubit.requestData.files.add(MapEntry(
                                "voice_file",
                                MultipartFile.fromFileSync(recordingPath!,
                                    filename: "recording"),
                              ));
                            }
                            context.pushNamed(Routes.lawyerSelection);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please select a level and sub-service')),
                            );
                          }
                        }),
                  ),
                  verticalSpace(50.h),
                ],
              );
            },
          ),
        ));
  }
}
