import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/services/profile_validation_service.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/steps/zero_step_form.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/steps/first_step_form.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/steps/second_step_form.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/steps/third_step_form.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/steps/fourth_step_form.dart';

import '../../../../../../config/themes/styles.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../l10n/locale_keys.g.dart';
import '../../../../../../main.dart';
import '../../../../../../yamtaz.dart';
import '../../../../../auth/sign_up/presentation/view/widgets/pin_code.dart';
import '../../../logic/my_account_cubit.dart';

class EditProileStepsProvider extends StatefulWidget {
  const EditProileStepsProvider({super.key, required this.data});

  final Map data;

  @override
  State<EditProileStepsProvider> createState() => _StepsSignUpState();
}

class _StepsSignUpState extends State<EditProileStepsProvider> {
  // Use ValueNotifier instead of regular variables
  final ValueNotifier<int> _currentStepNotifier = ValueNotifier(0);
  late final GlobalKey<FormState> _formKey1;
  late final GlobalKey<FormState> _formKey2;
  late final GlobalKey<FormState> _formKey3;
  late final GlobalKey<FormState> _formKeyInfo;
  String? oldPhone;
  String? oldPhoneCode;
  final ValueNotifier<bool> isVerifiedNotifier = ValueNotifier(true);
  String? phone;
  // late final GlobalKey<FormState> _formKey4;
  // late final GlobalKey<FormState> _formKey5;

