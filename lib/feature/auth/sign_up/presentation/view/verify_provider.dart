import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_otp_request.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/pin_code.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';

class VerifyProviderOtp extends StatelessWidget {
  VerifyProviderOtp({super.key, required this.data});

  Map data = {};
  int count = 5;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is LoadingVerifyProviderOtp ||
          current is SuccessVerifyProviderOtp ||
          current is ErrorVerifyProviderOtp,
      listener: (context, state) {
        state.whenOrNull(
          loadingVerifyProviderOtp: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          },
          successVerifyProviderOtp: (verifyRes) {
            context.pop();
            context.pushReplacementNamed(Routes.signupProviderData,
                arguments: data);
          },
          errorVerifyProviderOtp: (error) {
            context.pop();
            count--;
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
                        Text("تأكيد رمز التحقق",
                            style: TextStyles.cairo_20_bold
                                .copyWith(color: appColors.blue100)),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          " تم إرسال رمز التحقق",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: appColors.grey5,
                              fontSize: 16.sp),
                        ),
                        Form(
                          key: context.read<SignUpCubit>().pinGlobalFormKey,
                          child: Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 35.h, bottom: 30.h),
                                    child: PinCodeWidget(
                                        pinOtpController: context
                                            .read<SignUpCubit>()
                                            .pinOtpController),
                                  ),
                                ),
                              ),
                              verticalSpace(100.h),
                              CustomButton(
                                title: "تأكيد",
                                onPress: () {
                                  if (context
                                          .read<SignUpCubit>()
                                          .pinGlobalFormKey
                                          .currentState!
                                          .validate() ==
                                      true) {
                                    context
                                        .read<SignUpCubit>()
                                        .emitVerifyProviderOtpState(
                                            VerifyProviderOtpRequest(
                                                email: data['email'],
                                                phoneCode: data['country_code'],
                                                phone:
                                                    "${data['country_code']}${data['phoneWithOutCode']}",
                                                otp: context
                                                    .read<SignUpCubit>()
                                                    .pinOtpController
                                                    .text));
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
