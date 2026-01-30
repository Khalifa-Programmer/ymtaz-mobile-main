import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_cubit.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../core/widgets/textform_auth_field.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../data/model/reset_password_request_body.dart';
import '../logic/forget_state.dart';

class ResetPasswordLawyerScreen extends StatelessWidget {
  final String code;
  final String email;

  const ResetPasswordLawyerScreen(
      {super.key, required this.code, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ForgetCubit>(),
      child: BlocConsumer<ForgetCubit, ForgetState>(
        listenWhen: (previous, current) =>
            current is LoadingReset ||
            current is SuccessReset ||
            current is ErrorReset,
        listener: (context, state) {
          state.whenOrNull(
            loadingReset: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successReset: (successLoginMessage) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: "تم تغيير كلمة السر بنجاح",
                  route: Routes.login,
                  buttonText: "استمرار",
                  type: AlertType.success);
            },
            errorReset: (error) {
              context.pop();

              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: "أعد المحاولة",
                  type: AlertType.error);
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Animate(
                  effects: const [
                    FadeEffect(delay: Duration(milliseconds: 200))
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.mainLogo,
                              width: 100,
                              height: 56.w,
                            ),
                            verticalSpace(30.h),
                            Text(LocaleKeys.changePassword.tr(),
                                style: TextStyles.cairo_20_bold),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              LocaleKeys.confirmationCode.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: appColors.grey10,
                                  fontSize: 16.sp),
                            ),
                            Form(
                                key: context.read<ForgetCubit>().globalFormKey,
                                child: Column(
                                  children: [
                                    verticalSpace(40.h),
                                    CustomAuthTextField(
                                        validator: Validators.validatePassword,
                                        hintText: LocaleKeys.enterPassword.tr(),
                                        obscureText: true,
                                        externalController: context
                                            .read<ForgetCubit>()
                                            .passwordController,
                                        title: LocaleKeys.password.tr()),
                                    verticalSpace(10.h),
                                    CustomAuthTextField(
                                        validator: Validators.validatePassword,
                                        obscureText: true,
                                        hintText: LocaleKeys
                                            .confirmPasswordPrompt
                                            .tr(),
                                        externalController: context
                                            .read<ForgetCubit>()
                                            .confirmPasswordController,
                                        title: LocaleKeys.passwordConfirm.tr()),
                                    verticalSpace(100.h),
                                    CustomButton(
                                      title: LocaleKeys.recovery.tr(),
                                      onPress: () {
                                        if (context
                                                .read<ForgetCubit>()
                                                .globalFormKey
                                                .currentState!
                                                .validate() ==
                                            true) {
                                          context
                                              .read<ForgetCubit>()
                                              .emitResetPassLawyer(
                                                  ResetPasswordRequestBody(
                                                context
                                                    .read<ForgetCubit>()
                                                    .passwordController
                                                    .text,
                                                email,
                                                code,
                                              ));
                                          // add call api
                                        }
                                      },
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
