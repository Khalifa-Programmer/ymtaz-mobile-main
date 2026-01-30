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
          successProvider: (loginResponse) async {
            if (loginResponse.data!.account!.accountType == 'lawyer') {
              context.pop();

              if (loginResponse.data!.account!.status == 3) {
                CacheHelper.saveData(
                    key: "token",
                    value: "Bearer ${loginResponse.data!.account!.token}");
                CacheHelper.saveData(key: "userType", value: "provider");
                getit<MyAccountCubit>().getProviderData();
                await getit<NotificationCubit>().getNotifications();
                AppAlerts.showAlert(
                    context: context,
                    message: loginResponse.message!,
                    buttonText: "تحديث البيانات",
                    route: Routes.editProviderInstruction,
                    isForceRouting: false,
                    type: AlertType.success);
              } else if (loginResponse.data!.account!.emailConfirmation == 0) {
                showEmailDialog(context, loginResponse.message!);
              } else if (loginResponse.data!.account!.status == 0) {
                AppAlerts.showAlert(
                    context: context,
                    message: loginResponse.message!,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.error);
              } else {
                AppAlerts.showAlert(
                    context: context,
                    message: loginResponse.message!,
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
                CacheHelper.saveData(
                    key: "token",
                    value: "Bearer ${loginResponse.data!.account!.token}");
                CacheHelper.saveData(key: "userType", value: "provider");
                getit<MyAccountCubit>().getProviderData();
                await getit<NotificationCubit>().getNotifications();
                if (getit<LoginCubit>().rememberMe == true) {
                  CacheHelper.saveData(key: "rememberMe", value: "true");
                  print(CacheHelper.getData(key: "rememberMe") + "rembmerKey");
                }
              }
            } else {
              context.pop();

              if (loginResponse.data!.account!.status == 3) {
                getit<MyAccountCubit>().sendFcmToken();
                getit<NotificationCubit>().getNotifications();
                CacheHelper.saveData(
                    key: "token",
                    value: "Bearer ${loginResponse.data!.account!.token}");
                CacheHelper.saveData(key: "userType", value: "client");
                getit<MyAccountCubit>().getClientData();
                await getit<NotificationCubit>().getNotifications();
                AppAlerts.showAlert(
                    context: context,
                    message: loginResponse.message!,
                    buttonText: "تحديث البيانات",
                    route: Routes.editClient,
                    isForceRouting: false,
                    type: AlertType.success);
              } else if (loginResponse.data!.account!.emailConfirmation == 0) {
                showEmailDialog(context, loginResponse.message!);
              } else {
                AppAlerts.showAlert(
                    context: context,
                    message: LocaleKeys.registrationSuccess.tr(),
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
                CacheHelper.saveData(
                    key: "token",
                    value: "Bearer ${loginResponse.data!.account!.token}");
                CacheHelper.saveData(key: "userType", value: "client");
                getit<MyAccountCubit>().getClientData();
                await getit<NotificationCubit>().getNotifications();
                if (context.read<LoginCubit>().rememberMe == true) {
                  CacheHelper.saveData(key: "rememberMe", value: "true");
                  print(CacheHelper.getData(key: "rememberMe") + "rembmerKey");
                }
              }
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
            CacheHelper.saveData(
                key: "tokenVisitor",
                value: "Bearer ${visitorLogin.data!.visitor!.token}");
            CacheHelper.saveData(key: "userType", value: "guest");
            //getit<MyAccountCubit>().getVisitorData();
          },
          appleSuccess: (visitorLogin) async {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: LocaleKeys.registrationSuccess.tr(),
                route: Routes.homeLayout,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
            // CacheHelper.saveData(
            //     key: "tokenVisitor",
            //     value: "Bearer ${visitorLogin.data!.visitor!.token}");
            CacheHelper.saveData(key: "userType", value: "guest");
            //getit<MyAccountCubit>().getVisitorData();
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
        child: Container(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // استخدام mainAxisSize.min لتقليل المساحة البيضاء
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
                height: 150.h, // تحقق من أن الأبعاد مناسبة
                fit: BoxFit.contain, // اجعل الصورة تتناسب مع الحاوية
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
      );
    },
  );
}
