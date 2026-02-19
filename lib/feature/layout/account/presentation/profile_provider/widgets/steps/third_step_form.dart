import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/attachment_uploader.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ThirdStepForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(void Function()) setStateCallback;

  const ThirdStepForm({
    super.key,
    required this.formKey,
    required this.setStateCallback,
  });

  @override
  State<ThirdStepForm> createState() => _ThirdStepFormState();
}

class _ThirdStepFormState extends State<ThirdStepForm> {
  // إخفاء لوحة المفاتيح
  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildIdentitySection(),
          _buildProfessionSection(),
          _buildQualificationsSection(),
        ],
      ),
    );
  }

  Widget _buildIdentitySection() {
    final cubit = context.read<SignUpCubit>();
    
    return ConditionalBuilder(
      condition: cubit.functionalCases != null && cubit.sections != null,
      builder: (BuildContext context) => Animate(
        effects: const [
          FadeEffect(
            duration: Duration(milliseconds: 500),
          ),
        ],
        child: Column(
          children: [
            // نوع الهوية
            CustomContainerEditSignUp(
              title: 'نوع الهوية',
              child: CustomDropdown(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار نوع الهوية';
                  }
                  return null;
                },
                hintText: "نوع الهوية",
                initialItem: cubit.targetIdentitiyType,
                items: cubit.idType.keys.toList(),
                onChanged: (value) {
                  cubit.idType.forEach((key, keyVal) {
                    if (key == value) {
                      cubit.idTypeValue = keyVal;
                    }
                    cubit.idFieldFocus.unfocus();

                    widget.setStateCallback(() {
                      cubit.idController.clear();
                      cubit.idImage = null;
                      cubit.isNetworkImageId = false;
                    });
                  });
                },
              ),
            ),
            
            // رقم الهوية
            CustomTextFieldPrimary(
              hintText: 'رقم الهوية',
              maxLenght: cubit.idTypeValue == 2 ? null : 10,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال رقم الهوية';
                } else if (cubit.idTypeValue == 2) {
                  // تحقق إضافي إذا كان نوع الهوية هو 2
                  final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
                  if (!alphanumericRegex.hasMatch(value)) {
                    return 'الرجاء إدخال رقم هوية';
                  }
                } else if (value.length != 10) {
                  return 'أدخل رقم الهوية حد أقصي ١٠ أرقام';
                }
                return null;
              },
              inputFormatters: [
                cubit.idTypeValue == 1 || cubit.idTypeValue == 3
                  ? LengthLimitingTextInputFormatter(10)
                  : FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
              ],
              type: cubit.idTypeValue == 2 ? TextInputType.text : TextInputType.number,
              focusnode: cubit.idFieldFocus,
              typeInputAction: TextInputAction.done,
              externalController: cubit.idController,
              multiLine: false,
              title: 'رقم الهوية',
            ),
            
            // نسخة الهوية
            AttachmentPicker(
              title: "نسخة الهوية",
              condition: true,
              uploadText: "إرفاق نسخة الهوية (إلزامي)",
              attachedText: "تم إرفاق ملف",
              onTap: () async {
                _dismissKeyboard();
                cubit.idImage = await cubit.pickFile();
                cubit.isNetworkImageId = false;
                widget.setStateCallback(() {});
              },
              onRemoveFile: () {
                cubit.idImage = null;
                cubit.isNetworkImageId = false;
                widget.setStateCallback(() {});
              },
              attachment: cubit.idImage,
              isNetworkAttachment: cubit.isNetworkImageId!,
              networkAttachmentText: "يوجد مرفق هوية مرفوع مسبقاً",
            ),
            verticalSpace(10.h),
          ],
        ),
      ),
      fallback: (BuildContext context) => const CupertinoActivityIndicator(),
    );
  }

  Widget _buildProfessionSection() {
    final cubit = context.read<SignUpCubit>();
    
    return ConditionalBuilder(
      condition: cubit.functionalCases != null && cubit.sections != null,
      builder: (BuildContext context) => Column(
        children: [
          // الحالة الوظيفية
          CustomContainerEditSignUp(
            title: 'الحالة الوظيفية',
            child: CustomDropdown(
              validator: (value) {
                if (value == null) {
                  return 'الرجاء اختيار الحالة الوظيفية';
                }
                return null;
              },
              hintText: "الحالة الوظيفية",
              items: cubit.functionalCases!.data!.functionalCases!,
              initialItem: cubit.targetFunctionalCase,
              onChanged: (value) {
                cubit.selectedFunctionalCase = value!.id!;
              },
            ),
          ),
          
          // المهنة
          CustomContainerEditSignUp(
            title: 'المهنة',
            child: CustomDropdown<DigitalGuideCategory>.multiSelectSearch(
              listValidator: (value) {
                if (value.isEmpty) {
                  return 'الرجاء اختيار المهنة';
                }
                return null;
              },
              overlayHeight: MediaQuery.of(context).size.height * 0.5,
              hintText: "المهنة",
              initialItems: cubit.selectedSections,
              items: cubit.sections!.data!.digitalGuideCategories,
              onListChanged: (List<DigitalGuideCategory> selected) {
                // Find the index of the first item that should be removed
                int index = cubit.selectedSectionsNeedLicense.indexWhere(
                  (item) => !selected.contains(item),
                );

                // Remove items at the found index
                if (index != -1) {
                  cubit.selectedSectionsNeedLicense.removeAt(index);
                  cubit.selectedSectionsNeedLicenseText.removeAt(index);
                  cubit.selectedSectionsNeedLicenseFiles.removeAt(index);
                  cubit.selectedSectionsContainLicenseImageBool.removeAt(index);
                }

                // Update the selectedSections and selectedSectionsNeedLicense
                cubit.selectedSections = selected;

                for (DigitalGuideCategory i in selected) {
                  if (i.needLicense == 1 && !cubit.selectedSectionsNeedLicense.contains(i)) {
                    cubit.selectedSectionsNeedLicense.add(i);
                    cubit.selectedSectionsNeedLicenseText.add(TextEditingController());
                    cubit.selectedSectionsNeedLicenseFiles.add(null);
                    cubit.selectedSectionsContainLicenseImageBool.add(false);
                  }
                }

                widget.setStateCallback(() {});
              },
            ),
          ),
          
          // المهن المرخصة
          _buildLicensedProfessions(),
          
          Visibility(
            visible: cubit.selectedSectionsNeedLicense.isNotEmpty,
            child: Animate(
              effects: [FadeEffect(delay: 200.ms)],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text("png, jpg, jpeg, pdf"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          verticalSpace(10.h),
        ],
      ),
      fallback: (BuildContext context) => const CupertinoActivityIndicator(),
    );
  }

  Widget _buildLicensedProfessions() {
    final cubit = context.read<SignUpCubit>();
    
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Animate(
          effects: const [
            FadeEffect(
              duration: Duration(milliseconds: 500),
            ),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // حقل رقم الترخيص
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.9,
                child: CustomTextFieldPrimary(
                  maxLenght: 14,
                  hintText: 'رقم الترخيص ل${cubit.selectedSectionsNeedLicense[index].title}',
                  validator: (value) {
                    if (value!.isEmpty || value.length > 14) {
                      return 'يرجى إدخال رقم ترخيص';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\-_]')),
                    LengthLimitingTextInputFormatter(14),
                  ],
                  type: TextInputType.number,
                  typeInputAction: TextInputAction.done,
                  externalController: cubit.selectedSectionsNeedLicenseText[index],
                  multiLine: false,
                  title: 'رقم ترخيص ${cubit.selectedSectionsNeedLicense[index].title}',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // زر إرفاق صورة الترخيص
                  GestureDetector(
                    onTap: () async {
                      _dismissKeyboard();
                      cubit.selectedSectionsNeedLicenseFiles[index] = await cubit.pickFile();
                      widget.setStateCallback(() {});
                    },
                    onLongPress: () {
                      cubit.selectedSectionsNeedLicenseFiles[index] = null;
                      widget.setStateCallback(() {});
                    },
                    child: Container(
                      width: 70.w,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: cubit.selectedSectionsNeedLicenseFiles[index] != null ||
                                cubit.selectedSectionsContainLicenseImageBool[index] == true
                            ? appColors.green
                            : appColors.blue100,
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.upload,
                            width: 30.w,
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(10.w),
                  
                  // زر حذف المرفق
                  Visibility(
                    visible: cubit.selectedSectionsNeedLicenseFiles[index] != null ||
                            cubit.selectedSectionsContainLicenseImageBool[index] == true,
                    child: Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: GestureDetector(
                        onTap: () {
                          cubit.selectedSectionsNeedLicenseFiles[index] = null;
                          cubit.selectedSectionsContainLicenseImageBool[index] = false;
                          widget.setStateCallback(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: appColors.red5,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.delete,
                            color: appColors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => verticalSpace(10.h),
      itemCount: cubit.selectedSectionsNeedLicense.length,
    );
  }

  Widget _buildQualificationsSection() {
    final cubit = context.read<SignUpCubit>();
    
    return ConditionalBuilder(
      condition: cubit.degrees != null && 
                cubit.generalSpecialty != null && 
                cubit.accurateSpecialty != null && 
                cubit.langs != null,
      builder: (BuildContext context) => Animate(
        effects: const [
          FadeEffect(
            duration: Duration(milliseconds: 500),
          ),
        ],
        child: Column(
          children: [
            // الدرجة العلمية
            CustomContainerEditSignUp(
              title: 'الدرجة العلمية',
              child: CustomDropdown(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار نوع الدرجة';
                  }
                  return null;
                },
                hintText: "الدرجة العلمية",
                items: cubit.degrees!.data!.degrees,
                initialItem: cubit.targetDegree,
                onChanged: (value) {
                  cubit.selectedDegree = value!.id!;
                  cubit.degreeVerifyImage = null;
                  cubit.isNetworkImageDegree = false;

                  widget.setStateCallback(() {
                    if (value.needCertificate == 1) {
                      cubit.selectedDegreeNeedCertificate = true;
                    } else {
                      cubit.selectedDegreeNeedCertificate = false;
                    }
                    if (value.isSpecial == 1) {
                      cubit.selectedDegreeIsSpecial = true;
                    } else {
                      cubit.selectedDegreeIsSpecial = false;
                    }
                  });
                },
              ),
            ),
            
            // مرفق الدرجة العلمية
            AttachmentPicker(
              title: "مرفق الدرجة العلمية",
              condition: () {
                final needsLicenseEmpty = cubit.selectedSectionsNeedLicense.isEmpty;
                final needsCertificate = cubit.selectedDegreeNeedCertificate;
                final isSpecial = cubit.selectedDegreeIsSpecial;
                final isDegree4 = cubit.selectedDegree == 4;

                return (needsLicenseEmpty && needsCertificate) || isSpecial == true || isDegree4;
              }(),
              uploadText: "إرفاق إثبات الدرجة العلمية (إلزامي)",
              attachedText: "تم إرفاق ملف",
              onTap: () async {
                _dismissKeyboard();
                cubit.degreeVerifyImage = await cubit.pickFile();
                cubit.isNetworkImageDegree = false;
                widget.setStateCallback(() {});
              },
              onRemoveFile: () {
                cubit.degreeVerifyImage = null;
                cubit.isNetworkImageDegree = false;
                widget.setStateCallback(() {});
              },
              attachment: cubit.degreeVerifyImage,
              isNetworkAttachment: cubit.isNetworkImageDegree!,
              networkAttachmentText: "يوجد مرفق سابق مرفوع",
            ),
            
            // حقل إدخال اسم الدرجة العلمية لدرجة "أخرى"
            Visibility(
              visible: cubit.selectedDegree == 4,
              child: CustomTextFieldPrimary(
                hintText: 'اسم الدرجة العلمية ',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء إدخال اسم الدرجة العلمية';
                  }
                  return null;
                },
                type: TextInputType.text,
                typeInputAction: TextInputAction.done,
                externalController: cubit.degreeOtherSpecialtyController,
                multiLine: false,
                title: 'اسم الدرجة العلمية',
              ),
            ),
            
            // التخصص العام
            CustomContainerEditSignUp(
              title: 'التخصص العام',
              child: CustomDropdown(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار التخصص';
                  }
                  return null;
                },
                hintText: "التخصص العام",
                initialItem: cubit.targetGeneralSpecialty,
                items: cubit.generalSpecialty!.data!.generalSpecialty,
                onChanged: (value) {
                  cubit.selectedGeneralSpecialty = value!.id!;
                },
              ),
            ),
            
            // التخصص الدقيق
            CustomContainerEditSignUp(
              title: 'التخصص الدقيق',
              child: CustomDropdown(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار التخصص';
                  }
                  return null;
                },
                hintText: "التخصص الدقيق",
                items: cubit.accurateSpecialty!.data!.accurateSpecialty,
                initialItem: cubit.targetAccurateSpecialty,
                onChanged: (value) {
                  cubit.selectedAccurateSpecialty = value!.id!;
                },
              ),
            ),
            
            // اللغات الأخرى
            CustomContainerEditSignUp(
              title: 'اللغات الأخرى',
              child: CustomDropdown.multiSelectSearch(
                hintText: "اللغات",
                initialItems: cubit.selectedLanguages,
                items: cubit.langs!.data!.languages,
                onListChanged: (p0) {
                  cubit.selectedLanguages = p0;
                },
              ),
            ),
          ],
        ),
      ),
      fallback: (BuildContext context) => const CupertinoActivityIndicator(),
    );
  }
}
