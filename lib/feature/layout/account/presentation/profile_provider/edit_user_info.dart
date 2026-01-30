import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/custom_decoration_style.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/core/widgets/textform_auth_field.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helpers/shared_functions.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../l10n/locale_keys.g.dart';
import '../../../../auth/sign_up/presentation/view/sign_up.dart';
import '../../logic/my_account_cubit.dart';

class EditUserInfoProvider extends StatelessWidget {
  EditUserInfoProvider({super.key});

  String localImagePath = ""; // Store the local image path

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is LoadingEditProvider ||
            current is SuccessEditProvider ||
            current is ErrorEditProvider,
        listener: (context, state) {
          state.whenOrNull(
            loadingEditProvider: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successEditProvider: (successLoginMessage) async {
              context.pop();
              if (successLoginMessage.data!.account!.confirmationType == null) {
                AppAlerts.showAlert(
                    context: context,
                    message: successLoginMessage.message!,
                    route: Routes.homeLayout,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
              } else {
                token = await CacheHelper.getData(key: "token");
                getit<MyAccountCubit>().deleteFcmToken(token);
                CacheHelper.removeData(key: 'token');
                CacheHelper.removeData(key: 'rememberMe');
                CacheHelper.removeData(key: 'userType');
                context.pushNamedAndRemoveUntil(Routes.verify,
                    predicate: (Route<dynamic> route) => false, arguments: 2);
                AppAlerts.showAlert(
                    context: context,
                    message: successLoginMessage.message!,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
              }
            },
            errorEditProvider: (error) {
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.editProfile.tr(),
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
          ),
          body: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              SignUpCubit signUpCubit = context.read<SignUpCubit>();
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w, vertical: 16.0.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // create screen to dit name and email and phone number
                        // and add button to save changes
                        GestureDetector(
                          onTap: () {
                            Future<File?> image = signUpCubit.pickImage();
                            image.then((value) {
                              if (value != null) {
                                signUpCubit.removeImage(value);
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundImage:
                                CachedNetworkImageProvider(signUpCubit.image!),
                          ),
                        ),
                        verticalSpace(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomAuthTextField(
                                  validator: Validators.validateNotEmpty,
                                  hintText:
                                      LocaleKeys.firstNamePlaceholder.tr(),
                                  externalController: context
                                      .read<SignUpCubit>()
                                      .providerFirstNameController,
                                  title: LocaleKeys.firstName.tr()),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: CustomAuthTextField(
                                  validator: Validators.validateNotEmpty,
                                  hintText:
                                      LocaleKeys.secondNamePlaceholder.tr(),
                                  externalController: context
                                      .read<SignUpCubit>()
                                      .providerSecondNameController,
                                  title: LocaleKeys.secondName.tr()),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomAuthTextFieldWithOutValidate(
                                  hintText:
                                      LocaleKeys.thirdNamePlaceholder.tr(),
                                  externalController: context
                                      .read<SignUpCubit>()
                                      .providerThirdNameController,
                                  title: LocaleKeys.thirdName.tr()),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: CustomAuthTextField(
                                  validator: Validators.validateNotEmpty,
                                  hintText:
                                      LocaleKeys.fourthNamePlaceholder.tr(),
                                  externalController: context
                                      .read<SignUpCubit>()
                                      .providerFourthNameController,
                                  title: LocaleKeys.fourthName.tr()),
                            ),
                          ],
                        ),
                        CustomTextFieldPrimary(
                            hintText: LocaleKeys.email.tr(),
                            externalController: signUpCubit.emailController,
                            validator: Validators.validateEmail,
                            title: LocaleKeys.email.tr()),
                        verticalSpace(10.h),
                        IntlPhoneField(
                          languageCode: 'ar',
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: appColors.grey3,
                            searchFieldInputDecoration:
                                customInputDecorationPhone(),
                          ),
                          validator: (p0) => Validators.validatePhoneNumber(
                              p0?.completeNumber),
                          controller: signUpCubit.phoneController,
                          disableLengthCheck: false,
                          initialCountryCode: getCountryCodeFromDialingCode(
                              signUpCubit.providerphoneCode),
                          decoration: customInputDecoration(),
                          onChanged: (phone) {
                            print(phone.number);
                            signUpCubit.phoneController.text = phone.number;
                          },
                          onCountryChanged: (phone) {
                            print(phone.dialCode);

                            signUpCubit.providerphoneCode = phone.dialCode;
                          },
                        ),

                        verticalSpace(20.h),

                        CustomButton(
                            title: LocaleKeys.save.tr(),
                            onPress: () {
                              Map<String, dynamic> data = {
                                "first_name": signUpCubit
                                    .providerFirstNameController.text,
                                "second_name": signUpCubit
                                    .providerSecondNameController.text,
                                "third_name": signUpCubit
                                    .providerThirdNameController.text,
                                "fourth_name": signUpCubit
                                    .providerFourthNameController.text,
                                "email": signUpCubit.emailController.text,
                                "phone": signUpCubit.phoneController.text,
                              };

                              FormData formData = FormData.fromMap(data);

                              if (signUpCubit.image != null) {
                                // formData.files.add(MapEntry(
                                //     "photo",
                                //     MultipartFile.fromFileSync(
                                //         signUpCubit.image!,
                                //         filename: signUpCubit.image!
                                //             .split("/")
                                //             .last)));
                              }
                              signUpCubit.emitEditProviderState(formData);
                              // signUpCubit.editProviderInfo();
                            })
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
