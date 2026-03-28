import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/recorder_player_widget.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/routes.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/widgets/alerts.dart';
import '../../../core/widgets/app_bar.dart';
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
  final TextEditingController titleController = TextEditingController();
  final List<PlatformFile> _files = [];
  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();
  String? recordingPath;

  @override
  void initState() {
    super.initState();
    context.read<YmtazEliteCubit>().getCategories();
  }

  void _pickFiles() async {
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

  void _removeFile(int index) => setState(() => _files.removeAt(index));

  void _onRecordingComplete(String? path) => setState(() => recordingPath = path);

  void _validateAndSubmit() async {
    if (externalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب كتابة تفاصيل الطلب')));
      return;
    }
    final cubit = context.read<YmtazEliteCubit>();
    if (cubit.selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب اختيار نوع الخدمة')));
      return;
    }

    final formData = FormData.fromMap({
      "elite_service_category_id": cubit.selectedCategoryId.toString(),
      "service_title": titleController.text,
      "description": externalController.text,
    });

    for (var i = 0; i < _files.length; i++) {
      formData.files.add(MapEntry('files[$i][file]', await MultipartFile.fromFile(_files[i].path!)));
      formData.fields.add(MapEntry('files[$i][is_voice]', 'false'));
    }

    if (recordingPath != null) {
      formData.files.add(MapEntry('files[${_files.length}][file]', await MultipartFile.fromFile(recordingPath!)));
      formData.fields.add(MapEntry('files[${_files.length}][is_voice]', 'true'));
    }
    await cubit.sendEliteRequest(formData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteRequestLoading) {
          showDialog(context: context, barrierDismissible: false, builder: (context) => const Center(child: CircularProgressIndicator()));
        } else if (state is YmtazEliteRequestSuccess) {
          Navigator.pop(context);
          final userType = CacheHelper.getData(key: 'userType');
          final route = userType == 'provider'
              ? Routes.eliteRequestsClients
              : Routes.eliteRequests;
          context.pushNamedAndRemoveUntil(route, predicate: (route) => false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => EliteRequestSuccessScreen(request: state.request)));
        } else if (state is YmtazEliteRequestError) {
          Navigator.pop(context);
          AppAlerts.showAlert(context: context, message: state.message, buttonText: 'حسناً', type: AlertType.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildBlurredAppBar(context, "طلب خدمة النخبة"),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpace(10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(color: const Color(0xFFFAF6E9), borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("نخبة", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFFD4AF37), fontFamily: 'Cairo')),
                    horizontalSpace(4.w),
                    Icon(Icons.workspace_premium, size: 16.sp, color: const Color(0xFFD4AF37)),
                  ],
                ),
              ),
              verticalSpace(30.h),
              _buildSectionTitle("نوع الطلب"),
              verticalSpace(8.h),
              BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                builder: (context, state) {
                  final cubit = context.read<YmtazEliteCubit>();
                  if (state is YmtazEliteLoading) return const Center(child: CircularProgressIndicator());
                  if (state is YmtazEliteError) {
                    return Column(children: [
                      const Text("فشل تحميل الأنواع", style: TextStyle(fontFamily: 'Cairo', color: Colors.red)),
                      TextButton(onPressed: () => cubit.getCategories(), child: const Text("إعادة المحاولة"))
                    ]);
                  }
                  if (cubit.categories?.data?.categories == null) return const SizedBox.shrink();
                  return CustomDropdown<Category>(
                    hintText: 'اختر نوع الطلب',
                    items: cubit.categories!.data!.categories!,
                    onChanged: (value) => cubit.selectCategory(value!.id!),
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Colors.white,
                      closedBorder: Border.all(color: Colors.grey[200]!),
                      closedBorderRadius: BorderRadius.circular(12.r),
                    ),
                  );
                },
              ),
              verticalSpace(20.h),
              _buildSectionTitle("عنوان الطلب"),
              _buildTextField(titleController, hint: "عنوان مختصر", maxLength: 30),
              verticalSpace(20.h),
              _buildSectionTitle("تفاصيل الطلب"),
              _buildTextField(externalController, hint: "وصف الطلب دقيق", maxLines: 5),
              verticalSpace(30.h),
              _buildUploadArea(),
              if (_files.isNotEmpty) _buildFileList(),
              verticalSpace(20.h),
              RecorderPlayerWidget(onRecordingComplete: _onRecordingComplete, recorderController: _recorderController, playerController: _playerController),
              verticalSpace(40.h),
              _buildSubmitButton(),
              verticalSpace(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Align(alignment: Alignment.centerRight, child: Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.grey[400], fontFamily: 'Cairo')));

  Widget _buildTextField(TextEditingController controller, {String? hint, int maxLines = 1, int? maxLength}) => Container(
        margin: EdgeInsets.only(top: 8.h),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey[200]!)),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          textAlign: TextAlign.right,
          decoration: InputDecoration(hintText: hint, counterText: "", contentPadding: EdgeInsets.all(16.w), border: InputBorder.none),
        ),
      );

  Widget _buildUploadArea() => GestureDetector(
        onTap: _pickFiles,
        child: Container(
          width: double.infinity,
          height: 70.h,
          decoration: BoxDecoration(color: const Color(0xFFFAF6E9), borderRadius: BorderRadius.circular(12.r), border: Border.all(color: const Color(0xFFD4AF37), style: BorderStyle.solid)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("إرفاق ملف او صورة", style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))), horizontalSpace(8.w), const Icon(Icons.attach_file, color: Color(0xFFD4AF37))]),
        ),
      );

  Widget _buildFileList() => Column(children: _files.asMap().entries.map((e) => ListTile(title: Text(e.value.name, style: TextStyles.cairo_12_semiBold), trailing: IconButton(icon: const Icon(Icons.close), onPressed: () => _removeFile(e.key)))).toList());

  Widget _buildSubmitButton() => SizedBox(width: double.infinity, child: CupertinoButton(color: const Color(0xFFD4AF37), onPressed: _validateAndSubmit, child: const Text("إرسال الطلب", style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.white))));

  @override
  void dispose() {
    externalController.dispose();
    titleController.dispose();
    _recorderController.dispose();
    _playerController.dispose();
    super.dispose();
  }
}
