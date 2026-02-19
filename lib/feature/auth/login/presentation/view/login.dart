import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/auth/login/logic/login_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../notifications/logic/notification_cubit.dart';
import '../../logic/login_state.dart';
import 'login_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Error ||
          current is SuccessProvider ||
          current is VisitorLoading ||
          current is VisitorSuccess ||
          current is VisitorError,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
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
          success: (loginResponse) {
            final userData = loginResponse.data?.account;
            final isLawyer = userData?.accountType == 'lawyer';
            final accountStatus = userData?.status ?? 0;
            final serverMessage = loginResponse.message ?? '';
            
            context.pop(); // Close loading dialog

            print('🔐 Login Success - Account Type: ${isLawyer ? "Provider" : "Client"}');
            print('📊 Account Status: $accountStatus');
            print('💬 Server Message: $serverMessage');

            // Check email confirmation first
            if (userData?.emailConfirmation == 0) {
              showEmailDialog(context, serverMessage.isNotEmpty ? serverMessage : 'الرجاء تأكيد بريدك الإلكتروني');
              return;
            }

            // Handle different account statuses
            if (isLawyer) {
              // Provider (Lawyer) Status Handling
              switch (accountStatus) {
                case 0: // New account - جديد
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'حسابك جديد وفي انتظار المراجعة',
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.warning);
                  break;
                  
                case 1: // Accepted - مقبول
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.success);
                  break;
                  
                case 2: // Waiting - في الانتظار
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'حسابك في انتظار الموافقة',
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.warning);
                  break;
                  
                case 3: // Needs update - يحتاج تحديث
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'يرجى تحديث بياناتك',
                      buttonText: "تحديث البيانات",
                      route: Routes.editProviderInstruction,
                      isForceRouting: false,
                      type: AlertType.success);
                  break;
                  
                case 4: // Banned - محظور
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'حسابك محظور. الرجاء التواصل مع الدعم الفني',
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.error);
                  break;
                  
                default: // Any other status
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.success);
              }
            } else {
              // Client Status Handling
              switch (accountStatus) {
                case 1: // New account - جديد
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'مرحباً بك! حسابك جديد',
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.success);
                  break;
                  
                case 2: // Accepted - مقبول
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.success);
                  break;
                  
                case 3: // Waiting - في الانتظار
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'حسابك في انتظار الموافقة',
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.warning);
                  break;
                  
                case 4: // Needs update - يحتاج تحديث
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'يرجى تحديث بياناتك',
                      buttonText: "تحديث البيانات",
                      route: Routes.editClient,
                      isForceRouting: false,
                      type: AlertType.success);
                  break;
                  
                case 5: // Banned - محظور
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : 'حسابك محظور. الرجاء التواصل مع الدعم الفني',
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.error);
                  break;
                  
                default: // Any other status
                  AppAlerts.showAlert(
                      context: context,
                      message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                      route: Routes.homeLayout,
                      buttonText: LocaleKeys.continueNext.tr(),
                      type: AlertType.success);
              }
            }

            // Sync settings
            if (context.read<LoginCubit>().rememberMe) {
              CacheHelper.saveData(key: "rememberMe", value: "true");
            }
          },
          successProvider: (loginResponse) {
            // Handle provider login with the same logic as success
            // This ensures messages are displayed for providers too
            final userData = loginResponse.data?.account;
            final accountStatus = userData?.status ?? 0;
            final serverMessage = loginResponse.message ?? '';
            
            context.pop(); // Close loading dialog

            print('🔐 Provider Login Success - Account Type: Provider');
            print('📊 Account Status: $accountStatus');
            print('💬 Server Message: $serverMessage');

            // Check email confirmation first
            if (userData?.emailConfirmation == 0) {
              showEmailDialog(context, serverMessage.isNotEmpty ? serverMessage : 'الرجاء تأكيد بريدك الإلكتروني');
              return;
            }

            // Provider (Lawyer) Status Handling
            switch (accountStatus) {
              case 0: // New account - جديد
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : 'حسابك جديد وفي انتظار المراجعة',
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.warning);
                break;
                
              case 1: // Accepted - مقبول
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
                break;
                
              case 2: // Waiting - في الانتظار
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : 'حسابك في انتظار الموافقة',
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.warning);
                break;
                
              case 3: // Needs update - يحتاج تحديث
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : 'يرجى تحديث بياناتك',
                    buttonText: "تحديث البيانات",
                    route: Routes.editProviderInstruction,
                    isForceRouting: false,
                    type: AlertType.success);
                break;
                
              case 4: // Banned - محظور
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : 'حسابك محظور. الرجاء التواصل مع الدعم الفني',
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.error);
                break;
                
              default: // Any other status
                AppAlerts.showAlert(
                    context: context,
                    message: serverMessage.isNotEmpty ? serverMessage : LocaleKeys.registrationSuccess.tr(),
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
            }

            // Sync settings
            if (context.read<LoginCubit>().rememberMe) {
              CacheHelper.saveData(key: "rememberMe", value: "true");
            }
          },
          error: (error) {
            context.pop();
            if (error == "خطأ في الهاتف أو كلمة المرور") {
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            } else {
              CacheHelper.saveData(key: "userType", value: "guest");
              AppAlerts.showAlertWithoutError(
                  context: context,
                  message: error,
                  route: Routes.homeLayout,
                  buttonText: LocaleKeys.browseAsGuest.tr(),
                  type: AlertType.warning);
            }
          },
          visitorLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          },
          visitorSuccess: (visitorLogin) async {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: LocaleKeys.registrationSuccess.tr(),
                route: Routes.homeLayout,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
            
            // Cubit already saves data to cache, so we just handle navigation/alerts here
            print('🔐 Google Login Success - Token: ${visitorLogin.data?.visitor?.token}');
          },
          appleSuccess: (appleResponse) async {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: LocaleKeys.registrationSuccess.tr(),
                route: Routes.homeLayout,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
                
            print('🔐 Apple Login Success');
          },
          visitorError: (error) {
            context.pop();

            AppAlerts.showAlertWithoutError(
                context: context,
                message: error,
                route: Routes.homeLayout,
                buttonText: LocaleKeys.browseAsGuest.tr(),
                type: AlertType.warning);
          },
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity, // Make it cover the entire screen
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset(0.5, -0.1429),
                  end: FractionalOffset(0.5, 0.4),
                  stops: [0.0, 2.0],
                  colors: [
                    Color(0xFFF9F0DD),
                    Colors.white,
                  ],
                ),
              ),
              child: Animate(
                effects: const [
                  FadeEffect(delay: Duration(milliseconds: 300)),
                ],
              ),
            ),
            // The LoginBody widget
            const LoginBody(),
          ],
        ),
      ),
    );
  }
}

void showEmailDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: appColors.grey.withOpacity(0.5),
                          size: 30.sp,
                        ))
                  ],
                ),
                Image.asset(
                  AppAssets.compeleteDataPNG,
                  height: 120.h, 
                  fit: BoxFit.contain, 
                ),
                SizedBox(height: 16.h),
                // Title Text
                Text(
                  'بريدك الإلكتروني غير مؤكد',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 25.h),

                // Button at the bottom
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: appColors.primaryColorYellow,
                    onPressed: () {
                      context.pop();
                    },
                    child: Text('حسناً',
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
