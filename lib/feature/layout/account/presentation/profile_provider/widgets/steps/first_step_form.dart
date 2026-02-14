import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/attachment_uploader.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:yamtaz/config/themes/styles.dart';

class FirstStepForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(BuildContext) selectDateCallback;

  const FirstStepForm({
    super.key,
    required this.formKey,
    required this.selectDateCallback,
  });

  @override
  State<FirstStepForm> createState() => _FirstStepFormState();
}

class _FirstStepFormState extends State<FirstStepForm> {
  // إخفاء لوحة المفاتي
  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildTypeSelection(),
          _buildCompanyName(),
          _buildLicenseNumber(),
          _buildLicenseFile(),
          _buildResumeUploader(),
          _buildAboutTextField(),
          _buildBirthDatePicker(),
          _buildGenderSelection(),
        ],
      ),
    );
  }

  Widget _buildTypeSelection() {
    return ConditionalBuilder(
      condition: context.read<SignUpCubit>().lawyerTypes != null,
      builder: (BuildContext context) => CustomContainerEditSignUp(
        title: 'الصفة',
        child: CustomDropdown(
          decoration: const CustomDropdownDecoration(),
          validator: (value) {
            if (value == null) {
              return 'الرجاء اختيار الصفة';
            }
            return null;
          },
          hintText: "الصفة",
          initialItem: context.read<SignUpCubit>().targetType,
          items: context.read<SignUpCubit>().lawyerTypes!.data!.types,
          onChanged: (value) {
            context.read<SignUpCubit>().accountTypeValue = value!.id!;
            context.read<SignUpCubit>().needCompanyName = value.needCompanyName!;
            context.read<SignUpCubit>().needLicenseFile = value.needCompanyLicenceFile!;
            context.read<SignUpCubit>().needLicenseNo = value.needCompanyLicenceNo!;
            setState(() {});
          },
        ),
      ),
      fallback: (BuildContext context) => const CupertinoActivityIndicator(),
    );
  }

  Widget _buildCompanyName() {
    final cubit = context.read<SignUpCubit>();
    
    return ConditionalBuilder(
      condition: cubit.needCompanyName == 1,
      builder: (BuildContext context) => Animate(
        effects: [FadeEffect(delay: 200.ms)],
        child: CustomTextFieldPrimary(
          hintText: 'اسم الجهة',
          validator: (value) {
            if (value!.isEmpty) {
              return 'الرجاء إدخال اسم الجهة';
            }
            return null;
          },
          type: TextInputType.text,
          typeInputAction: TextInputAction.done,
          externalController: cubit.companyNameController,
          multiLine: false,
          title: 'اسم الجهة',
        ),
      ),
      fallback: (BuildContext context) => const SizedBox(),
    );
  }

  Widget _buildLicenseNumber() {
    final cubit = context.read<SignUpCubit>();
    
    return ConditionalBuilder(
      condition: cubit.needLicenseNo == 1,
      builder: (BuildContext context) => Animate(
        effects: [FadeEffect(delay: 200.ms)],
        child: CustomTextFieldPrimary(
          hintText: 'رقم السجل التجاري',
          validator: (value) {
            if (value!.isEmpty || value.length > 14) {
              return 'يرجى إدخال رقم ترخيص (حد أقصى 14 حرفًا)';
            }
            return null;
          },
          maxLenght: 14,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\-_]')),
            LengthLimitingTextInputFormatter(14),
          ],
          type: TextInputType.number,
          typeInputAction: TextInputAction.done,
          externalController: cubit.licenseNoController,
          multiLine: false,
          title: 'رقم السجل التجاري',
        ),
      ),
      fallback: (BuildContext context) => const SizedBox(),
    );
  }

  Widget _buildLicenseFile() {
    final cubit = context.read<SignUpCubit>();
    
    return AttachmentPicker(
      title: "السجل التجاري",
      condition: cubit.needLicenseFile == 1,
      uploadText: "إرفاق نسخه السجل التجاري (إلزامي)",
      attachedText: "تم إرفاق ملف",
      onTap: () async {
        _dismissKeyboard();
        cubit.licenseFileCompany = await cubit.pickFile();
        cubit.isNetworkImageCompany = false;
        setState(() {});
      },
      onRemoveFile: () {
        cubit.licenseFileCompany = null;
        cubit.isNetworkImageCompany = false;
        setState(() {});
      },
      attachment: cubit.licenseFileCompany,
      isNetworkAttachment: cubit.isNetworkImageCompany!,
      networkAttachmentText: "يوجد مرفق سابق مرفوع",
    );
  }

  Widget _buildResumeUploader() {
    final cubit = context.read<SignUpCubit>();
    
    return AttachmentPicker(
      title: "السيرة الذاتية",
      condition: cubit.needCompanyName == 0 &&
          cubit.needLicenseNo == 0 &&
          cubit.needLicenseFile == 0,
      uploadText: "إرفاق السيرة الذاتية",
      attachedText: "تم إرفاق ملف",
      onTap: () async {
        _dismissKeyboard();
        cubit.resumeImage = await cubit.pickFile();
        cubit.isNetworkImageCv = false;
        setState(() {});
      },
      onRemoveFile: () {
        cubit.resumeImage = null;
        cubit.isNetworkImageCv = false;
        setState(() {});
      },
      attachment: cubit.resumeImage,
      isNetworkAttachment: cubit.isNetworkImageCv ?? false,
      networkAttachmentText: "يوجد مرفق سابق مرفوع",
    );
  }

  Widget _buildAboutTextField() {
    final cubit = context.read<SignUpCubit>();
    
    return CustomTextFieldPrimary(
      hintText: 'نبذة مختصرة',
      validator: (value) {
        if (value!.isEmpty) {
          return 'الرجاء إدخال نبذة مختصرة';
        }
        return null;
      },
      type: TextInputType.text,
      typeInputAction: TextInputAction.done,
      externalController: cubit.aboutController,
      multiLine: true,
      title: 'نبذة مختصرة',
    );
  }

  Widget _buildBirthDatePicker() {
    final cubit = context.read<SignUpCubit>();
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تاريخ الميلاد",
            style: TextStyles.cairo_14_semiBold.copyWith(
              color: appColors.blue100,
            ),
          ),
          verticalSpace(10.h),
          GestureDetector(
            onTap: () => widget.selectDateCallback(context),
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: appColors.grey3,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.selectedBirthDate != null
                        ? "${cubit.selectedBirthDate!.day}/${cubit.selectedBirthDate!.month}/${cubit.selectedBirthDate!.year}"
                        : "اختر تاريخ الميلاد",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey10,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: appColors.grey5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    final cubit = context.read<SignUpCubit>();
    
    return CustomContainerEditSignUp(
      title: 'الجنس',
      child: CustomDropdown(
        validator: (value) {
          if (value == null) {
            return 'الرجاء اختيار الجنس';
          }
          return null;
        },
        hintText: "الجنس",
        initialItem: cubit.targetGender!.isEmpty
            ? null
            : cubit.targetGender,
        items: cubit.gender.keys.toList(),
        onChanged: (value) {
          cubit.gender.forEach((key, keyVal) {
            if (key == value) {
              cubit.selectedGender = keyVal;
            }
          });
        },
      ),
    );
  }
}
