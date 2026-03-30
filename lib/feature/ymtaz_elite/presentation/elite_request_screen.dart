import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/primary/text_form_primary.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/elite_category_model.dart';
import '../logic/ymtaz_elite_cubit.dart';
import 'elite_request_success_screen.dart';

class EliteRequestScreen extends StatefulWidget {
  const EliteRequestScreen({super.key});

  @override
  State<EliteRequestScreen> createState() => _EliteRequestScreenState();
}

class _EliteRequestScreenState extends State<EliteRequestScreen> {
  final TextEditingController externalController = TextEditingController();
  final List<PlatformFile> _files = [];

  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();

  String? recordingPath;

  @override
  void initState() {
    super.initState();
    context.read<YmtazEliteCubit>().getCategories();
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
        backgroundColor: Colors.white,
        appBar: buildBlurredAppBar(context, "طلب خدمة النخبة"),
        body: Animate(
          effects: [FadeEffect(duration: 500.ms)],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(10.h),
                  // "Elite" Tag
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF6E9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "نخبة",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFD4AF37),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        horizontalSpace(4.w),
                        SvgPicture.asset(
                          AppAssets.crown,
                          width: 16.sp,
                          height: 16.sp,
                          color: const Color(0xFFD4AF37),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(30.h),
                  
                  // Request Type Dropdown
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "نوع الطلب",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[400], fontFamily: 'Cairo'),
                    ),
                  ),
                  verticalSpace(8.h),
                  BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                    buildWhen: (previous, current) => current is YmtazEliteSuccess || current is YmtazEliteLoading,
                    builder: (context, state) {
                      final cubit = context.read<YmtazEliteCubit>();
                      if (cubit.categories == null || cubit.categories!.data == null || cubit.categories!.data!.categories == null) {
                        return Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                      return CustomDropdown<Category>(
                        hintText: 'اختر نوع الطلب',
                        items: cubit.categories!.data!.categories!,
                        onChanged: (value) {
                          cubit.selectCategory(value!.id!);
                        },
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Colors.white,
                          closedBorder: Border.all(color: Colors.grey[200]!),
                          closedBorderRadius: BorderRadius.circular(12.r),
                          hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey[300], fontFamily: 'Cairo'),
                        ),
                      );
                    },
                  ),
                  verticalSpace(20.h),

                  // Problem Description
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تفاصيل الطلب",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[400], fontFamily: 'Cairo'),
                    ),
                  ),
                  verticalSpace(8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: TextField(
                      controller: externalController,
                      maxLines: 5,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13.sp, fontFamily: 'Cairo'),
                      decoration: InputDecoration(
                        hintText: "اكتب وصف الطلب بشكل دقيق...",
                        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[300], fontFamily: 'Cairo'),
                        contentPadding: EdgeInsets.all(16.w),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  verticalSpace(20.h),

                  // Attachments Section
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "المرفقات",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600], fontFamily: 'Cairo'),
                        ),
                        Text(
                          "الحد المسموح به 5 ملفات*",
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey[400], fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(12.h),
                  
                  // Dotted Border for upload
                  CustomPaint(
                    painter: DottedBorderPainter(color: const Color(0xFFD4AF37)),
                    child: GestureDetector(
                      onTap: _pickFiles,
                      child: Container(
                        width: double.infinity,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF6E9).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "إرفاق ملف او صورة",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFD4AF37).withOpacity(0.8),
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            horizontalSpace(8.w),
                            Icon(CupertinoIcons.paperclip, color: const Color(0xFFD4AF37).withOpacity(0.8), size: 22.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  if (_files.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Column(
                        children: _files.asMap().entries.map((entry) => _buildFileListItem(entry.value, entry.key)).toList(),
                      ),
                    ),

                  verticalSpace(20.h),

                  // Voice Recording / Player Bar
                  _buildRecorderUI(),

                  verticalSpace(40.h),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      color: const Color(0xFFD4AF37),
                      onPressed: _validateAndSubmit,
                      child: Text(
                        "إرسال الطلب",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecorderUI() {
    return RecorderPlayerWidget(
      onRecordingComplete: _onRecordingComplete,
      recorderController: _recorderController,
      playerController: _playerController,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  DottedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(12.r),
    );

    Path path = Path()..addRRect(rrect);
    
    // Draw dotted path
    Path dottedPath = Path();
    for (var metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dottedPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dottedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
