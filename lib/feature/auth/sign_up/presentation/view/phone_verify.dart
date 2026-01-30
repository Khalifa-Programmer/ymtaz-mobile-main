import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/sign_up.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/pin_code.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../l10n/locale_keys.g.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';

class MobileVerify extends StatefulWidget {
  MobileVerify({super.key, this.type = 1});

  int type;

  bool isTimerFinished = false;

  @override
  State<MobileVerify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
  // 1 for verify regesteration 2 for verify otp edit
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is LoadingVerify ||
          current is SuccessVerify ||
          current is ErrorVerify ||
          current is LoadingVerifyOtpEdit ||
          current is SuccessVerifyOtpEdit ||
          current is ErrorVerifyOtpEdit ||
          current is LoadingResendOtp ||
          current is SuccessResendOtp ||
          current is ErrorResendOtp,
      listener: (context, state) {
        state.whenOrNull(
          loadingVerify: () {
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
          successVerify: (successLoginMessage) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: successLoginMessage.message ?? "",
                route: Routes.login,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          },
          errorVerify: (error) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: error,
                buttonText: LocaleKeys.retry.tr(),
                type: AlertType.error);
          },
          loadingVerifyOtpEdit: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          },
          successVerifyOtpEdit: (successLoginMessage) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: successLoginMessage.message ?? "",
                route: Routes.login,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          },
          errorVerifyOtpEdit: (error) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: error,
                buttonText: LocaleKeys.retry.tr(),
                type: AlertType.error);
          },
          loadingResendOtp: () {
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
          successResendOtp: (successLoginMessage) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: successLoginMessage ?? "",
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          },
          errorResendOtp: (error) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: error,
                buttonText: LocaleKeys.retry.tr(),
                type: AlertType.error);
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Animate(
              effects: const [FadeEffect(delay: Duration(milliseconds: 200))],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.mainLogo,
                          width: 100,
                          height: 56.w,
                        ),
                        verticalSpace(30.h),
                        Text(LocaleKeys.verifyCode.tr(),
                            style: TextStyles.cairo_20_bold
                                .copyWith(color: appColors.blue100)),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          LocaleKeys.verificationCodeSent.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: appColors.grey5,
                              fontSize: 16.sp),
                        ),
                        Form(
                          key: context.read<SignUpCubit>().pinGlobalFormKey,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 35.h, bottom: 30.h),
                                  child: PinCodeWidget(
                                      pinOtpController: context
                                          .read<SignUpCubit>()
                                          .pinOtpController),
                                ),
                              ),
                              token.isEmpty
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.resendCode.tr(),
                                          style: TextStyle(
                                              color: appColors.grey5,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.sp),
                                        ),
                                        horizontalSpace(5.w),
                                        widget.isTimerFinished == true
                                            ? InkWell(
                                                onTap: () {
                                                  context
                                                      .read<SignUpCubit>()
                                                      .resendCode(token);
                                                  setState(() {
                                                    widget.isTimerFinished =
                                                        false;
                                                  });
                                                },
                                                child: Text(
                                                  "إعادة الإرسال",
                                                  style: TextStyle(
                                                      color: appColors
                                                          .primaryColorYellow,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp),
                                                ),
                                              )
                                            : TimerCountdown(
                                                endTime: DateTime.now().add(
                                                  const Duration(
                                                    minutes: 0,
                                                    seconds: 180,
                                                  ),
                                                ),
                                                onEnd: () {
                                                  setState(() {
                                                    widget.isTimerFinished =
                                                        true;
                                                  });
                                                },
                                                colonsTextStyle: TextStyle(
                                                    color: appColors.grey5,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25.sp),
                                                timeTextStyle: TextStyle(
                                                    color: appColors.grey5,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.sp),
                                                spacerWidth: 3.w,
                                                enableDescriptions: false,
                                                format: CountDownTimerFormat
                                                    .secondsOnly,
                                              )
                                      ],
                                    ),
                              verticalSpace(100.h),
                              CustomButton(
                                title: LocaleKeys.confirm.tr(),
                                onPress: () {
                                  if (context
                                          .read<SignUpCubit>()
                                          .pinGlobalFormKey
                                          .currentState!
                                          .validate() ==
                                      true) {
                                    switch (widget.type) {
                                      case 1:
                                        context
                                            .read<SignUpCubit>()
                                            .emitVerifyState(VerifyRequestBody(
                                                context
                                                    .read<SignUpCubit>()
                                                    .pinOtpController
                                                    .text,
                                                code.toString()));
                                        break;
                                      case 2:
                                        context
                                            .read<SignUpCubit>()
                                            .emitVerifyEditState(
                                                context
                                                    .read<SignUpCubit>()
                                                    .pinOtpController
                                                    .text,
                                                token);
                                        break;
                                      default:
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
