import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/check_box.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/core/widgets/textform_auth_field.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_request_body.dart';
import 'package:yamtaz/feature/auth/login/logic/login_cubit.dart';
import 'package:yamtaz/feature/auth/login/logic/login_state.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../core/network/app_auth.dart';
import '../../../../../core/widgets/custom_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool rememberMe = false;
  final ValueNotifier<bool> isObsecureNotifier = ValueNotifier<bool>(false);


 @override
  void dispose() {
    isObsecureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Animate(
        effects: const [
          FadeEffect(delay: Duration(milliseconds: 300)),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                        "تسجيل الدخول",
                        style: TextStyles.cairo_14_bold
                            .copyWith(color: appColors.blue100),
                      ),
                      verticalSpace(33.h),
                      StatefulBuilder(
                        builder: (BuildContext b,
                            void Function(void Function()) setState) {
                          return Form(
                            key: context.read<LoginCubit>().globalFormKey,
                            child: Column(
                              children: [
                                CustomAuthTextField(
                                    validator: Validators.validateNotEmpty,
                                    hintText: LocaleKeys.enterPhoneOrEmail.tr(),
                                    externalController: context
                                        .read<LoginCubit>()
                                        .emailController,
                                    focusNode:
                                        context.read<LoginCubit>().emailFocus,
                                    title: LocaleKeys.phoneOrEmail.tr()),
                               ValueListenableBuilder<bool>(
                                  valueListenable: isObsecureNotifier,
                                  builder: (context, isObsecure, child) {
                                    return CustomAuthTextField(
                                      validator: Validators.validateNotEmpty,
                                      obscureText: isObsecure,
                                      isPssword: true,
                                      onPressEye: () {
                                        isObsecureNotifier.value = !isObsecure;
                                      },
                                      focusNode: context
                                          .read<LoginCubit>()
                                          .passwordFocus,
                                      passwordVisiable: isObsecure,
                                      hintText: LocaleKeys.password.tr(),
                                      externalController: context
                                          .read<LoginCubit>()
                                          .passwordController,
                                      title: LocaleKeys.password.tr(),
                                    );
                                  },
                                ),

                                /* CustomAuthTextField(
                                    validator: Validators.validateNotEmpty,
                                    obscureText: true,
                                    focusNode: context
                                        .read<LoginCubit>()
                                        .passwordFocus,
                                    hintText: LocaleKeys.passwordConfirm.tr(),
                                    externalController: context
                                        .read<LoginCubit>()
                                        .passwordController,
                                    title: LocaleKeys.password.tr()),*/
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrivacySecurityCheckbox(
                                      value:
                                          context.read<LoginCubit>().rememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          context
                                              .read<LoginCubit>()
                                              .rememberMe = value!;
                                        });
                                      },
                                      text: LocaleKeys.rememberme.tr(),
                                    ),
                                    GestureDetector(
                                      onTap: () => context.pushNamed(
                                          Routes.forgetPasswordProvider),
                                      child: Text(
                                        LocaleKeys.forgetPass.tr(),
                                        style: TextStyles.cairo_12_regular
                                            .copyWith(
                                                color: appColors
                                                    .primaryColorYellow),
                                      ),
                                    )
                                  ],
                                ),
                                verticalSpace(10.h),
                                CustomButton(
                                  title: LocaleKeys.login.tr(),
                                  onPress: () async {
                                    if (context
                                            .read<LoginCubit>()
                                            .globalFormKey
                                            .currentState!
                                            .validate() ==
                                        true) {
                                      try {
                                        FlutterError.onError =
                                            (FlutterErrorDetails details) {
                                          FirebaseCrashlytics.instance
                                              .recordFlutterError(details);
                                        };

                                        await FirebaseCrashlytics.instance
                                            .log("message");
                                        // استدعاء عملية تسجيل الدخول
                                        await context
                                            .read<LoginCubit>()
                                            .emitLoginState(
                                              LoginRequestBody(
                                                context
                                                    .read<LoginCubit>()
                                                    .emailController
                                                    .text,
                                                context
                                                    .read<LoginCubit>()
                                                    .passwordController
                                                    .text,
                                              ),
                                            );
                                        // متابعة العمليات الأخرى عند النجاح
                                        // showLoginType(context: context);
                                      } catch (e, stackTrace) {
                                        // تسجيل الخطأ في Firebase Crashlytics مع الـ stackTrace
                                        await FirebaseCrashlytics.instance
                                            .recordError(
                                          e,
                                          stackTrace,
                                          reason: 'Error during login request',
                                        );
                                      }
                                    }
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
                            Text(LocaleKeys.dontHaveAnAccount.tr(),
                                style: TextStyles.cairo_14_bold
                                    .copyWith(color: appColors.grey5)),
                            horizontalSpace(4.w),
                            GestureDetector(
                              onTap: () {
                                // if (context.read<LoginCubit>().isClient) {
                                //   context.pushReplacementNamed(Routes.signup);
                                // } else {
                                //   context.pushReplacementNamed(
                                //       Routes.signupProvider);
                                // }

                                showRegisterType(context: context);
                              },
                              child: Text(LocaleKeys.createAccount.tr(),
                                  style: TextStyles.cairo_14_bold.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: appColors.grey5)),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(30.h),
                      GestureDetector(
                        onTap: () {
                          CacheHelper.saveData(key: "userType", value: "guest");
                          context.pushNamed(Routes.homeLayout);
                        },
                        child: Text(
                          "التصفح كزائر",
                          style: TextStyles.cairo_14_regular
                              .copyWith(color: appColors.grey10),
                        ),
                      ),
                      verticalSpace(30.h),
                      AnimatedContainer(
                        duration: 100.ms,
                        height: 80.h,
                        child: Animate(
                          effects: [FadeEffect(delay: 100.ms)],
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Google Sign In

                                  // Apple Sign In
                                  Platform.isIOS
                                      ?
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                         // Show loading indicator in a more elegant way
                                         final loginCubit = context.read<LoginCubit>();
                                         
                                         // Show loading state
                                         setState(() {
                                           loginCubit.isAppleLoading = true;
                                         });
                                         
                                        Map<String, dynamic>? appleInfo = await AppServices().signInWithApple(context);
                                        
                                        // Reset loading state
                                        setState(() {
                                          loginCubit.isAppleLoading = false;
                                        });
                                        
                                        if (appleInfo != null) {
                                          context.read<LoginCubit>().emitAppleLoginState(context, appleInfo);
                                         } else {
                                           ScaffoldMessenger.of(context).showSnackBar(
                                             const SnackBar(content: Text('فشل تسجيل الدخول باستخدام Apple'), backgroundColor: Colors.red)
                                           );
                                        }
                                      } catch (e) {
                                        debugPrint('Error during Apple Sign In: $e');
                                        // Reset loading state in case of error
                                        setState(() {
                                          context.read<LoginCubit>().isAppleLoading = false;
                                        });
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('حدث خطأ أثناء تسجيل الدخول'), backgroundColor: Colors.red)
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.0.w),
                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: appColors.white,
                                        borderRadius: BorderRadius.circular(12.0.w),
                                        border: Border.all(
                                          color: appColors.grey3,
                                          width: 1.5.w,
                                        ),
                                      ),
                                      child: context.read<LoginCubit>().isAppleLoading
                                        ? SizedBox(
                                            width: 22.w,
                                            height: 22.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            AppAssets.apple,
                                            fit: BoxFit.contain,
                                            width: 22.w,
                                            height: 22.h,
                                          ),
                                    ),
                                  ) : SizedBox.shrink(),
                                  GestureDetector(
                                   // داخل GestureDetector الخاص بـ Google في ملف login_body.dart

onTap: () async {
  try {
    final loginCubit = context.read<LoginCubit>();
    
    setState(() => loginCubit.isGoogleLoading = true);

    // استدعاء خدمة جوجل (تأكد أن هذه الدالة تعيد الـ idToken)
    Map<String, dynamic>? googleInfo = await AppServices().signInWithGoogle(context);
    
    setState(() => loginCubit.isGoogleLoading = false);

    if (googleInfo != null && googleInfo['token'] != null) {
      // إرسال البيانات للـ Cubit للتحقق منها مع الباك اند الخاص بك
      await loginCubit.emitGoogleLoginState(context, googleInfo);
    } else {
      // إذا ألغى المستخدم العملية أو فشلت
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إلغاء تسجيل الدخول')),
      );
    }
  } catch (e) {
    setState(() => context.read<LoginCubit>().isGoogleLoading = false);
    debugPrint('Google Auth Error: $e');
  }
},
                                    child: Container(
                                      padding: EdgeInsets.all(8.0.w),
                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: appColors.white,
                                        borderRadius: BorderRadius.circular(12.0.w),
                                        border: Border.all(
                                          color: appColors.grey3,
                                          width: 1.5.w,
                                        ),
                                      ),
                                      child: context.read<LoginCubit>().isGoogleLoading
                                        ? SizedBox(
                                            width: 22.w,
                                            height: 22.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            AppAssets.google,
                                            fit: BoxFit.contain,
                                            width: 22.w,
                                            height: 22.h,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showForgetType({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appColors.white,
          content: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.mainLogo),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.welcomeTo.tr(),
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                        Text(
                          LocaleKeys.yomatec.tr(),
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.primaryColorYellow),
                        ),
                      ],
                    ),
                    verticalSpace(5.h),
                    Text(
                      LocaleKeys.selectAccountTypeRecover.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyles.cairo_14_semiBold
                          .copyWith(color: appColors.blue100),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomButton(
                        title: LocaleKeys.serviceSeeker.tr(),
                        onPress: () {
                          context.pushNamed(Routes.forgetPasswordClient);
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomButton(
                        title: LocaleKeys.serviceProvider.tr(),
                        onPress: () {
                          context.pushNamed(Routes.forgetPasswordProvider);
                        }),
                    SizedBox(
                      height: 22.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}

void showRegisterType({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: appColors.white,
        backgroundColor: appColors.white,
        title: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.mainLogo,
                    width: 122.w,
                    height: 70.h,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  verticalSpace(10.h),
                  Text(
                    LocaleKeys.chooseYourAccountType.tr(),
                    style: TextStyles.cairo_14_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  verticalSpace(10.h),
                  CustomButton(
                    bgColor: appColors.primaryColorYellow,
                    onPress: () {
                      context.pushNamed(Routes.regestirationScreen,
                          arguments: 0);
                    },
                    height: 40.h,
                    title: LocaleKeys.serviceSeeker.tr(),
                    titleColor: appColors.white,
                    fontSize: 12.sp,
                  ),
                  verticalSpace(10),
                  CustomButton(
                    bgColor: appColors.white,
                    onPress: () {
                      context.pushNamed(Routes.regestirationScreen,
                          arguments: 1);
                    },
                    height: 40.h,
                    title: LocaleKeys.serviceProvider.tr(),
                    titleColor: appColors.primaryColorYellow,
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