  // Use ValueNotifier for loading state
  final ValueNotifier<bool> locationLoadingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _formKey1 = GlobalKey<FormState>();
    _formKeyInfo = GlobalKey<FormState>();
    _formKey2 = GlobalKey<FormState>();
    _formKey3 = GlobalKey<FormState>();
    oldPhone = getit<MyAccountCubit>().userDataResponse!.data!.account!.phone;
    oldPhoneCode = getit<MyAccountCubit>()
        .userDataResponse!
        .data!
        .account!
        .phoneCode
        .toString();
    // _formKey4 = GlobalKey<FormState>();
    // _formKey5 = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // Dispose value notifiers to prevent memory leaks
    _currentStepNotifier.dispose();
    locationLoadingNotifier.dispose();
    isVerifiedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (_currentStepNotifier.value > 0) {
              // If the current step is not the first step, go back one step
              _currentStepNotifier.value--;
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
            child: ConditionalBuilder(
              condition: context.read<SignUpCubit>().isLoading == false,
              builder: (BuildContext context) => Animate(
                effects: [FadeEffect(delay: 200.ms)],
                child: Column(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _currentStepNotifier,
                        builder: (context, currentStep, child) {
                          return Theme(
                            data: ThemeData(
                                // backgroundColor: appColors.white,
                                colorScheme: const ColorScheme.light(
                                    primary: appColors.primaryColorYellow)),
                            child: Stepper(
                              elevation: 0.5,
                              controlsBuilder: (context, details) {
                                return Padding(
                                  padding: EdgeInsets.all(16.0.sp),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      verticalSpace(
                                        20.h,
                                      ),
                                      CustomButton(
                                        onPress: details.onStepContinue,
                                        title: currentStep == 4
                                            ? "إرسال الطلب"
                                            : 'التالي',
                                      ),
                                      verticalSpace(
                                        20.h,
                                      ),
                                      currentStep > 0
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
                              currentStep: currentStep,
                              onStepTapped: (step) => tapped(step),
                              onStepContinue: _continue,
                              onStepCancel: cancel,
                              steps: <Step>[
                                Step(
                                  title: Text(''),
                                  content: zeroStep(),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 0
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(''),
                                  content: firstStep(),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 1
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(''),
                                  content: secondStep(),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 2
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(''),
                                  content: thirdStep(),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 3
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(''),
                                  content: fourthStep(),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 4
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (BuildContext context) => SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(),
                    verticalSpace(10.h),
                    const Text("جاري تحميل البيانات")
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }

  void tapped(int step) {
    _currentStepNotifier.value = step;
  }

  Future<void> _continue() async {
    if (_currentStepNotifier.value == 0) {
      hideKeyboard(navigatorKey.currentContext!);
      _handleStep0();
    } else if (_currentStepNotifier.value == 1) {
      hideKeyboard(navigatorKey.currentContext!);

      _handleStep1();
    } else if (_currentStepNotifier.value == 2) {
      hideKeyboard(navigatorKey.currentContext!);

      _handleStep2();
    } else if (_currentStepNotifier.value == 3) {
      hideKeyboard(navigatorKey.currentContext!);

      _handleStep3();
    } else {
      await _finalStep();
    }
  }

  void _handleStep0() {
    print(oldPhone == context.read<SignUpCubit>().phoneController.text);

    print("------------");

    // استخدام خدمة التحقق الجديدة
    bool isValid = ProfileValidationService.validateStep0(
      context: context,
      formKey: _formKeyInfo,
      oldPhone: oldPhone!,
      oldPhoneCode: oldPhoneCode!,
    );

    if (isValid) {
      _advanceStep();
    }
  }

  void _handleStep1() {
    // استخدام خدمة التحقق الجديدة
    bool isValid = ProfileValidationService.validateStep1(
      context: context,
      formKey: _formKey1,
    );

    if (isValid) {
      _advanceStep();
    }
  }

  void _handleStep2() {
    // استخدام خدمة التحقق الجديدة للخطوة الثانية
    bool isValid = ProfileValidationService.validateStep2(
      context: context,
      formKey: _formKey2,
    );

    if (isValid) {
      _advanceStep();
    }
  }

  void _handleStep3() {
    // استخدام خدمة التحقق الجديدة للخطوة الثالثة
    bool isValid = ProfileValidationService.validateStep3(
      context: context,
      formKey: _formKey3,
    );

    if (isValid) {
      _advanceStep();
    }
  }

  Future<void> _finalStep() async {
    final cubit = context.read<SignUpCubit>();
    if (cubit.logoImage == null &&
        (cubit.accountTypeValue == 2 || cubit.accountTypeValue == 3) &&
        !cubit.isNetworkImageCompany!) {
      _showAlert("يرجى إرفاق شعار الشركة");
    } else {
      FormData userData = await _supmitForm();
      cubit.emitEditProviderState(userData);
    }
  }

  void _advanceStep() {
    _currentStepNotifier.value += 1;
    print(_currentStepNotifier.value);
  }

  void _showAlert(String message) {
    ProfileValidationService.showErrorMessage(
      context: context,
      message: message,
    );
  }

  void cancel() {
    _currentStepNotifier.value > 0 ? _currentStepNotifier.value -= 1 : null;
  }

  void showOtpDialog(BuildContext context, SignUpCubit cubit) {
    bool isTimerFinished = false;
    showDialog(
      context: context,
      barrierDismissible: kDebugMode ? true : false,
      // Prevent dismissing the dialog
      builder: (context) {
        return BlocProvider(
          create: (context) => getit<SignUpCubit>(),
          child: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                backgroundColor: appColors.white,
                surfaceTintColor: appColors.white,
                title: Text(
                  'أدخل رمز التحقق',
                  style: TextStyles.cairo_12_bold,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PinCodeAlertWidget(
                      pinOtpController: cubit.otpController,
                    ),
                    verticalSpace(10.h),
                    Container(
                      alignment: Alignment.center,
                      child: isTimerFinished == true
                          ? InkWell(
                              onTap: () {
                                cubit.validatePhone(cubit.phoneController.text,
                                    cubit.providerphoneCode);
                                phone = cubit.phoneController.text;

                                setState(() {
                                  isTimerFinished = false;
                                });
                                context.pop();
                              },
                              child: Text(
                                "إعادة الإرسال",
                                style: TextStyle(
                                    color: appColors.primaryColorYellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لم يصلك الرمز؟",
                                  style: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                TimerCountdown(
                                  endTime: DateTime.now().add(
                                    const Duration(
                                      minutes: 0,
                                      seconds: 180,
                                    ),
                                  ),
                                  onEnd: () {
                                    setState(() {
                                      isTimerFinished = true;
                                    });
                                  },
                                  colonsTextStyle: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                  timeTextStyle: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                  spacerWidth: 3.w,
                                  enableDescriptions: false,
                                  format: CountDownTimerFormat.secondsOnly,
                                ),
                              ],
                            ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        cubit.verifyPhoneOtp(
                          phone!,
                          "966",
                          cubit.otpController.text,
                        );
                      },
                      child: Text(

                        'تحقق',
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.primaryColorYellow),
                      )),
                ],
              );
            },
          ),
        );
      },
    );
  }

  StatefulBuilder zeroStep() {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();
    oldPhone = signUpCubit.phoneController.text;
    oldPhoneCode = signUpCubit.providerphoneCode;

    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) =>
              BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is LoadingSignUpProviderOtp ||
            current is SuccessSignUpProviderOtp ||
            current is ErrorSignUpProviderOtp ||
            current is LoadingSignUpProviderOtpEdit ||
            current is SuccessSignUpProviderOtpEdit ||
            current is ErrorSignUpProviderOtpEdit,
        listener: (context, state) {
          state.whenOrNull(
            //send otp code
            loadingSignUpProviderOtp: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successSignUpProviderOtp: (otp) {
              context.pop();
              showOtpDialog(context, context.read<SignUpCubit>());
            },
            errorSignUpProviderOtp: (error) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            },

            //verify otp code
            loadingSignUpProviderOtpEdit: () {
              AnimatedSnackBar.material(
                "جاري التحقق من الرمز",
                type: AnimatedSnackBarType.info,
              ).show(context);
            },
            successSignUpProviderOtpEdit: (verify) {
              context.pop();
              AnimatedSnackBar.material(
                "تم التحقق من الهاتف بنجاح",
                type: AnimatedSnackBarType.success,
              ).show(context);
              oldPhone = signUpCubit.phoneController.text;
              oldPhoneCode = signUpCubit.providerphoneCode;
              isVerifiedNotifier.value = true;

              setState(() {});
            },
            errorSignUpProviderOtpEdit: (error) {
              AnimatedSnackBar.material(
                error,
                type: AnimatedSnackBarType.info,
              ).show(context);
            },
          );
        },
        builder: (context, state) {
          return ZeroStepForm(
            formKey: _formKeyInfo,
            oldPhone: oldPhone!,
            oldPhoneCode: oldPhoneCode!,
            onConfirmPhone: () {
              signUpCubit.validatePhone(
                signUpCubit.phoneController.text,
                signUpCubit.providerphoneCode
              );
              phone = signUpCubit.phoneController.text;
            },
            onPhoneChanged: (newPhone) {
              // Phone number changed - can add additional logic if needed
            },
          );
        },
      ),
    );
  }

  StatefulBuilder firstStep() {
    return StatefulBuilder(
      builder: (context, setState) {
        return FirstStepForm(
          formKey: _formKey1,
          selectDateCallback: (BuildContext context) {
            setState(() {
              _selectDate(context);
            });
          },
        );
      },
    );
  }

  ValueListenableBuilder<bool> secondStep() {
    return ValueListenableBuilder(
      valueListenable: locationLoadingNotifier,
      builder: (context, locationLoading, child) {
        return SecondStepForm(
          formKey: _formKey2,
          locationLoading: locationLoading,
          onGetCurrentPosition: () {
            _getCurrentPosition();
          },
        );
      },
    );
  }

  StatefulBuilder thirdStep() {
    return StatefulBuilder(
      builder: (context, setState) {
        return ThirdStepForm(
          formKey: _formKey3,
          setStateCallback: setState,
        );
      },
    );
  }

  StatefulBuilder fourthStep() {
    return StatefulBuilder(
      builder: (context, setState) {
        return FourthStepForm(
          setStateCallback: setState,
        );
      },
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
      if (picked != null &&
          picked != context.read<SignUpCubit>().selectedBirthDate) {
        context.read<SignUpCubit>().selectedBirthDate = picked;
      }
    });
  }

  Future<void> _getCurrentPosition() async {
    locationLoadingNotifier.value = true;

    final hasPermission = await _getLocation();
    if (!hasPermission) {
      locationLoadingNotifier.value = false;
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      context.read<SignUpCubit>().currentPositionUser = position;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      locationLoadingNotifier.value = false;
    }
  }

  Future<bool> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationLoadingNotifier.value = false;

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
  debugPrint("عرض حوار خدمة الموقع");
  const Color navyBlue = Color(0xFF00262f);
  const Color goldColor = Color(0xFFDDB762);
  const Color whiteColor = Colors.white;

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: goldColor, width: 2),
        ),
        title: Row(
          children: [
            const Icon(Icons.location_off, color: goldColor),
            const SizedBox(width: 10),
            // الحل هنا: تغليف النص بـ Expanded لمنع الـ Overflow
            Expanded(
              child: Text(
                'خدمة الموقع معطلة',
                style: TextStyle(
                  color: navyBlue, 
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // يمكنك تصغير الخط قليلاً إذا لزم الأمر
                ),
                softWrap: true, // السماح للنص بالنزول لسطر جديد
                overflow: TextOverflow.visible, 
              ),
            ),
          ],
        ),
        content: const Text(
          'لتقديم أفضل خدمة، يرجى تفعيل الموقع من خلال الإعدادات.',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'إلغاء',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: navyBlue,
              foregroundColor: goldColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            onPressed: () async {
              Navigator.of(context).pop(true);
              if (Platform.isAndroid) {
                _openLocationSettings();
              }
            },
            child: const Text(
              'فتح الإعدادات',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
      print('خطأ : $e');
    });
  }

  // bool _validateStep(GlobalKey<FormState> formKeyF) {
  //   final form = formKeyF.currentState;
  //   if (form != null && form.validate()) {
  //     if (context.read<SignUpCubit>().selectedBirthDate == null) {
  //       return false;
  //     }
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

  Future<FormData> _supmitForm() async {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();

    Map<String, dynamic> formData = {
      "first_name": signUpCubit.providerFirstNameController.text,
      "account_type": 'lawyer',
      "second_name": signUpCubit.providerSecondNameController.text,
      "fourth_name": signUpCubit.providerFourthNameController.text,
      "email": signUpCubit.emailController.text,
      "phone": signUpCubit.phoneController.text,
      'about': signUpCubit.aboutController.text,
      'phone_code': signUpCubit.providerphoneCode,
      'day': context.read<SignUpCubit>().selectedBirthDate!.day.toString(),
      'month': context.read<SignUpCubit>().selectedBirthDate!.month.toString(),
      'year': context.read<SignUpCubit>().selectedBirthDate!.year.toString(),
      'gender': signUpCubit.selectedGender,
      'degree': signUpCubit.selectedDegree,
      'general_specialty': signUpCubit.selectedGeneralSpecialty,
      'accurate_specialty': signUpCubit.selectedAccurateSpecialty,
      'nationality_id': signUpCubit.selectedNationality,
      'country_id': signUpCubit.selectedCountry,
      'longitude':
      context.read<SignUpCubit>().currentPositionUser!.longitude.toString(),
      'latitude':
      context.read<SignUpCubit>().currentPositionUser!.latitude.toString(),
      'type': signUpCubit.accountTypeValue,
      'identity_type': signUpCubit.idTypeValue,
      'national_id': signUpCubit.idController.text,
      'functional_cases': signUpCubit.selectedFunctionalCase,
      'region_id': signUpCubit.selectedRegion.toString(),
      'city_id': signUpCubit.selectedDistricts.toString(),
    };

    FormData form = FormData.fromMap(formData);
    for (int i = 0; i < signUpCubit.selectedLanguages!.length; i++) {
      form.fields.add(MapEntry(
          'languages[$i]', signUpCubit.selectedLanguages![i].id.toString()));
    }

    if (signUpCubit.otpController.text.isNotEmpty) {
      form.fields.add(MapEntry('otp', signUpCubit.otpController.text));
    }

    if (signUpCubit.providerThirdNameController.text.isNotEmpty) {
      form.fields.add(
          MapEntry('third_name', signUpCubit.providerThirdNameController.text));
    }
// لو المستخدم فرد و لا يجب وضع اسم ورقم تجاري و ملف التجاري وليس لديه صوره على الانترنت يمكنه الرفع يجب رفع ملف السي في
    if (context.read<SignUpCubit>().resumeImage != null &&
        context.read<SignUpCubit>().needCompanyName == 0 &&
        context.read<SignUpCubit>().needLicenseNo == 0 &&
        context.read<SignUpCubit>().needLicenseFile == 0 &&
        (signUpCubit.isNetworkImageCv == false ||
            signUpCubit.isNetworkImageCv == null)) {
      form.files.add(MapEntry(
          "cv_file",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().resumeImage!.path)));
    }

    if (signUpCubit.selectedDegree == 4) {
      form.fields.add(MapEntry(
          'other_degree', signUpCubit.degreeOtherSpecialtyController.text));
    }

