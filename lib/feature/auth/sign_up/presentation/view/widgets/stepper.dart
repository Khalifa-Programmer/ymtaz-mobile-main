import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';

import '../../../../../../core/helpers/attachment_uploader.dart';
import '../../../../../../core/widgets/textform_auth_field.dart';
import '../../../../../../main.dart';
import '../../../../../../yamtaz.dart';

class StepsSignUp extends StatefulWidget {
  const StepsSignUp({super.key, required this.data});

  final Map data;

  @override
  State<StepsSignUp> createState() => _StepsSignUpState();
}

class _StepsSignUpState extends State<StepsSignUp> {
  int _currentStep = 0;
  DateTime? selectedDate;
  late final GlobalKey<FormState> _formKey1;
  late final GlobalKey<FormState> _formKey2;
  late final GlobalKey<FormState> _formKey3;

  // late final GlobalKey<FormState> _formKey4;
  // late final GlobalKey<FormState> _formKey5;

  bool? locationLoading = false;

  Position? _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    _formKey1 = GlobalKey<FormState>();
    _formKey2 = GlobalKey<FormState>();
    _formKey3 = GlobalKey<FormState>();
    // _formKey4 = GlobalKey<FormState>();
    // _formKey5 = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onVerticalDragUpdate: (details) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          if (_currentStep > 0) {
            // If the current step is not the first step, go back one step
            setState(() {
              _currentStep--;
            });
            return false;
          } else {
            // If the current step is the first step, show the confirmation dialog
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('الخروج'),
                  content: const Text(
                      'في حال اختيار "نعم"، ستُحْذَف البيانات المدخلة'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('نعم'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        'لا',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },
            );
            return shouldPop ?? false;
          }
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                      colorScheme: const ColorScheme.light(
                          primary: appColors.primaryColorYellow)),
                  child: Stepper(
                    elevation: 0.5,
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: EdgeInsets.all(16.0.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            verticalSpace(
                              20.h,
                            ),
                            CustomButton(
                              onPress: details.onStepContinue,
                              title:
                              _currentStep == 3 ? "إرسال الطلب" : 'التالي',
                            ),
                            verticalSpace(
                              20.h,
                            ),
                            _currentStep > 0
                                ? GestureDetector(
                              onTap: details.onStepCancel,
                              child: Text("الصفحه السابقة",
                                  style: TextStyle(
                                      color: appColors.blue100,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400)),
                            )
                                : Container(),
                          ],
                        ),
                      );
                    },
                    type: StepperType.horizontal,
                    physics: const BouncingScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: Text(''),
                        content: firstStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text(''),
                        content: secondStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text(''),
                        content: thirdStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text(''),
                        content: fourthStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      // Step(
                      //   title: new Text(''),
                      //   content: fifthStep(),
                      //   isActive: _currentStep >= 0,
                      //   state: _currentStep >= 4
                      //       ? StepState.complete
                      //       : StepState.disabled,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async {
    hideKeyboard(navigatorKey.currentContext!);

    switch (_currentStep) {
      case 0:
        if (_validateFirstStep()) {
          _moveToNextStep();
        }
        break;
      case 1:
        if (_validateSecondStep()) {
          _moveToNextStep();
        }
        break;
      case 2:
        if (_validateThirdStep()) {
          _moveToNextStep();
        }
        break;
      case 3:
        if (_validateFourthStep()) {
          FormData userData = await _supmitForm();
          context.read<SignUpCubit>().emitSignUpProviderState(userData);
        }
        break;
    }
  }

  bool _validateFirstStep() {
    final signUpCubit = context.read<SignUpCubit>();

    if (signUpCubit.needCompanyName == 1 &&
        signUpCubit.companyNameController.text.isEmpty) {
      _showAlert(context, "يرجى إدخال اسم الجهة", "أعد المحاولة");
      return false;
    }
    if (signUpCubit.needLicenseNo == 1 &&
        signUpCubit.licenseNoController.text.isEmpty) {
      _showAlert(context, "يرجى إدخال رقم الترخيص", "أعد المحاولة");
      return false;
    }
    if (signUpCubit.needLicenseFile == 1 &&
        signUpCubit.licenseFileCompany == null) {
      _showAlert(context, "يرجى إرفاق رخصة الشركة", "أعد المحاولة");
      return false;
    }
    if (selectedDate == null) {
      _showAlert(context, "الرجاء اختيار تاريخ الميلاد و ملئ البيانات المطلوبة",
          "أعد المحاولة");
      return false;
    }
    if (signUpCubit.accountTypeValue == 1 && signUpCubit.resumeImage == null) {
      _showAlert(context, "يرجى إرفاق السيرة الذاتية لانك فرد", "أعد المحاولة");
      return false;
    }
    return _validateStep(_formKey1);
  }

  bool _validateSecondStep() {
    final signUpCubit = context.read<SignUpCubit>();

    if (_currentPosition == null) {
      _showAlert(context, "يرجى اختيار موقع", "حاول مرة اخرى");
      return false;
    }
    if (_validateStep(_formKey2)) {
      if (signUpCubit.selectedCountryPhoneCode == 966 &&
          signUpCubit.selectedDistricts == -1) {
        _showAlert(context, "يجب اختيار منطقة و مدينه", "حاول مرة اخرى");
        return false;
      }
      return true;
    }
    _showAlert(context, "يرجى التأكد من ملء البيانات كاملة", "حاول مرة اخرى");
    return false;
  }

  bool _validateThirdStep() {
    final signUpCubit = context.read<SignUpCubit>();

    if (signUpCubit.selectedSectionsNeedLicenseFiles
        .any((file) => file == null)) {
      _showAlert(context, "تاكد من ارفاقك ملفات الرخص المهنية", "أعد المحاولة");
      return false;
    }
    if (signUpCubit.idImage == null) {
      _showAlert(context, "يرجى إرفاق ملف الهوية", "أعد المحاولة");
      return false;
    }
    if ((signUpCubit.selectedSectionsNeedLicense.isEmpty &&
        signUpCubit.selectedDegreeNeedCertificate &&
        signUpCubit.degreeVerifyImage == null) ||
        signUpCubit.selectedDegreeIsSpecial ||
        signUpCubit.selectedDegree == 4) {
      if (signUpCubit.degreeVerifyImage == null) {
        _showAlert(context, "يرجى إرفاق إثبات الدرجة العلمية المختارة.",
            "أعد المحاولة");
        return false;
      }
    }
    return _validateStep(_formKey3);
  }

  bool _validateFourthStep() {
    final signUpCubit = context.read<SignUpCubit>();

    if (signUpCubit.logoImage == null &&
        (signUpCubit.accountTypeValue == 2 ||
            signUpCubit.accountTypeValue == 3)) {
      _showAlert(context, "يرجى إرفاق شعار الشركة", "أعد المحاولة");
      return false;
    }
    return true;
  }

  void _moveToNextStep() {
    setState(() {
      if (_currentStep < 3) {
        _currentStep++;
      }
      FocusScope.of(context).unfocus();
    });
  }

  void _showAlert(BuildContext context, String message, String buttonText) {
    AppAlerts.showAlert(
      context: context,
      message: message,
      buttonText: buttonText,
      type: AlertType.error,
    );
  }

  bool _validateStep(GlobalKey<FormState> formKeyF) {
    final form = formKeyF.currentState;
    if (form != null && form.validate()) {
      if (selectedDate == null) {
        return false;
      }
      form.save();
      return true;
    }
    return false;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    FocusScope.of(context).unfocus();
  }

  firstStep() {
    return StatefulBuilder(
      builder: (context, state) {
        return Form(
            key: _formKey1,
            child: Column(children: [
              ConditionalBuilder(
                condition: context
                    .read<SignUpCubit>()
                    .lawyerTypes != null,
                builder: (BuildContext context) =>
                    CustomContainerEditSignUp(
                        title: "الصفة",
                        child: CustomDropdown(
                          validator: (value) {
                            if (value == null) {
                              return 'يةالرجاء اختيار الصفة';
                            }
                            return null;
                          },
                          hintText: "الصفة",
                          items:
                          context
                              .read<SignUpCubit>()
                              .lawyerTypes!
                              .data!
                              .types,
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .accountTypeValue =
                            value!.id!;
                            context
                                .read<SignUpCubit>()
                                .needCompanyName =
                            value.needCompanyName!;
                            context
                                .read<SignUpCubit>()
                                .needLicenseFile =
                            value.needCompanyLicenceFile!;
                            context
                                .read<SignUpCubit>()
                                .needLicenseNo =
                            value.needCompanyLicenceNo!;
                            setState(() {});
                          },
                        )),
                fallback: (BuildContext context) =>
                const CupertinoActivityIndicator(),
              ),
              ConditionalBuilder(
                condition: context
                    .read<SignUpCubit>()
                    .needCompanyName == 1,
                builder: (BuildContext context) =>
                    Animate(
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
                        externalController:
                        context
                            .read<SignUpCubit>()
                            .companyNameController,
                        multiLine: false,
                        title: 'اسم الجهة',
                      ),
                    ),
                fallback: (BuildContext context) => const SizedBox(),
              ),
              ConditionalBuilder(
                condition: context
                    .read<SignUpCubit>()
                    .needLicenseNo == 1,
                builder: (BuildContext context) =>
                    Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: CustomTextFieldPrimary(
                        hintText: 'رقم السجل التجاري',
                        validator: (value) {
                          if (value!.isEmpty || value.length > 14) {
                            return 'يرجى إدخال رقم ترخيص (حد أقصى 14 حرفًا)';
                          }

                          // You can add additional validation rules if needed

                          return null;
                        },
                        maxLenght: 14,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9\-_]')),
                          // Allow digits, hyphen, and underscore
                          LengthLimitingTextInputFormatter(14),
                          // Limit the length to 14 characters
                        ],
                        type: TextInputType.number,
                        typeInputAction: TextInputAction.done,
                        externalController:
                        context
                            .read<SignUpCubit>()
                            .licenseNoController,
                        multiLine: false,
                        title: 'رقم السجل التجاري',
                      ),
                    ),
                fallback: (BuildContext context) => const SizedBox(),
              ),
              AttachmentPicker(
                title: "السجل التجاري",
                condition: context
                    .read<SignUpCubit>()
                    .needLicenseFile == 1,
                uploadText: "إرفاق نسخه السجل التجاري (إلزامي)",
                attachedText: "تم إرفاق ملف",
                onTap: () async {
                  hideKeyboard(navigatorKey.currentContext!);
                  context
                      .read<SignUpCubit>()
                      .licenseFileCompany =
                  await context.read<SignUpCubit>().pickFile();
                  setState(() {});
                },
                onRemoveFile: () {
                  context
                      .read<SignUpCubit>()
                      .licenseFileCompany = null;
                  setState(() {});
                },
                attachment: context
                    .read<SignUpCubit>()
                    .licenseFileCompany,
                isNetworkAttachment: false,
                networkAttachmentText: "يوجد مرفق سابق مرفوع",
              ),
              AttachmentPicker(
                title: "السيرة الذاتية",
                condition: context
                    .read<SignUpCubit>()
                    .needCompanyName == 0 &&
                    context
                        .read<SignUpCubit>()
                        .needLicenseNo == 0 &&
                    context
                        .read<SignUpCubit>()
                        .needLicenseFile == 0,
                uploadText: "إرفاق السيرة الذاتية",
                attachedText: "تم إرفاق ملف",
                onTap: () async {
                  hideKeyboard(navigatorKey.currentContext!);
                  context
                      .read<SignUpCubit>()
                      .resumeImage =
                  await context.read<SignUpCubit>().pickFile();
                  setState(() {});
                },
                onRemoveFile: () {
                  context
                      .read<SignUpCubit>()
                      .resumeImage = null;
                  setState(() {});
                },
                attachment: context
                    .read<SignUpCubit>()
                    .resumeImage,
                isNetworkAttachment: false,
                networkAttachmentText: "يوجد مرفق سابق مرفوع",
              ),
              CustomTextFieldPrimary(
                hintText: 'نبذة مختصرة',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء إدخال نبذة مختصرة';
                  }
                  return null;
                },
                type: TextInputType.text,
                typeInputAction: TextInputAction.done,
                externalController: context
                    .read<SignUpCubit>()
                    .aboutController,
                multiLine: true,
                title: 'نبذة مختصرة',
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>
                      {
                        setState(() {
                          _selectDate(context);
                        })
                      },
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
                              selectedDate != null
                                  ? "${selectedDate!.day}/${selectedDate!
                                  .month}/${selectedDate!.year}"
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
              ),
              CustomContainerEditSignUp(
                  title: 'الجنس',
                  child: CustomDropdown(
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار الجنس';
                      }
                      return null;
                    },
                    hintText: "الجنس",
                    items: context
                        .read<SignUpCubit>()
                        .gender
                        .keys
                        .toList(),
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .gender
                          .forEach((key, keyVal) {
                        if (key == value) {
                          context
                              .read<SignUpCubit>()
                              .selectedGender = keyVal;
                        }
                      });
                    },
                  )),
            ]));
      },
    );
  }

  secondStep() {
    return Form(
        key: _formKey2,
        child: Column(children: [
          ConditionalBuilder(
            condition: context
                .read<SignUpCubit>()
                .nationalities != null &&
                context
                    .read<SignUpCubit>()
                    .countries != null,
            builder: (BuildContext context) =>
                Animate(
                  effects: const [
                    FadeEffect(
                      duration: Duration(milliseconds: 500),
                    ),
                  ],
                  child: Column(
                    children: [
                      CustomContainerEditSignUp(
                          title: 'الجنسية',
                          child: CustomDropdown.search(
                            validator: (value) {
                              if (value == null) {
                                return 'الرجاء اختيار الجنسية';
                              }
                              return null;
                            },
                            hintText: "الجنسية",
                            items: context
                                .read<SignUpCubit>()
                                .nationalities!
                                .data!
                                .nationalities,
                            onChanged: (value) {
                              context
                                  .read<SignUpCubit>()
                                  .selectedNationality =
                              value!.id!;
                            },
                          )),
                      CustomContainerEditSignUp(
                          title: 'الدولة',
                          child: CustomDropdown.search(
                            validator: (value) {
                              if (value == null) {
                                return 'الرجاء اختيار الدولة';
                              }
                              return null;
                            },
                            hintText: "الدولة",
                            items: context
                                .read<SignUpCubit>()
                                .countries!
                                .data!
                                .countries,
                            onChanged: (value) {
                              setState(() {
                                context.read<SignUpCubit>().selectCounrty(
                                    value!.regions!, value.id!,
                                    value.phoneCode!);
                              });
                            },
                          )),
                      Visibility(
                        visible: context
                            .read<SignUpCubit>()
                            .selectedCountry != -1,
                        child: ConditionalBuilder(
                          condition:
                          context
                              .read<SignUpCubit>()
                              .regions!
                              .isNotEmpty,
                          builder: (BuildContext context) =>
                              CustomContainerEditSignUp(
                                title: 'المنطقة',
                                child: CustomDropdown<Region>(
                                  hintText: "اختر المنطقة",
                                  items: context
                                      .read<SignUpCubit>()
                                      .regions!,
                                  onChanged: (value) {
                                    setState(() {
                                      context
                                          .read<SignUpCubit>()
                                          .selectRegion(
                                          value!.cities!, value.id!);
                                    });
                                  },
                                ),
                              ),
                          fallback: (BuildContext context) =>
                          const Text("لا يوجد مناطق"),
                        ),
                      ),
                      Visibility(
                        visible: context
                            .read<SignUpCubit>()
                            .selectedRegion != -1,
                        child: ConditionalBuilder(
                          condition: context
                              .read<SignUpCubit>()
                              .cities!
                              .isNotEmpty,
                          builder: (BuildContext context) =>
                              CustomContainerEditSignUp(
                                title: 'المدينة',
                                child: CustomDropdown<City>(
                                  hintText: "اختر المدينة",
                                  items: context
                                      .read<SignUpCubit>()
                                      .cities,
                                  onChanged: (value) {
                                    context
                                        .read<SignUpCubit>()
                                        .selectDistricts(value!.id!);
                                  },
                                ),
                              ),
                          fallback: (BuildContext context) =>
                          const Text("لا يوجد مدين"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () =>
                              {
                                setState(() {
                                  _getCurrentPosition();
                                })
                              },
                              child: Container(
                                height: 50.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: appColors.blue100,
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: ConditionalBuilder(
                                  condition: locationLoading == true,
                                  builder: (BuildContext context) =>
                                  const Center(
                                    child: CupertinoActivityIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  fallback: (BuildContext context) =>
                                      Animate(
                                        effects: [FadeEffect(delay: 200.ms)],
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _currentPosition == null
                                                  ? "اختر الموقع"
                                                  : '${_currentPosition
                                                  ?.latitude}. تم اختيار الموقع',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color: appColors.white,
                                              ),
                                            ),
                                            const Icon(
                                              CupertinoIcons.location,
                                              color: appColors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            fallback: (BuildContext context) =>
            const CupertinoActivityIndicator(),
          ),
        ]));
  }

  thirdStep() {
    return Form(
        key: _formKey3,
        child: Column(children: [
          ConditionalBuilder(
            condition: context
                .read<SignUpCubit>()
                .functionalCases != null &&
                context
                    .read<SignUpCubit>()
                    .sections != null,
            builder: (BuildContext context) =>
                Animate(
                  effects: const [
                    FadeEffect(
                      duration: Duration(milliseconds: 500),
                    ),
                  ],
                  child: Column(
                    children: [
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
                            items: context
                                .read<SignUpCubit>()
                                .idType
                                .keys
                                .toList(),
                            onChanged: (value) {
                              context
                                  .read<SignUpCubit>()
                                  .idType
                                  .forEach((key, keyVal) {
                                if (key == value) {
                                  context
                                      .read<SignUpCubit>()
                                      .idTypeValue = keyVal;
                                }
                                context
                                    .read<SignUpCubit>()
                                    .idFieldFocus
                                    .unfocus();

                                setState(() {
                                  context
                                      .read<SignUpCubit>()
                                      .idController
                                      .clear();
                                });
                              });
                            },
                          )),
                      CustomTextFieldPrimary(
                        hintText: 'رقم الهوية',
                        maxLenght: context
                            .read<SignUpCubit>()
                            .idTypeValue == 2
                            ? null
                            : 10,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الرجاء إدخال رقم الهوية';
                          } else if (context
                              .read<SignUpCubit>()
                              .idTypeValue == 2) {
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
                          context
                              .read<SignUpCubit>()
                              .idTypeValue == 1 ||
                              context
                                  .read<SignUpCubit>()
                                  .idTypeValue == 3
                              ? LengthLimitingTextInputFormatter(10)
                              : FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z0-9]+$')),
                        ],
                        type: context
                            .read<SignUpCubit>()
                            .idTypeValue == 2
                            ? TextInputType.text
                            : TextInputType.number,
                        focusnode: context
                            .read<SignUpCubit>()
                            .idFieldFocus,
                        typeInputAction: TextInputAction.done,
                        externalController:
                        context
                            .read<SignUpCubit>()
                            .idController,
                        multiLine: false,
                        title: 'رقم الهوية',
                      ),
                      AttachmentPicker(
                        title: "نسخة الهوية",
                        condition: true,
                        uploadText: "إرفاق نسخة الهوية (إلزامي)",
                        attachedText: "تم إرفاق ملف",
                        onTap: () async {
                          hideKeyboard(navigatorKey.currentContext!);
                          context
                              .read<SignUpCubit>()
                              .idImage =
                          await context.read<SignUpCubit>().pickFile();
                          setState(() {});
                        },
                        onRemoveFile: () {
                          context
                              .read<SignUpCubit>()
                              .idImage = null;
                          setState(() {});
                        },
                        attachment: context
                            .read<SignUpCubit>()
                            .idImage,
                        isNetworkAttachment: false,
                        networkAttachmentText: "يوجد مرفق هوية مرفوع مسبقاً",
                      ),
                      verticalSpace(10.h),
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
                            items: context
                                .read<SignUpCubit>()
                                .functionalCases!
                                .data!
                                .functionalCases!,
                            onChanged: (value) {
                              context
                                  .read<SignUpCubit>()
                                  .selectedFunctionalCase =
                              value!.id!;
                            },
                          )),
                      CustomContainerEditSignUp(
                          title: 'المهنة',
                          child: CustomDropdown<
                              DigitalGuideCategory>.multiSelectSearch(
                              listValidator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء اختيار المهنة';
                                }
                                return null;
                              },
                              overlayHeight:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                              hintText: "المهنة",
                              items: context
                                  .read<SignUpCubit>()
                                  .sections!
                                  .data!
                                  .digitalGuideCategories,
                              onListChanged: (
                                  List<DigitalGuideCategory> selected) {
                                SignUpCubit signUpCubit =
                                context.read<SignUpCubit>();

                                // Find the index of the first item that should be removed
                                int index = signUpCubit
                                    .selectedSectionsNeedLicense
                                    .indexWhere(
                                      (item) => !selected.contains(item),
                                );

                                // Remove items at the found index
                                if (index != -1) {
                                  signUpCubit.selectedSectionsNeedLicense
                                      .removeAt(index);
                                  signUpCubit.selectedSectionsNeedLicenseText
                                      .removeAt(index);
                                  signUpCubit.selectedSectionsNeedLicenseFiles
                                      .removeAt(index);
                                }

                                // Update the selectedSections and selectedSectionsNeedLicense
                                signUpCubit.selectedSections = selected;
                                for (DigitalGuideCategory i in selected) {
                                  if (i.needLicense == 1 &&
                                      !signUpCubit.selectedSectionsNeedLicense
                                          .contains(i)) {
                                    signUpCubit.selectedSectionsNeedLicense.add(
                                        i);
                                    signUpCubit.selectedSectionsNeedLicenseText
                                        .add(TextEditingController());
                                    signUpCubit.selectedSectionsNeedLicenseFiles
                                        .add(null);
                                  }
                                }

                                // Trigger a rebuild
                                setState(() {});
                              })),
                      ListView.separated(
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.9,
                                    child: CustomTextFieldPrimary(
                                      maxLenght: 14,
                                      hintText:
                                      'رقم الترخيص ل${context
                                          .read<SignUpCubit>()
                                          .selectedSectionsNeedLicense[index]
                                          .title}',
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length > 14) {
                                          return 'يرجى إدخال رقم ترخيص';
                                        }
                                        // You can add additional validation rules if needed
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9\-_]')),
                                        // Allow digits, hyphen, and underscore
                                        LengthLimitingTextInputFormatter(14),
                                        // Limit the length to 14 characters
                                      ],
                                      type: TextInputType.number,
                                      typeInputAction: TextInputAction.done,
                                      externalController: context
                                          .read<SignUpCubit>()
                                          .selectedSectionsNeedLicenseText[index],
                                      multiLine: false,
                                      title: 'رقم الترخيص',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async =>
                                    {
                                      hideKeyboard(
                                          navigatorKey.currentContext!),
                                      context
                                          .read<SignUpCubit>()
                                          .selectedSectionsNeedLicenseFiles[
                                      index] =
                                      await context
                                          .read<SignUpCubit>()
                                          .pickFile(),
                                      setState(() {})
                                    },
                                    onLongPress: () {
                                      context
                                          .read<SignUpCubit>()
                                          .selectedSectionsNeedLicenseFiles[
                                      index] = null;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 70.w,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      decoration: BoxDecoration(
                                        color: context
                                            .read<SignUpCubit>()
                                            .selectedSectionsNeedLicenseFiles[
                                        index] !=
                                            null
                                            ? appColors.green
                                            : appColors.blue100,
                                        borderRadius: BorderRadius.circular(
                                            12.sp),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
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
                                  Visibility(
                                    visible: context
                                        .read<SignUpCubit>()
                                        .selectedSectionsNeedLicenseFiles[
                                    index] !=
                                        null,
                                    child: Animate(
                                      effects: [FadeEffect(delay: 200.ms)],
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<SignUpCubit>()
                                              .selectedSectionsNeedLicenseFiles[
                                          index] = null;
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: appColors
                                                .red5, // Light red color for the circle background
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          // Adjust the padding as needed
                                          child: const Icon(
                                            Icons.delete,
                                            color: appColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              verticalSpace(10.h),
                          itemCount: context
                              .read<SignUpCubit>()
                              .selectedSectionsNeedLicense
                              .length),
                      Visibility(
                        visible: context
                            .read<SignUpCubit>()
                            .selectedSectionsNeedLicense
                            .isNotEmpty,
                        child: Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0), // زاوية الحواف
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                  // علامة صح
                                  SizedBox(width: 8.0),
                                  // مسافة بين العلامة والنص
                                  Text("png, jpg, jpeg, pdf"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(10.h),
                      ConditionalBuilder(
                        condition: context
                            .read<SignUpCubit>()
                            .degrees != null &&
                            context
                                .read<SignUpCubit>()
                                .generalSpecialty != null &&
                            context
                                .read<SignUpCubit>()
                                .accurateSpecialty != null &&
                            context
                                .read<SignUpCubit>()
                                .langs != null,
                        builder: (BuildContext context) =>
                            Animate(
                              effects: const [
                                FadeEffect(
                                  duration: Duration(milliseconds: 500),
                                ),
                              ],
                              child: Column(
                                children: [
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
                                        items: context
                                            .read<SignUpCubit>()
                                            .degrees!
                                            .data!
                                            .degrees,
                                        onChanged: (value) {
                                          context
                                              .read<SignUpCubit>()
                                              .selectedDegree =
                                          value!.id!;

                                          setState(() {
                                            if (value.needCertificate == 1) {
                                              context
                                                  .read<SignUpCubit>()
                                                  .selectedDegreeNeedCertificate =
                                              true;
                                            } else {
                                              context
                                                  .read<SignUpCubit>()
                                                  .selectedDegreeNeedCertificate =
                                              false;
                                            }
                                            if (value.isSpecial == 1) {
                                              context
                                                  .read<SignUpCubit>()
                                                  .selectedDegreeIsSpecial =
                                              true;
                                            } else {
                                              context
                                                  .read<SignUpCubit>()
                                                  .selectedDegreeIsSpecial =
                                              false;
                                            }
                                          });
                                        },
                                      )),
                                  AttachmentPicker(
                                    title: "مرفق الدرجة العلمية",
                                    condition: () {
                                      final cubit = context.read<SignUpCubit>();
                                      final needsLicenseEmpty =
                                          cubit.selectedSectionsNeedLicense
                                              .isEmpty;
                                      final needsCertificate =
                                          cubit.selectedDegreeNeedCertificate;
                                      final isSpecial = cubit
                                          .selectedDegreeIsSpecial;
                                      final isDegree4 = cubit.selectedDegree ==
                                          4;

                                      return (needsLicenseEmpty &&
                                          needsCertificate) ||
                                          isSpecial == true ||
                                          isDegree4;
                                    }(),
                                    uploadText: "إرفاق إثبات الدرجة العلمية (إلزامي)",
                                    attachedText: "تم إرفاق ملف",
                                    onTap: () async {
                                      hideKeyboard(
                                          navigatorKey.currentContext!);
                                      context
                                          .read<SignUpCubit>()
                                          .degreeVerifyImage =
                                      await context.read<SignUpCubit>()
                                          .pickFile();

                                      setState(() {});
                                    },
                                    onRemoveFile: () {
                                      context
                                          .read<SignUpCubit>()
                                          .degreeVerifyImage =
                                      null;
                                      print("remove file");
                                      setState(() {});
                                    },
                                    attachment:
                                    context
                                        .read<SignUpCubit>()
                                        .degreeVerifyImage,
                                    isNetworkAttachment: false,
                                    networkAttachmentText: "يوجد مرفق سابق مرفوع",
                                  ), // text form if the degree id is 4
                                  Visibility(
                                    visible:
                                    context
                                        .read<SignUpCubit>()
                                        .selectedDegree == 4,
                                    child: CustomTextFieldPrimary(
                                      hintText: 'التخصص',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'الرجاء إدخال التخصص';
                                        }
                                        return null;
                                      },
                                      type: TextInputType.text,
                                      typeInputAction: TextInputAction.done,
                                      externalController: context
                                          .read<SignUpCubit>()
                                          .degreeOtherSpecialtyController,
                                      multiLine: false,
                                      title: 'التخصص',
                                    ),
                                  ),

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
                                        items: context
                                            .read<SignUpCubit>()
                                            .generalSpecialty!
                                            .data!
                                            .generalSpecialty,
                                        onChanged: (value) {
                                          context
                                              .read<SignUpCubit>()
                                              .selectedGeneralSpecialty =
                                          value!.id!;
                                        },
                                      )),
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
                                        items: context
                                            .read<SignUpCubit>()
                                            .accurateSpecialty!
                                            .data!
                                            .accurateSpecialty,
                                        onChanged: (value) {
                                          context
                                              .read<SignUpCubit>()
                                              .selectedAccurateSpecialty =
                                          value!.id!;
                                        },
                                      )),
                                  CustomContainerEditSignUp(
                                      title: 'اللغات الأخرى',
                                      child: CustomDropdown.multiSelectSearch(
                                        hintText: "اللغات",
                                        items: context
                                            .read<SignUpCubit>()
                                            .langs!
                                            .data!
                                            .languages,
                                        onListChanged: (p0) {
                                          context
                                              .read<SignUpCubit>()
                                              .selectedLanguages = p0;
                                        },
                                      )),
                                ],
                              ),
                            ),
                        fallback: (BuildContext context) =>
                        const CupertinoActivityIndicator(),
                      ),
                    ],
                  ),
                ),
            fallback: (BuildContext context) =>
            const CupertinoActivityIndicator(),
          ),
        ]));
  }

  fourthStep() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttachmentPicker(
                title: "الصورة الشخصية",
                condition: true,
                uploadText: "إرفاق الصورة الشخصية (اختياري)",
                attachedText: "تم إرفاق ملف",
                onTap: () async {
                  hideKeyboard(navigatorKey.currentContext!);
                  context
                      .read<SignUpCubit>()
                      .profileImage =
                  await context.read<SignUpCubit>().pickImage();
                  setState(() {});
                },
                onRemoveFile: () {
                  context
                      .read<SignUpCubit>()
                      .profileImage = null;
                  setState(() {});
                },
                attachment: context
                    .read<SignUpCubit>()
                    .profileImage,
                isNetworkAttachment: false,
                networkAttachmentText: "يوجد مرفق صورة شخصية مرفوع مسبقاً",
              ),
              verticalSpace(20.h),
              AttachmentPicker(
                title: "الشعار",
                condition: true,
                uploadText: "إرفاق الشعار (الزامي للشركات والمؤسسات)",
                attachedText: "تم إرفاق ملف",
                onTap: () async {
                  hideKeyboard(navigatorKey.currentContext!);
                  context
                      .read<SignUpCubit>()
                      .logoImage =
                  await context.read<SignUpCubit>().pickImage();
                  context
                      .read<SignUpCubit>()
                      .isNetworkImageLogo = false;
                  setState(() {});
                },
                onRemoveFile: () {
                  context
                      .read<SignUpCubit>()
                      .logoImage = null;
                  context
                      .read<SignUpCubit>()
                      .isNetworkImageLogo = false;
                  setState(() {});
                },
                attachment: context
                    .read<SignUpCubit>()
                    .logoImage,
                isNetworkAttachment:
                context
                    .read<SignUpCubit>()
                    .isNetworkImageLogo!,
                networkAttachmentText: "يوجد مرفق شعار مرفوع مسبقاً",
              ),
              verticalSpace(20.h),
            ],
          ),
        ),
        CustomAuthTextFieldWithOutValidate(
            hintText: 'رمز الدعوة',
            externalController: context
                .read<SignUpCubit>()
                .refController,
            title: 'رمز الدعوة'),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    setState(() {
      if (picked != null && picked != selectedDate) selectedDate = picked;
    });
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      locationLoading = true;
    });

    final hasPermission = await _getLocation();
    if (!hasPermission) {
      setState(() {
        locationLoading = false;
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() => _currentPosition = position);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        locationLoading = false;
      });
    }
  }

  Future<bool> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationLoading = false;
      });

      // عرض حوار يطلب من المستخدم فتح إعدادات الموقع
      bool? openSettings = await _showLocationServiceDialog();
      if (openSettings != null && openSettings) {
        _openLocationSettings();
      }

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم رفض أذونات الموقع')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('تم رفض أذونات الموقع بشكل دائم، لا يمكننا طلب الأذونات.'),
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool?> _showLocationServiceDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خدمة الموقع معطلة'),
          content: const Text('يرجى تفعيلها من خلال الإعدادات.'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('فتح الإعدادات'),
              onPressed: () async {
                Navigator.of(context).pop(true);
                if (Platform.isAndroid) {
                  _openLocationSettings(); // فتح إعدادات الموقع
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _openLocationSettings() {
    // سيفتح إعدادات الموقع على الجهاز باستخدام android_intent_plus
    const intent = AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    intent.launch().catchError((e) {
      print('خطأ في إطلاق النية: $e');
    });
  }

  Future<FormData> _supmitForm() async {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();

    Map<String, dynamic> formData = {
      'first_name': widget.data['first_name'],
      'second_name': widget.data['second_name'],
      'fourth_name': widget.data['fourth_name'],
      'email': widget.data['email'],
      'phone': widget.data['phoneWithOutCode'],
      'phone_code': widget.data['country_code'],
      'password': widget.data['password'],
      'password_confirmation': widget.data['password_confirmation'],
      'accept_rules': '1', //widget.data['accept_rules'],
      'about': signUpCubit.aboutController.text,
      'birth_day': selectedDate!.day.toString(),
      'birth_month': selectedDate!.month.toString(),
      'birth_year': selectedDate!.year.toString(),
      'gender': signUpCubit.selectedGender,
      'degree': signUpCubit.selectedDegree,
      'general_specialty': signUpCubit.selectedGeneralSpecialty,
      'accurate_specialty': signUpCubit.selectedAccurateSpecialty,
      'nationality': signUpCubit.selectedNationality,
      'country': signUpCubit.selectedCountry,
      'longitude': _currentPosition!.longitude.toString(),
      'latitude': _currentPosition!.latitude.toString(),
      'type': signUpCubit.accountTypeValue,
      'identity_type': signUpCubit.idTypeValue,
      'nat_id': signUpCubit.idController.text,
      'functional_cases': signUpCubit.selectedFunctionalCase,
    };

    FormData form = FormData.fromMap(formData);

    // ref code
    if (signUpCubit.refController.text.isNotEmpty) {
      form.fields.add(MapEntry('referred_by', signUpCubit.refController.text));
    }

    if (widget.data['third_name'] == null ||
        widget.data['third_name'] == '') {} else {
      form.fields.add(MapEntry('third_name', widget.data['third_name']));
    }

    if (context
        .read<SignUpCubit>()
        .selectedDegree == 4) {
      form.fields.add(MapEntry(
          'other_degree', signUpCubit.degreeOtherSpecialtyController.text));
    }

    for (int i = 0; i < signUpCubit.selectedLanguages!.length; i++) {
      form.fields.add(MapEntry(
          'languages[$i]', signUpCubit.selectedLanguages![i].id.toString()));
    }

    int licenseIndex = 0;
    for (int index = 0; index < signUpCubit.selectedSections.length; index++) {
      DigitalGuideCategory section = signUpCubit.selectedSections[index];

      // Add section without license
      if (!signUpCubit.selectedSectionsNeedLicense.contains(section)) {
        form.fields.add(MapEntry('sections[$index]', section.id.toString()));
      }
      // Add section with license
      else {
        form.fields.add(MapEntry('sections[$index]', section.id.toString()));

        // Check if licenseIndex is within bounds before accessing the lists
        if (licenseIndex < signUpCubit.selectedSectionsNeedLicenseText.length &&
            licenseIndex <
                signUpCubit.selectedSectionsNeedLicenseFiles.length) {
          form.fields.add(MapEntry('licence_no[${section.id}]',
              signUpCubit.selectedSectionsNeedLicenseText[licenseIndex].text));

          if (signUpCubit.selectedSectionsNeedLicenseFiles[licenseIndex] !=
              null) {
            form.files.add(MapEntry(
              'license_file[${section.id}]',
              MultipartFile.fromFileSync(signUpCubit
                  .selectedSectionsNeedLicenseFiles[licenseIndex]!.path),
            ));
          }
        }

        // Increment licenseIndex for the next iteration
        licenseIndex++;
      }
    }
    //personal photo un reqquired
    if (context
        .read<SignUpCubit>()
        .profileImage != null) {
      form.files.add(MapEntry(
          "photo",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .profileImage!
                  .path)));
    }

    //logo un reqquired
    if (context
        .read<SignUpCubit>()
        .logoImage != null) {
      //logo requierd if type is == 2 || 3
      form.files.add(MapEntry(
          "logo",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .logoImage!
                  .path)));
    }

    //
    //company_lisences_file
    // company_name
    // company_lisences_no
    // check if company name is required or file is required or number is required to add into form data

    if (context
        .read<SignUpCubit>()
        .needCompanyName == 1) {
      form.fields.add(MapEntry('company_name',
          context
              .read<SignUpCubit>()
              .companyNameController
              .text));
    }

    if (context
        .read<SignUpCubit>()
        .needLicenseNo == 1) {
      form.fields.add(MapEntry('company_lisences_no',
          context
              .read<SignUpCubit>()
              .licenseNoController
              .text));
    }

    if (context
        .read<SignUpCubit>()
        .needLicenseFile == 1) {
      form.files.add(MapEntry(
          "company_lisences_file",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .licenseFileCompany!
                  .path)));
    }

    // check if cournty is saudi arabia to add region and city
    if (signUpCubit.selectedCountryPhoneCode == 966) {
      form.fields
          .add(MapEntry('region', signUpCubit.selectedRegion.toString()));
      form.fields
          .add(MapEntry('city', signUpCubit.selectedDistricts.toString()));
    }

    if (context
        .read<SignUpCubit>()
        .resumeImage != null) {
      //
      form.files.add(MapEntry(
          "cv",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .resumeImage!
                  .path)));
    }
    if (context
        .read<SignUpCubit>()
        .idImage != null) {
      form.files.add(MapEntry(
          "id_file",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .idImage!
                  .path)));
    }
    if (context
        .read<SignUpCubit>()
        .degreeVerifyImage != null) {
      form.files.add(MapEntry(
          "degree_certificate",
          MultipartFile.fromFileSync(
              context
                  .read<SignUpCubit>()
                  .degreeVerifyImage!
                  .path)));
    }
    return form;
  }
}
