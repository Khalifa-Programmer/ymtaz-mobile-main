import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/shared_functions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_decoration_style.dart';
import 'package:yamtaz/core/widgets/textform_auth_field.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_request.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/terms_and_conditions.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../../l10n/locale_keys.g.dart';

class SignUpProvider extends StatelessWidget {
  SignUpProvider({super.key});

  int currentStep = 0;
  int countryCode = -1;
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is LoadingVerifyProvider ||
            current is SuccessVerifyProvider ||
            current is ErrorVerifyProvider ||
            current is ChangeScreenValues,
        listener: (context, state) {
          state.whenOrNull(loadingVerifyProvider: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          }, successVerifyProvider: (successLoginMessage) {
            context.pop();
            showTermsAndConditionsDialognew(
                context, Routes.verifyProviderOtp, data);
          }, errorVerifyProvider: (error) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: error,
                buttonText: LocaleKeys.retry.tr(),
                type: AlertType.error);
          });
        },
        child: Scaffold(
          body: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return SafeArea(
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
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return Form(
                                  key:
                                      context.read<SignUpCubit>().globalFormKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: CustomAuthTextField(
                                                validator:
                                                    Validators.validateNotEmpty,
                                                hintText: LocaleKeys
                                                    .firstNamePlaceholder
                                                    .tr(),
                                                externalController: context
                                                    .read<SignUpCubit>()
                                                    .providerFirstNameController,
                                                title:
                                                    LocaleKeys.firstName.tr()),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: CustomAuthTextField(
                                                validator:
                                                    Validators.validateNotEmpty,
                                                hintText: LocaleKeys
                                                    .secondNamePlaceholder
                                                    .tr(),
                                                externalController: context
                                                    .read<SignUpCubit>()
                                                    .providerSecondNameController,
                                                title:
                                                    LocaleKeys.secondName.tr()),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                externalController: context
                                                    .read<SignUpCubit>()
                                                    .providerThirdNameController,
                                                title:
                                                    LocaleKeys.thirdName.tr()),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: CustomAuthTextField(
                                                validator:
                                                    Validators.validateNotEmpty,
                                                hintText: LocaleKeys
                                                    .fourthNamePlaceholder
                                                    .tr(),
                                                externalController: context
                                                    .read<SignUpCubit>()
                                                    .providerFourthNameController,
                                                title:
                                                    LocaleKeys.fourthName.tr()),
                                          ),
                                        ],
                                      ),
                                      CustomAuthTextField(
                                          validator: Validators.validateEmail,
                                          hintText:
                                              LocaleKeys.emailPlaceholder.tr(),
                                          externalController: context
                                              .read<SignUpCubit>()
                                              .providerEmailController,
                                          title: LocaleKeys.email.tr()),
                                      IntlPhoneField(
                                        languageCode: 'ar',
                                        countries: countries,
                                        pickerDialogStyle: PickerDialogStyle(
                                          backgroundColor: appColors.grey3,
                                          searchFieldInputDecoration:
                                              customInputDecorationPhone(),
                                        ),
                                        validator: (p0) =>
                                            Validators.validatePhoneNumber(
                                                p0?.completeNumber),
                                        controller: context
                                            .read<SignUpCubit>()
                                            .providerPhoneController,
                                        disableLengthCheck: false,
                                        initialCountryCode: 'SA',
                                        decoration: customInputDecoration(),
                                        onChanged: (phone) {
                                          countryCode = int.parse(
                                              removePlusSign(
                                                  phone.countryCode));
                                          context
                                                  .read<SignUpCubit>()
                                                  .providerPhone =
                                              phone.completeNumber;
                                        },
                                      ),
                                      CustomAuthTextField(
                                          validator:
                                              Validators.validatePassword,
                                          obscureText: context
                                              .read<SignUpCubit>()
                                              .isObsecure,
                                          isPssword: true,
                                          onPressEye: () {
                                            context
                                                .read<SignUpCubit>()
                                                .changeObsecure();
                                            setState(() {});
                                          },
                                          passwordVisiable: !context
                                              .read<SignUpCubit>()
                                              .isObsecure,
                                          hintText:
                                              LocaleKeys.enterPassword.tr(),
                                          externalController: context
                                              .read<SignUpCubit>()
                                              .providerPasswordController,
                                          title: LocaleKeys.enterPassword.tr()),
                                      CustomAuthTextField(
                                          validator: (String val) =>
                                              Validators.validatePasswordMatch(
                                                  context
                                                      .read<SignUpCubit>()
                                                      .providerPasswordController
                                                      .text,
                                                  context
                                                      .read<SignUpCubit>()
                                                      .providerConfirmPasswordController
                                                      .text),
                                          obscureText: true,
                                          hintText:
                                              LocaleKeys.passwordConfirm.tr(),
                                          externalController: context
                                              .read<SignUpCubit>()
                                              .providerConfirmPasswordController,
                                          title:
                                              LocaleKeys.passwordConfirm.tr()),
                                      CustomButton(
                                        title: LocaleKeys.next.tr(),
                                        onPress: () {
                                          if (context
                                                      .read<SignUpCubit>()
                                                      .globalFormKey
                                                      .currentState!
                                                      .validate() ==
                                                  true &&
                                              context
                                                      .read<SignUpCubit>()
                                                      .providerPhoneController
                                                      .text
                                                      .length >
                                                  7 &&
                                              context
                                                      .read<SignUpCubit>()
                                                      .providerPasswordController
                                                      .text ==
                                                  context
                                                      .read<SignUpCubit>()
                                                      .providerConfirmPasswordController
                                                      .text) {
                                            data = {
                                              "first_name": context
                                                  .read<SignUpCubit>()
                                                  .providerFirstNameController
                                                  .text,
                                              "second_name": context
                                                  .read<SignUpCubit>()
                                                  .providerSecondNameController
                                                  .text,
                                              "third_name": context
                                                  .read<SignUpCubit>()
                                                  .providerThirdNameController
                                                  .text,
                                              "fourth_name": context
                                                  .read<SignUpCubit>()
                                                  .providerFourthNameController
                                                  .text,
                                              "email": context
                                                  .read<SignUpCubit>()
                                                  .providerEmailController
                                                  .text,
                                              "phone": removePlusSign(context
                                                  .read<SignUpCubit>()
                                                  .providerPhone),
                                              "phoneWithOutCode":
                                                  removePlusSign(context
                                                      .read<SignUpCubit>()
                                                      .providerPhoneController
                                                      .text),
                                              "password": context
                                                  .read<SignUpCubit>()
                                                  .providerPasswordController
                                                  .text,
                                              "password_confirmation": context
                                                  .read<SignUpCubit>()
                                                  .providerConfirmPasswordController
                                                  .text,
                                              "country_code": countryCode,
                                            };
                                            context
                                                .read<SignUpCubit>()
                                                .emitVerifyProviderState(
                                                    VerifyProviderRequest(
                                                        email: context
                                                            .read<SignUpCubit>()
                                                            .providerEmailController
                                                            .text,
                                                        phoneCode: countryCode,
                                                        phone: removePlusSign(
                                                            context
                                                                .read<
                                                                    SignUpCubit>()
                                                                .providerPhone)));
                                            // context.pushNamed(
                                            //     Routes.signupProviderData,
                                            //     arguments: data);

                                            // add call api
                                          } else if (context
                                                  .read<SignUpCubit>()
                                                  .providerPasswordController
                                                  .text !=
                                              context
                                                  .read<SignUpCubit>()
                                                  .providerConfirmPasswordController
                                                  .text) {
                                            AppAlerts.showAlert(
                                                context: context,
                                                message:
                                                    "كلمة السر غير متطابقة",
                                                buttonText: "أعد المحاولة",
                                                type: AlertType.error);
                                          } else if (context
                                                  .read<SignUpCubit>()
                                                  .providerPhoneController
                                                  .text
                                                  .length <
                                              7) {
                                            AppAlerts.showAlert(
                                                context: context,
                                                message: "برجاء إدخال رقم هاتف",
                                                buttonText: "أعد المحاولة",
                                                type: AlertType.error);
                                          } else {
                                            AppAlerts.showAlert(
                                                context: context,
                                                message:
                                                    "الرجاء مراجعة البيانات",
                                                buttonText: "أعد المحاولة",
                                                type: AlertType.error);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            verticalSpace(30.h),
                            Padding(
                              padding: EdgeInsets.only(top: 21.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(LocaleKeys.alreadyHaveAccount.tr(),
                                      style: TextStyles.cairo_14_bold
                                          .copyWith(color: appColors.grey5)),
                                  GestureDetector(
                                    onTap: () => context
                                        .pushReplacementNamed(Routes.login),
                                    child: Text(LocaleKeys.login.tr(),
                                        style: TextStyles.cairo_14_bold
                                            .copyWith(
                                                decorationColor:
                                                    appColors.grey5)),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(10.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
