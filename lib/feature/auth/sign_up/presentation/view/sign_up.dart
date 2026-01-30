import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/shared_functions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/custom_decoration_style.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/core/widgets/textform_auth_field.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/nationalities_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/terms_and_conditions.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../l10n/locale_keys.g.dart';
import '../../data/models/countries_response.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';

String code = "";
String token = "";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Position? _currentPosition;
  bool? locationLoading = false;
  String codeMail = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is Loading ||
            current is Success ||
            current is Error ||
            current is ErrorImage ||
            current is LoadingCountries ||
            current is SuccessCountries ||
            current is ErrorCountries,
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
            success: (successLoginMessage) {
              context.pop();
              code = successLoginMessage.data!.client!.id!;
              showTermsAndConditionsDialog(context);
            },
            errorImage: (error) {
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            },
            error: (error) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            },
            loadingCountries: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successCountries: (countries) {},
            errorCountries: (error) {},
          );
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return Animate(
                    effects: [FadeEffect(delay: 100.ms)],
                    child: _body(context));
              },
            ),
          ),
        ));
  }

  Widget _body(BuildContext context) {
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
                  verticalSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.welcomeTo.tr(),
                          style: TextStyles.cairo_16_bold
                              .copyWith(color: appColors.blue100)),
                      Text(LocaleKeys.yomatec.tr(),
                          style: TextStyles.cairo_16_bold
                              .copyWith(color: appColors.primaryColorYellow)),
                    ],
                  ),
                  verticalSpace(30.h),
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Form(
                        key: context.read<SignUpCubit>().globalFormKey,
                        child: Column(
                          children: [
                            CustomAuthTextField(
                                validator: Validators.validateNotEmpty,
                                hintText: LocaleKeys.namePlaceholder.tr(),
                                externalController:
                                    context.read<SignUpCubit>().nameController,
                                title: LocaleKeys.name.tr()),

                            IntlPhoneField(
                              languageCode: 'ar',
                              pickerDialogStyle: PickerDialogStyle(
                                backgroundColor: appColors.grey3,
                                searchFieldInputDecoration:
                                    customInputDecorationPhone(),
                              ),
                              validator: (p0) => Validators.validatePhoneNumber(
                                  p0?.completeNumber),
                              controller:
                                  context.read<SignUpCubit>().phoneController,
                              disableLengthCheck: false,
                              initialCountryCode: 'SA',
                              decoration: customInputDecoration(),
                              onChanged: (phone) {
                                codeMail = removePlusSign(phone.countryCode);
                              },
                            ),

                            // CustomContainer(
                            //   title: LocaleKeys.phoneNumber.tr(),
                            //   child: InternationalPhoneNumberInput(
                            //     onInputChanged: (PhoneNumber number) {
                            //       print(number.dialCode);
                            //       codeMail = removePlusSign(number.dialCode!);
                            //     },
                            //     onInputValidated: (bool value) {},
                            //     selectorConfig: SelectorConfig(
                            //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            //     ),
                            //     ignoreBlank: false,
                            //     autoValidateMode: AutovalidateMode.disabled,
                            //     selectorTextStyle: TextStyle(color: Colors.black),
                            //     initialValue: PhoneNumber(isoCode: 'EG'),
                            //     textFieldController: context
                            //         .read<SignUpCubit>()
                            //         .phoneController,
                            //     inputDecoration: customInputDecorationPhone(),
                            //     inputBorder: OutlineInputBorder(),
                            //   ),
                            // ),

                            CustomAuthTextField(
                                validator: Validators.validateEmail,
                                hintText: LocaleKeys.emailPlaceholder.tr(),
                                externalController:
                                    context.read<SignUpCubit>().emailController,
                                title: LocaleKeys.email.tr()),
                            CustomAuthTextField(
                                validator: Validators.validatePassword,
                                obscureText:
                                    context.read<SignUpCubit>().isObsecure,
                                isPssword: true,
                                onPressEye: () {
                                  context.read<SignUpCubit>().changeObsecure();
                                  setState(() {});
                                },
                                passwordVisiable:
                                    !context.read<SignUpCubit>().isObsecure,
                                hintText: LocaleKeys.password.tr(),
                                externalController: context
                                    .read<SignUpCubit>()
                                    .passwordController,
                                title: LocaleKeys.password.tr()),
                            CustomAuthTextField(
                                validator: (String t) =>
                                    Validators.validatePasswordMatch(
                                        context
                                            .read<SignUpCubit>()
                                            .passwordController
                                            .text,
                                        context
                                            .read<SignUpCubit>()
                                            .confirmPasswordController
                                            .text),
                                obscureText: true,
                                hintText: LocaleKeys.confirmPassword.tr(),
                                externalController: context
                                    .read<SignUpCubit>()
                                    .confirmPasswordController,
                                title: LocaleKeys.confirmPassword.tr()),
                            Column(
                              children: [
                                CustomContainer(
                                    title: LocaleKeys.accountType.tr(),
                                    child: CustomDropdown(
                                      hintBuilder: (context, hint, enabled) {
                                        return Text(
                                          "اختر الصفة",
                                          style: TextStyle(
                                              color: appColors.blue100,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        );
                                      },
                                      items: context
                                          .read<SignUpCubit>()
                                          .accountType
                                          .keys
                                          .toList(),
                                      validator: Validators.validateNotEmpty,
                                      onChanged: (value) {
                                        context
                                            .read<SignUpCubit>()
                                            .accountType
                                            .forEach((key, keyVal) {
                                          if (key == value) {
                                            context
                                                .read<SignUpCubit>()
                                                .accountTypeValue = keyVal;
                                          }
                                        });
                                      },
                                    )),
                                ConditionalBuilder(
                                  condition: context
                                          .read<SignUpCubit>()
                                          .nationalities !=
                                      null,
                                  builder: (BuildContext context) =>
                                      CustomContainer(
                                          title: LocaleKeys.nationality.tr(),
                                          child: CustomDropdown<
                                              Nationality>.search(
                                            validator: (p0) =>
                                                Validators.validateNotEmpty(
                                                    p0?.name),
                                            overlayHeight:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                            hintBuilder:
                                                (context, hint, enabled) {
                                              return Text(
                                                LocaleKeys.selectNationality
                                                    .tr(),
                                                style: TextStyle(
                                                    color: appColors.blue100,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              );
                                            },
                                            items: context
                                                .read<SignUpCubit>()
                                                .nationalities!
                                                .data!
                                                .nationalities!,
                                            onChanged: (value) {
                                              context
                                                      .read<SignUpCubit>()
                                                      .selectedNationality =
                                                  value!.id!;
                                            },
                                          )),
                                  fallback: (BuildContext context) =>
                                      const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),

                                ConditionalBuilder(
                                  condition:
                                      context.read<SignUpCubit>().countries !=
                                          null,
                                  builder: (BuildContext context) =>
                                      CustomContainer(
                                          title: LocaleKeys.country.tr(),
                                          child: CustomDropdown<Country>.search(
                                            hintBuilder:
                                                (context, hint, enabled) {
                                              return Text(
                                                LocaleKeys.selectCountry.tr(),
                                                style: TextStyle(
                                                    color: appColors.blue100,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              );
                                            },
                                            overlayHeight:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                            hintText:
                                                LocaleKeys.selectCountry.tr(),
                                            validator: (p0) =>
                                                Validators.validateNotEmpty(
                                                    p0?.name),
                                            items: context
                                                .read<SignUpCubit>()
                                                .countries!
                                                .data!
                                                .countries,
                                            onChanged: (value) {
                                              setState(() {
                                                context
                                                    .read<SignUpCubit>()
                                                    .selectCounrty(
                                                        value!.regions!,
                                                        value.id!,
                                                        value.phoneCode!);
                                              });
                                            },
                                          )),
                                  fallback: (BuildContext context) =>
                                      const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: context
                                          .read<SignUpCubit>()
                                          .selectedCountry !=
                                      -1,
                                  child: ConditionalBuilder(
                                    condition: context
                                        .read<SignUpCubit>()
                                        .regions!
                                        .isNotEmpty,
                                    builder: (BuildContext context) =>
                                        CustomContainer(
                                      title: LocaleKeys.region.tr(),
                                      child: CustomDropdown<Region>(
                                        hintBuilder: (context, hint, enabled) {
                                          return Text(
                                            LocaleKeys.region.tr(),
                                            style: TextStyle(
                                                color: appColors.blue100,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          );
                                        },
                                        hintText: LocaleKeys.selectRegion.tr(),
                                        items: context
                                            .read<SignUpCubit>()
                                            .regions!,
                                        onChanged: (value) {
                                          setState(() {
                                            context
                                                .read<SignUpCubit>()
                                                .selectRegion(
                                                    value!.cities!, value.id!);
                                          });
                                        },
                                      ),
                                    ),
                                    fallback: (BuildContext context) =>
                                        const Text("لا يوجد مناطق"),
                                  ),
                                ),
                                Visibility(
                                  visible: context
                                          .read<SignUpCubit>()
                                          .selectedRegion !=
                                      -1,
                                  child: ConditionalBuilder(
                                    condition: context
                                        .read<SignUpCubit>()
                                        .cities!
                                        .isNotEmpty,
                                    builder: (BuildContext context) =>
                                        CustomContainer(
                                      title: LocaleKeys.city.tr(),
                                      child: CustomDropdown<City>(
                                        hintText: LocaleKeys.selectCity.tr(),
                                        items:
                                            context.read<SignUpCubit>().cities,
                                        onChanged: (value) {
                                          context
                                              .read<SignUpCubit>()
                                              .selectDistricts(value!.id!);
                                        },
                                      ),
                                    ),
                                    fallback: (BuildContext context) =>
                                        const Text("لا يوجد مدن"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          setState(() {
                                            _getCurrentPosition();
                                          })
                                        },
                                        child: Container(
                                          height: 50.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            color: appColors.blue100,
                                            borderRadius:
                                                BorderRadius.circular(12.sp),
                                          ),
                                          child: ConditionalBuilder(
                                            condition: locationLoading == true,
                                            builder: (BuildContext context) =>
                                                const Center(
                                              child: CupertinoActivityIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                            fallback: (BuildContext context) =>
                                                Animate(
                                              effects: [
                                                FadeEffect(delay: 200.ms)
                                              ],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _currentPosition == null
                                                        ? LocaleKeys
                                                            .selectLocation
                                                            .tr()
                                                        : '${_currentPosition?.latitude}. تم اختيار الموقع',
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: appColors.white,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    CupertinoIcons.location,
                                                    color: appColors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomContainer(
                                    title: LocaleKeys.gender.tr(),
                                    child: CustomDropdown(
                                      validator: (value) {
                                        if (value == null) {
                                          return LocaleKeys.selectGender.tr();
                                        }
                                        return null;
                                      },
                                      hintText: LocaleKeys.gender.tr(),
                                      items: context
                                          .read<SignUpCubit>()
                                          .gender
                                          .keys
                                          .toList(),
                                      onChanged: (value) {
                                        context
                                            .read<SignUpCubit>()
                                            .gender
                                            .forEach((key, keyVal) {
                                          if (key == value) {
                                            context
                                                .read<SignUpCubit>()
                                                .selectedGender = keyVal;
                                          }
                                        });
                                      },
                                    )),

                                CustomAuthTextFieldWithOutValidate(
                                    hintText: 'رمز الدعوة',
                                    externalController: context
                                        .read<SignUpCubit>()
                                        .refController,
                                    title: 'رمز الدعوة'),

                                verticalSpace(30.h),

                                // ConditionalBuilder(
                                //   condition: context
                                //       .read<SignUpCubit>()
                                //       .regions!
                                //       .isNotEmpty,
                                //   builder: (BuildContext context) =>
                                //       CustomContainer(
                                //     title: "المدينة",
                                //     child: CustomDropdown<Region>.search(
                                //       overlayHeight:
                                //           MediaQuery.of(context).size.height *
                                //               0.5,
                                //       hintText: "اختر المدينه",
                                //       items:
                                //           context.read<SignUpCubit>().regions!,
                                //       onChanged: (value) {
                                //         context
                                //             .read<SignUpCubit>()
                                //             .selectRegion(
                                //                 value
                                //                     .cities!,
                                //                 value.id!);
                                //       },
                                //     ),
                                //   ),
                                //   fallback: (BuildContext context) =>
                                //       const Text("لا يوجد مدن"),
                                // ),
                              ],
                            ),
                            CustomButton(
                              title: LocaleKeys.signup.tr(),
                              onPress: () {
                                if (context
                                            .read<SignUpCubit>()
                                            .globalFormKey
                                            .currentState!
                                            .validate() ==
                                        true &&
                                    context
                                            .read<SignUpCubit>()
                                            .passwordController
                                            .text ==
                                        context
                                            .read<SignUpCubit>()
                                            .confirmPasswordController
                                            .text &&
                                    _currentPosition != null) {
                                  final SignUpRequestBody signUpRequestBody;
                                  if (context
                                      .read<SignUpCubit>()
                                      .refController
                                      .text
                                      .isNotEmpty) {
                                    signUpRequestBody = SignUpRequestBody(
                                      referredBy: context
                                          .read<SignUpCubit>()
                                          .refController
                                          .text,
                                      name: context
                                          .read<SignUpCubit>()
                                          .nameController
                                          .text,
                                      mobile: context
                                          .read<SignUpCubit>()
                                          .phoneController
                                          .text,
                                      type: context
                                          .read<SignUpCubit>()
                                          .accountTypeValue,
                                      email: context
                                          .read<SignUpCubit>()
                                          .emailController
                                          .text,
                                      password: context
                                          .read<SignUpCubit>()
                                          .passwordController
                                          .text,
                                      activationType: codeMail == "966" ? 2 : 1,
                                      countryId: context
                                          .read<SignUpCubit>()
                                          .selectedCountry,
                                      cityId: context
                                          .read<SignUpCubit>()
                                          .selectedDistricts,
                                      nationalityId: context
                                          .read<SignUpCubit>()
                                          .selectedNationality,
                                      regionId: context
                                          .read<SignUpCubit>()
                                          .selectedRegion,
                                      latitude: _currentPosition!.latitude,
                                      longitude: _currentPosition!.longitude,
                                      phoneCode: codeMail,
                                      gender: context
                                          .read<SignUpCubit>()
                                          .selectedGender,
                                    );
                                  } else {
                                    signUpRequestBody = SignUpRequestBody(
                                      name: context
                                          .read<SignUpCubit>()
                                          .nameController
                                          .text,
                                      mobile: context
                                          .read<SignUpCubit>()
                                          .phoneController
                                          .text,
                                      type: context
                                          .read<SignUpCubit>()
                                          .accountTypeValue,
                                      email: context
                                          .read<SignUpCubit>()
                                          .emailController
                                          .text,
                                      password: context
                                          .read<SignUpCubit>()
                                          .passwordController
                                          .text,
                                      activationType: codeMail == "966" ? 2 : 1,
                                      countryId: context
                                          .read<SignUpCubit>()
                                          .selectedCountry,
                                      cityId: context
                                          .read<SignUpCubit>()
                                          .selectedDistricts,
                                      nationalityId: context
                                          .read<SignUpCubit>()
                                          .selectedNationality,
                                      regionId: context
                                          .read<SignUpCubit>()
                                          .selectedRegion,
                                      latitude: _currentPosition!.latitude,
                                      longitude: _currentPosition!.longitude,
                                      phoneCode: codeMail,
                                      gender: context
                                          .read<SignUpCubit>()
                                          .selectedGender,
                                    );
                                  }
                                  context
                                      .read<SignUpCubit>()
                                      .emitSignUpState(signUpRequestBody);
                                  // add call api
                                } else if (context
                                        .read<SignUpCubit>()
                                        .passwordController
                                        .text !=
                                    context
                                        .read<SignUpCubit>()
                                        .confirmPasswordController
                                        .text) {
                                  AppAlerts.showAlert(
                                      context: context,
                                      message:
                                          "الرجاء تطابق كلمة السر مع تأكيد كلمة السر",
                                      buttonText: "أعد المحاولة",
                                      type: AlertType.error);
                                } else if (_currentPosition == null) {
                                  AppAlerts.showAlert(
                                      context: context,
                                      message: "الرجاء تحديد الموقع",
                                      buttonText: "أعد المحاولة",
                                      type: AlertType.error);
                                } else if (context
                                    .read<SignUpCubit>()
                                    .globalFormKey
                                    .currentState!
                                    .validate()) {
                                  AppAlerts.showAlert(
                                      context: context,
                                      message: "الرجاء مراجعة البيانات",
                                      buttonText: "أعد المحاولة",
                                      type: AlertType.error);
                                } else {
                                  AppAlerts.showAlert(
                                      context: context,
                                      message: "الرجاء مراجعة البيانات",
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
                  // verticalSpace(30.h),
                  // Animate(
                  //   effects: [FadeEffect(delay: 100.ms)],
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Expanded(
                  //               child: Divider(
                  //             height: 0.5.h,
                  //             color: appColors.grey5,
                  //           )),
                  //           Text(
                  //             "  ${LocaleKeys.registerVia.tr()}  ",
                  //             style: TextStyles.cairo_14_regular
                  //                 .copyWith(color: appColors.blue100),
                  //           ),
                  //           Expanded(
                  //               child: Divider(
                  //             height: 0.5.h,
                  //             color: appColors.grey5,
                  //           )),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 13.h,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Container(
                  //             padding: EdgeInsets.all(8.0.w),
                  //             decoration: BoxDecoration(
                  //               color: appColors.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //               border: Border.all(
                  //                 color: appColors.grey3,
                  //                 width: 1.5.w,
                  //               ),
                  //             ),
                  //             child: SvgPicture.asset(
                  //               AppAssets.x,
                  //               fit: BoxFit.contain,
                  //               width: 22.w,
                  //               height: 22.h,
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.all(8.0.w),
                  //             decoration: BoxDecoration(
                  //               color: appColors.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //               border: Border.all(
                  //                 color: appColors.grey3,
                  //                 width: 1.5.w,
                  //               ),
                  //             ),
                  //             child: SvgPicture.asset(
                  //               AppAssets.x,
                  //               fit: BoxFit.contain,
                  //               width: 22.w,
                  //               height: 22.h,
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.all(8.0.w),
                  //             decoration: BoxDecoration(
                  //               color: appColors.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //               border: Border.all(
                  //                 color: appColors.grey3,
                  //                 width: 1.5.w,
                  //               ),
                  //             ),
                  //             child: SvgPicture.asset(
                  //               AppAssets.insta,
                  //               fit: BoxFit.contain,
                  //               width: 22.w,
                  //               height: 22.h,
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.all(8.0.w),
                  //             decoration: BoxDecoration(
                  //               color: appColors.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //               border: Border.all(
                  //                 color: appColors.grey3,
                  //                 width: 1.5.w,
                  //               ),
                  //             ),
                  //             child: SvgPicture.asset(
                  //               AppAssets.google,
                  //               fit: BoxFit.contain,
                  //               width: 22.w,
                  //               height: 22.h,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  verticalSpace(10.h),
                  Padding(
                    padding: EdgeInsets.only(top: 21.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" ${LocaleKeys.dontHaveAnAccount.tr()} ",
                            style: TextStyles.cairo_14_bold
                                .copyWith(color: appColors.grey5)),
                        GestureDetector(
                          onTap: () =>
                              context.pushReplacementNamed(Routes.login),
                          child: Text(LocaleKeys.login.tr(),
                              style: TextStyles.cairo_14_bold
                                  .copyWith(decorationColor: appColors.grey5)),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10.h),
                  verticalSpace(30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      locationLoading = true;
    });

    final hasPermission = await _getLocation();
    if (!hasPermission) {
      setState(() {
        locationLoading = false;
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() => _currentPosition = position);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        locationLoading = false;
      });
    }
  }

  Future<bool> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationLoading = false;
      });

      // عرض حوار يطلب من المستخدم فتح إعدادات الموقع
      bool? openSettings = await _showLocationServiceDialog();
      if (openSettings != null && openSettings) {
        _openLocationSettings();
      }

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم رفض أذونات الموقع')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('تم رفض أذونات الموقع بشكل دائم، لا يمكننا طلب الأذونات.'),
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool?> _showLocationServiceDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خدمة الموقع معطلة'),
          content: const Text('يرجى تفعيلها من خلال الإعدادات.'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('فتح الإعدادات'),
              onPressed: () async {
                Navigator.of(context).pop(true);
                if (Platform.isAndroid) {
                  _openLocationSettings(); // فتح إعدادات الموقع
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _openLocationSettings() {
    // سيفتح إعدادات الموقع على الجهاز باستخدام android_intent_plus
    const intent = AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    intent.launch().catchError((e) {
      print('خطأ في إطلاق النية: $e');
    });
  }
}
