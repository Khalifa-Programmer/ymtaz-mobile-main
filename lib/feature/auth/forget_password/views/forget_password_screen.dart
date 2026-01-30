import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/core/widgets/textform_auth_field.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/forget_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_cubit.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_state.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../core/constants/validators.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetCubit, ForgetState>(
      listenWhen: (previous, current) =>
          current is LoadingEmailCheck ||
          current is SuccessEmailCheck ||
          current is ErrorEmailCheck,
      listener: (context, state) {
        state.whenOrNull(
          loadingEmailCheck: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          },
          successEmailCheck: (successLoginMessage) {
            context.pop();
            context.pushNamed(Routes.forgetPasswordOtpClient,
                arguments: context.read<ForgetCubit>().emailController.text);
          },
          errorEmailCheck: (error) {
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            AppAssets.mainLogo,
                            width: 100,
                            height: 56.w,
                          ),
                        ),
                        verticalSpace(30.h),
                        Text(LocaleKeys.emailPlaceholder.tr(),
                            style: TextStyles.cairo_20_bold),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          LocaleKeys.sendCodeMessage.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: appColors.grey5,
                              fontSize: 16.sp),
                        ),
                        Form(
                            key: context.read<ForgetCubit>().globalFormKey,
                            child: Column(
                              children: [
                                verticalSpace(40.h),
                                CustomAuthTextField(
                                    validator: Validators.validateEmail,
                                    hintText: LocaleKeys.emailPlaceholder.tr(),
                                    externalController: context
                                        .read<ForgetCubit>()
                                        .emailController,
                                    title: LocaleKeys.email.tr()),
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
                                          .emitForgetPass(ForgetRequestBody(
                                              context
                                                  .read<ForgetCubit>()
                                                  .emailController
                                                  .text,
                                              '1'));
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
      ),
    );
  }
}
