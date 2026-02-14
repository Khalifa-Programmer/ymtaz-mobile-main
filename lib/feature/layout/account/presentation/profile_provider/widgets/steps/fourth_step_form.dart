import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/attachment_uploader.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';

class FourthStepForm extends StatefulWidget {
  final Function(void Function()) setStateCallback;

  const FourthStepForm({
    super.key,
    required this.setStateCallback,
  });

  @override
  State<FourthStepForm> createState() => _FourthStepFormState();
}

class _FourthStepFormState extends State<FourthStepForm> {
  // إخفاء لوحة المفاتيح
  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPersonalPhoto(),
        verticalSpace(20.h),
        _buildLogoUploader(),
        verticalSpace(20.h),
      ],
    );
  }

  /// بناء جزء الصورة الشخصية
  Widget _buildPersonalPhoto() {
    final cubit = context.read<SignUpCubit>();
    
    return AttachmentPicker(
      title: "الصورة الشخصية",
      condition: true,
      uploadText: "إرفاق الصورة الشخصية (اختياري)",
      attachedText: "تم إرفاق ملف",
      onTap: () async {
        _dismissKeyboard();
        cubit.profileImage = await cubit.pickImage();
        cubit.isNetworkImageProfile = false;
        widget.setStateCallback(() {});
      },
      onRemoveFile: () {
        cubit.profileImage = null;
        cubit.isNetworkImageProfile = false;
        widget.setStateCallback(() {});
      },
      attachment: cubit.profileImage,
      isNetworkAttachment: cubit.isNetworkImageProfile!,
      networkAttachmentText: "يوجد مرفق صورة شخصية مرفوع مسبقاً",
    );
  }

  /// بناء جزء رفع الشعار
  Widget _buildLogoUploader() {
    final cubit = context.read<SignUpCubit>();
    
    return AttachmentPicker(
      title: "الشعار",
      condition: true,
      uploadText: "إرفاق الشعار (الزامي للشركات والمؤسسات)",
      attachedText: "تم إرفاق ملف",
      onTap: () async {
        _dismissKeyboard();
        cubit.logoImage = await cubit.pickImage();
        cubit.isNetworkImageLogo = false;
        widget.setStateCallback(() {});
      },
      onRemoveFile: () {
        cubit.logoImage = null;
        cubit.isNetworkImageLogo = false;
        widget.setStateCallback(() {});
      },
      attachment: cubit.logoImage,
      isNetworkAttachment: cubit.isNetworkImageLogo!,
      networkAttachmentText: "يوجد مرفق شعار مرفوع مسبقاً",
    );
  }
}