//
    //company_lisences_file
    // company_name
    // company_lisences_no
    // check if company name is required or file is required or number is required to add into form data
    if (context.read<SignUpCubit>().needCompanyName == 1) {
      form.fields.add(MapEntry('company_name',
          context.read<SignUpCubit>().companyNameController.text));
    }

    if (context.read<SignUpCubit>().needLicenseNo == 1) {
      form.fields.add(MapEntry('company_licences_no',
          context.read<SignUpCubit>().licenseNoController.text));
    }

    if (context.read<SignUpCubit>().needLicenseFile == 1 &&
        context.read<SignUpCubit>().licenseFileCompany != null &&
        (context.read<SignUpCubit>().isNetworkImageCompany == false ||
            context.read<SignUpCubit>().isNetworkImageCompany == null)) {
      form.files.add(MapEntry(
          "company_license_file",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().licenseFileCompany!.path)));
    }

    // // check if cournty is saudi arabia to add region and city
    //   form.fields
    //       .add(MapEntry('region', signUpCubit.selectedRegion.toString()));
    //   form.fields
    //       .add(MapEntry('city', signUpCubit.selectedDistricts.toString()));

    if (context.read<SignUpCubit>().idImage != null &&
        (context.read<SignUpCubit>().isNetworkImageId == false ||
            context.read<SignUpCubit>().isNetworkImageId == null)) {
      form.files.add(MapEntry(
          "national_id_image",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().idImage!.path)));
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
          form.fields.add(MapEntry('license_no[${section.id}]',
              signUpCubit.selectedSectionsNeedLicenseText[licenseIndex].text));

          if (signUpCubit.selectedSectionsNeedLicenseFiles[licenseIndex] !=
              null) {
            form.files.add(MapEntry(
              'license_image[${section.id}]',
              MultipartFile.fromFileSync(signUpCubit
                  .selectedSectionsNeedLicenseFiles[licenseIndex]!.path),
            ));
          }
        }

        // Increment licenseIndex for the next iteration
        licenseIndex++;
      }
    }


    // Fix the parentheses in the condition and add a proper null check
    if ((context.read<SignUpCubit>().degreeVerifyImage != null &&
        (context.read<SignUpCubit>().isNetworkImageDegree == false ||
            context.read<SignUpCubit>().isNetworkImageDegree == null) &&
        context.read<SignUpCubit>().selectedSectionsNeedLicense.isEmpty) ||
        signUpCubit.selectedDegree == 4 && context.read<SignUpCubit>().degreeVerifyImage != null) {
      form.files.add(MapEntry(
          "degree_certificate",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().degreeVerifyImage!.path)));
    }

    //personal photo un reqquired
    if (context.read<SignUpCubit>().profileImage != null &&
        (context.read<SignUpCubit>().isNetworkImageProfile == false ||
            context.read<SignUpCubit>().isNetworkImageProfile == null)) {
      form.files.add(MapEntry(
          "profile_photo",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().profileImage!.path)));
    }

    //logo un reqquired
    if (context.read<SignUpCubit>().logoImage != null &&
        (context.read<SignUpCubit>().isNetworkImageLogo == false ||
            context.read<SignUpCubit>().isNetworkImageLogo == null)) {
      //logo requierd if type is == 2 || 3
      form.files.add(MapEntry(
          "logo",
          MultipartFile.fromFileSync(
              context.read<SignUpCubit>().logoImage!.path)));
    }
    return form;
  }

  void viewImage(BuildContext context, File? image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('X'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
