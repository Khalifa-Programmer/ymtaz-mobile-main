import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_cubit.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_state.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/pin_code.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/primary/app_bar.dart';

String? userForgetCode;

class CheckCodeScreen extends StatefulWidget {
  final String email;

  const CheckCodeScreen({super.key, required this.email});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetCubit, ForgetState>(
      listenWhen: (previous, current) =>
          current is LoadingCodeCheck ||
          current is SuccessCodeCheck ||
          current is ErrorCodeCheck,
      listener: (context, state) {
        state.whenOrNull(
          loadingCodeCheck: () {
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
          successCodeCheck: (successLoginMessage) {
            context.pop();
            userForgetCode = successLoginMessage.data!.passCode.toString();

            context.pushNamed(Routes.resetPasswordClient,
                arguments: context.read<ForgetCubit>().otpController.text);
          },
          errorCodeCheck: (error) {
            context.pop();

            AppAlerts.showAlert(
                context: context,
                message: error,
                buttonText: "أعد المحاولة",
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
                  AppBarCustom(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.logo,
                          width: 100,
                          height: 56.w,
                        ),
                        verticalSpace(30.h),
                        Text("التحقق من الرمز",
                            style: TextStyles.cairo_20_bold),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          "تم إرسال الرمز عبر البريد الإلكتروني",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: appColors.grey5,
                              fontSize: 16.sp),
                        ),
                        Form(
                          key: context.read<ForgetCubit>().globalFormKey,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 35.h, bottom: 30.h),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: PinCodeWidget(
                                        pinOtpController: context
                                            .read<ForgetCubit>()
                                            .otpController),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "إعادة إرسال",
                                    style: TextStyle(
                                        color: appColors.grey5,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.sp),
                                  ),
                                  horizontalSpace(5.w),
                                  context.read<ForgetCubit>().isTimerFinished
                                      ? CupertinoButton(
                                          onPressed: () {
                                            context
                                                .read<ForgetCubit>()
                                                .isTimerFinished = false;
                                            setState(() {});
                                          },
                                          child: Text("إعادة الإرسال",
                                              style: TextStyles
                                                  .cairo_14_semiBold
                                                  .copyWith(
                                                color: appColors.grey20,
                                              )),
                                        )
                                      : TimerCountdown(
                                          endTime: DateTime.now().add(
                                            const Duration(
                                              minutes: 0,
                                              seconds: 180,
                                            ),
                                          ),
                                          onEnd: () {
                                            context
                                                    .read<ForgetCubit>()
                                                    .isTimerFinished =
                                                true; // set timer finished to true
                                            setState(() {});
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
                                          format:
                                              CountDownTimerFormat.secondsOnly,
                                        )
                                ],
                              ),
                              verticalSpace(100.h),
                              CustomButton(
                                title: "تأكيد",
                                onPress: () {
                                  if (context
                                          .read<ForgetCubit>()
                                          .globalFormKey
                                          .currentState!
                                          .validate() ==
                                      true) {
                                    context.read<ForgetCubit>().emitVerifyCode(
                                        CheckCodeRequestBody(
                                            context
                                                .read<ForgetCubit>()
                                                .otpController
                                                .text,
                                            widget.email));
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
