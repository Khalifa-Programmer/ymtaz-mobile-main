import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/custom_phone_input.dart';
import 'package:yamtaz/feature/auth/register/logic/register_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/terms_and_conditions.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/validators.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_decoration_style.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../core/widgets/textform_auth_field.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../sign_up/presentation/view/widgets/pin_code.dart';

class RegestirationScreen extends StatefulWidget {
  const RegestirationScreen({super.key, required this.type});

  final int type;

  @override
  _RegestirationScreenState createState() => _RegestirationScreenState();
}

class _RegestirationScreenState extends State<RegestirationScreen> {
  final globalFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController fourthNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  bool ifPhoneValid = false;
  bool isAgree = false;

  // ValueNotifiers
  final ValueNotifier<bool> isObsecureNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<String> phoneCodeNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);

  bool isOtpSend = false;
  bool isPhoneVerified = false;
  String verfyiedPhone = "";
  String selectedGender = '';

  @override
  void initState() {
    super.initState();
    nameController.addListener(validateForm);
    phoneCodeNotifier.value = "966";
    emailController.addListener(validateForm);
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);
  }

  // Validate the form to check if all fields are filled
  void validateForm() {
    // Check if required fields are filled
    bool areCommonFieldsFilled() {
      return emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text &&
          confirmPasswordController.text.isNotEmpty;
    }

    // Check if OTP is required and valid for "966" phone code
    bool isOtpValidForPhoneCode() {
      return true;
    }

    // Validate for type 0
    bool validateType0() {
      return nameController.text.isNotEmpty && isOtpValidForPhoneCode();
    }

    // Validate for type 1
    bool validateType1() {
      return firstNameController.text.isNotEmpty &&
          secondameController.text.isNotEmpty &&
          fourthNameController.text.isNotEmpty &&
          isOtpValidForPhoneCode();
    }

    // Main form validation
    if (areCommonFieldsFilled()) {
      if (widget.type == 0) {
        isFormValidNotifier.value = validateType0();
      } else if (widget.type == 1) {
        isFormValidNotifier.value = validateType1();
      } else {
        isFormValidNotifier.value = true;
      }
    } else {
      isFormValidNotifier.value = true;
    }
  }

  void showOtpDialog(BuildContext context, RegisterCubit cubit) {
    bool isTimerFinished = false;

    showDialog(
      context: context,
      barrierDismissible: kDebugMode ? true : false,
      // Prevent dismissing the dialog
      builder: (context) {
        return BlocProvider(
          create: (context) => getit<RegisterCubit>(),
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
                      pinOtpController: otpController,
                    ),
                    verticalSpace(10.h),
                    Container(
                      alignment: Alignment.center,
                      child: isTimerFinished == true
                          ? InkWell(
                              onTap: () {
                                cubit.validatePhone(phoneController.text,
                                    phoneCodeNotifier.value);

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
                          phoneController.text,
                          phoneCodeNotifier.value,
                          otpController.text,
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

  @override
  void dispose() {
    nameController.dispose();
    firstNameController.dispose();
    secondameController.dispose();
    thirdNameController.dispose();
    fourthNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isObsecureNotifier.dispose();
    phoneCodeNotifier.dispose();
    isFormValidNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // تفعيل الحساب
          if (state is RegisterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: EdgeInsets.all(16.sp),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoActivityIndicator(
                          color: appColors.primaryColorYellow,
                        ),
                        horizontalSpace(16.sp),
                        Text("جاري تسجيل حسابك ... ",
                            style: TextStyles.cairo_12_bold),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is RegisterSuccess) {
            Navigator.of(context).pop();
            AnimatedSnackBar.material(
              state.message,
              type: AnimatedSnackBarType.success,
            ).show(context);
            Future.delayed(
              const Duration(microseconds: 1),
              () => Navigator.of(context).pushReplacementNamed(Routes.login),
            );
          } else if (state is RegisterFailure) {
            Navigator.of(context).pop();
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
            ).show(context);
          }

          // تفعيل رقم الهاتف
          if (state is PhoneValidationError) {
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
            ).show(context);
            if (state.error == "تم التفعيل بالفعل") {
              isPhoneVerified = true;
              verfyiedPhone = phoneController.text;
            }
          }

          if (state is PhoneValidationSuccess) {
            Navigator.of(context).pop(); // Close OTP dialog on success
            AnimatedSnackBar.material(
              "تم تاكيد رقم الهاتف بنجاح",
              type: AnimatedSnackBarType.success,
            ).show(context);
            isPhoneVerified = true;
            verfyiedPhone = phoneController.text;
          }

          if (state is OtpSendSuccess) {
            print("OTP Send Success");
            isOtpSend = true;
            showOtpDialog(
                context, context.read<RegisterCubit>()); // Show OTP dialog
            AnimatedSnackBar.material(
              "تم ارسال كود التأكيد على SMS , نرجو مراجعة هاتفك حتي يمكنك تأكيد رقمك",
              type: AnimatedSnackBarType.success,
            ).show(context);
          } else if (state is OtpSendError) {
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0.h),
                      child: Column(
                        children: [
                          verticalSpace(10.h),
                          SvgPicture.asset(
                            AppAssets.mainLogo,
                            height: 69.h,
                          ),
                          verticalSpace(30.h),
                          Text(
                            widget.type == 0
                                ? "تسجيل جديد | طالب خدمة"
                                : "تسجيل جديد | مقدم خدمة",
                            style: TextStyles.cairo_14_bold
                                .copyWith(color: appColors.blue100),
                          ),
                          verticalSpace(30.h),
                          StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return Form(
                                key: globalFormKey,
                                child: Column(
                                  children: [
                                    ConditionalBuilder(
                                      condition: widget.type == 0,
                                      builder: (context) {
                                        return CustomAuthTextField(
                                          validator:
                                              Validators.validateNotEmpty,
                                          hintText:
                                              LocaleKeys.namePlaceholder.tr(),
                                          externalController: nameController,
                                          title: LocaleKeys.name.tr(),
                                        );
                                      },
                                      fallback: (context) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: CustomAuthTextField(
                                                      validator: Validators
                                                          .validateNotEmpty,
                                                      hintText: LocaleKeys
                                                          .firstNamePlaceholder
                                                          .tr(),
                                                      externalController:
                                                          firstNameController,
                                                      title: LocaleKeys
                                                          .firstName
                                                          .tr()),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.2,
                                                  child: CustomAuthTextField(
                                                      validator: Validators
                                                          .validateNotEmpty,
                                                      hintText: LocaleKeys
                                                          .secondNamePlaceholder
                                                          .tr(),
                                                      externalController:
                                                          secondameController,
                                                      title: LocaleKeys
                                                          .secondName
                                                          .tr()),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: CustomAuthTextFieldWithOutValidate(
                                                      hintText: LocaleKeys
                                                          .thirdNamePlaceholder
                                                          .tr(),
                                                      externalController:
                                                          thirdNameController,
                                                      title: LocaleKeys
                                                          .thirdName
                                                          .tr()),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.2,
                                                  child: CustomAuthTextField(
                                                      validator: Validators
                                                          .validateNotEmpty,
                                                      hintText: LocaleKeys
                                                          .fourthNamePlaceholder
                                                          .tr(),
                                                      externalController:
                                                          fourthNameController,
                                                      title: LocaleKeys
                                                          .fourthName
                                                          .tr()),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    verticalSpace(10.h),
                                    isPhoneVerified
                                        ? Container(
                                            margin: EdgeInsets.only(top: 5.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomPhoneInput(
                                                  phoneController:
                                                      phoneController,
                                                  phoneCodeNotifier:
                                                      phoneCodeNotifier,
                                                  onPhoneValidChanged: (valid) {
                                                    ifPhoneValid = valid;
                                                    validateForm();
                                                  },
                                                  enabled: false,
                                                  isVerified: true,
                                                ),
                                                verticalSpace(10.h),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: appColors.green,
                                                      size: 15.r,
                                                    ),
                                                    horizontalSpace(5.sp),
                                                    Text(
                                                      "تم تأكيد رقم الهاتف بنجاح",
                                                      style: TextStyles
                                                          .cairo_10_bold
                                                          .copyWith(
                                                              color: appColors
                                                                  .green),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: IntlPhoneField(
                                                      languageCode: 'ar',
                                                      pickerDialogStyle:
                                                          PickerDialogStyle(
                                                        backgroundColor:
                                                            appColors.grey3,
                                                        searchFieldInputDecoration:
                                                            customInputDecorationPhone(),
                                                      ),
                                                      validator: (p0) => Validators
                                                          .validatePhoneNumber(p0
                                                              ?.completeNumber),
                                                      controller:
                                                          phoneController,
                                                      disableLengthCheck: false,
                                                      initialCountryCode: 'SA',
                                                      decoration:
                                                          customInputDecoration(),
                                                      onChanged: (phone) {
                                                        phoneController.text =
                                                            phone.number;
                                                        print(phone.number);
                                                        setState(() {});
                                                      },
                                                      onCountryChanged:
                                                          (phone) {
                                                        phoneCodeNotifier
                                                                .value =
                                                            phone.dialCode;
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  horizontalSpace(5.sp),
                                                  ConditionalBuilder(
                                                    condition:
                                                        state is OtpLoading,
                                                    builder: (context) {
                                                      return CupertinoActivityIndicator();
                                                    },
                                                    fallback: (context) {
                                                      return phoneCodeNotifier
                                                                  .value !=
                                                              "966"
                                                          ? Container()
                                                          : ValueListenableBuilder<
                                                              String>(
                                                              valueListenable:
                                                                  phoneCodeNotifier,
                                                              builder: (context,
                                                                  phoneCode,
                                                                  child) {
                                                                return Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top: 5
                                                                              .sp),
                                                                  child: CupertinoButton(
                                                                      padding: EdgeInsets.all(10.sp),
                                                                      color: appColors.primaryColorYellow,
                                                                      onPressed: phoneController.text.length < 9
                                                                          ? null
                                                                          : () {
                                                                              // عرض حالة التحميل أثناء إرسال الرمز
                                                                              context.read<RegisterCubit>().validatePhone(phoneController.text, phoneCodeNotifier.value);
                                                                            },
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            "إرسال",
                                                                            style:
                                                                                TextStyles.cairo_12_bold.copyWith(color: appColors.white),
                                                                          ),
                                                                          horizontalSpace(
                                                                              5.sp),
                                                                          const Icon(
                                                                            Icons.send_rounded,
                                                                            color:
                                                                                appColors.white,
                                                                          ),
                                                                        ],
                                                                      )),
                                                                );
                                                              },
                                                            );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                    CustomAuthTextField(
                                      validator: Validators.validateEmail,
                                      hintText:
                                          LocaleKeys.emailPlaceholder.tr(),
                                      externalController: emailController,
                                      title: LocaleKeys.email.tr(),
                                    ),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: isObsecureNotifier,
                                      builder: (context, isObsecure, child) {
                                        return CustomAuthTextField(
                                          validator:
                                              Validators.validatePassword,
                                          obscureText: isObsecure,
                                          isPssword: true,
                                          onPressEye: () {
                                            isObsecureNotifier.value =
                                                !isObsecure;
                                          },
                                          passwordVisiable: isObsecure,
                                          hintText: LocaleKeys.password.tr(),
                                          externalController:
                                              passwordController,
                                          title: LocaleKeys.password.tr(),
                                        );
                                      },
                                    ),
                                    CustomAuthTextField(
                                      validator: (String t) =>
                                          Validators.validatePasswordMatch(
                                        passwordController.text,
                                        t,
                                      ),
                                      obscureText: true,
                                      hintText: LocaleKeys.confirmPassword.tr(),
                                      externalController:
                                          confirmPasswordController,
                                      title: LocaleKeys.confirmPassword.tr(),
                                    ),
                                    CustomContainer(
                                        title: '',
                                        child: CustomDropdown(
                                          hintText: "الجنس",
                                          items: context
                                              .read<RegisterCubit>()
                                              .gender
                                              .keys
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<RegisterCubit>()
                                                .gender
                                                .forEach((key, keyVal) {
                                              if (key == value) {
                                                selectedGender = keyVal;
                                              }
                                            });
                                          },
                                        )),
                                    CustomAuthTextFieldWithOutValidate(
                                        hintText: "رمز الدعوة",
                                        externalController:
                                            inviteCodeController,
                                        title: "رمز الدعوة"),
                                    Row(
                                      children: [
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          activeColor:
                                              appColors.primaryColorYellow,
                                          checkColor: appColors.white,
                                          isError: false,
                                          value: isAgree,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isAgree = value!;
                                            });
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Text("أوافق على "),
                                            CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  showTermsAndConditionsDialog(
                                                      context);
                                                },
                                                child: Text(
                                                  "الشروط والأحكام و سياسة الخصوصية",
                                                  style: TextStyles
                                                      .cairo_12_bold
                                                      .copyWith(
                                                          color: appColors
                                                              .primaryColorYellow),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: isFormValidNotifier,
                                      builder: (context, isFormValid, child) {
                                        return CustomButton(
                                          title: LocaleKeys.signup.tr(),
                                          borderColor: isFormValid
                                              ? appColors.primaryColorYellow
                                              : appColors.grey,
                                          onPress: () {
                                            if (globalFormKey.currentState!
                                                .validate()) {
                                              if (!isAgree) {
                                                AnimatedSnackBar.material(
                                                  "الرجاء الموافقة على الشروط والأحكام",
                                                  type: AnimatedSnackBarType
                                                      .error,
                                                ).show(context);
                                              } else {
                                                if (widget.type == 0) {
                                                  Map<String, dynamic> map = {
                                                    "name": nameController.text,
                                                    "email":
                                                        emailController.text,
                                                    "phone":
                                                        phoneController.text,
                                                    "phone_code":
                                                        phoneCodeNotifier.value,
                                                    "password":
                                                        passwordController.text,
                                                    "account_type":
                                                        widget.type == 0
                                                            ? "client"
                                                            : "lawyer",
                                                    "gender": selectedGender,
                                                    "accepted_tos":
                                                        isAgree ? 1 : 0
                                                  };

                                                  if (phoneCodeNotifier.value ==
                                                      "966") {
                                                    map.addAll({
                                                      "otp": otpController.text
                                                    });
                                                  }

                                                  if (inviteCodeController
                                                      .text.isEmpty) {
                                                    map.addAll({
                                                      "invite_code":
                                                          inviteCodeController
                                                              .text
                                                    });
                                                  }

                                                  context
                                                      .read<RegisterCubit>()
                                                      .register(
                                                        FormData.fromMap(map),
                                                      );
                                                } else {
                                                  Map<String, dynamic> map = {
                                                    "first_name":
                                                        firstNameController
                                                            .text,
                                                    "second_name":
                                                        secondameController
                                                            .text,
                                                    "third_name":
                                                        thirdNameController
                                                            .text,
                                                    "fourth_name":
                                                        fourthNameController
                                                            .text,
                                                    "email":
                                                        emailController.text,
                                                    "phone":
                                                        phoneController.text,
                                                    "phone_code":
                                                        phoneCodeNotifier.value,
                                                    "password":
                                                        passwordController.text,
                                                    "account_type":
                                                        widget.type == 0
                                                            ? "client"
                                                            : "lawyer",
                                                    "gender": selectedGender,
                                                    "accepted_tos":
                                                        isAgree ? 1 : 0
                                                  };

                                                  if (phoneCodeNotifier.value ==
                                                      "966") {
                                                    map.addAll({
                                                      "otp": otpController.text
                                                    });
                                                  }
                                                  if (inviteCodeController
                                                      .text.isEmpty) {
                                                    map.addAll({
                                                      "invite_code":
                                                          inviteCodeController
                                                              .text
                                                    });
                                                  }

                                                  if (thirdNameController
                                                      .text.isEmpty) {
                                                    map.remove("third_name");
                                                  }

                                                  context
                                                      .read<RegisterCubit>()
                                                      .register(
                                                        FormData.fromMap(map),
                                                      );
                                                }
                                              }
                                            }
                                          }, // Disable the button if form is invalid
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          verticalSpace(10.h),
                          Padding(
                            padding: EdgeInsets.only(top: 21.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " ${LocaleKeys.dontHaveAnAccount.tr()} ",
                                  style: TextStyles.cairo_14_bold
                                      .copyWith(color: appColors.grey5),
                                ),
                                GestureDetector(
                                  onTap: () => context
                                      .pushReplacementNamed(Routes.login),
                                  child: Text(
                                    LocaleKeys.login.tr(),
                                    style: TextStyles.cairo_14_bold.copyWith(
                                        decorationColor: appColors.grey5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(40.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
