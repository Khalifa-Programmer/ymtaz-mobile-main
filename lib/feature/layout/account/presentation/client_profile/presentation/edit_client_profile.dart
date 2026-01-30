import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/shared_functions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/custom_decoration_style.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/sign_up.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';

import '../../../../../../core/widgets/alerts.dart';
import '../../../../../../l10n/locale_keys.g.dart';
import '../../../../../auth/sign_up/presentation/view/widgets/pin_code.dart';
import '../../profile_provider/edit_provider.dart';

class ClientEditProfile extends StatefulWidget {
  const ClientEditProfile({super.key});

  @override
  State<ClientEditProfile> createState() => _ClientEditProfileState();
}

class _ClientEditProfileState extends State<ClientEditProfile> {
  bool? locationLoading = false;
  String? oldPhone;
  String? oldPhoneCode;
  bool isVerified = true;
  MyAccountCubit myAccountCubit = getit<MyAccountCubit>();

  @override
  void initState() {
    // TODO: implement initState
    MyAccountCubit myAccountCubit = getit<MyAccountCubit>();
    oldPhone = myAccountCubit.clientProfile!.data!.account!.phone;
    oldPhoneCode =
        myAccountCubit.clientProfile!.data!.account!.phoneCode.toString();
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  void showOtpDialog(BuildContext context, MyAccountCubit cubit) {
    bool isTimerFinished = false;
    showDialog(
      context: context,
      barrierDismissible: kDebugMode ? true : false,
      // Prevent dismissing the dialog
      builder: (context) {
        return BlocProvider(
          create: (context) => getit<MyAccountCubit>(),
          child: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                backgroundColor: appColors.white,
                surfaceTintColor: appColors.white,
                title: Text(
                  'أدخل رمز التحقق',
                  style: TextStyles.cairo_12_bold,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PinCodeAlertWidget(
                      pinOtpController: cubit.otpController,
                    ),
                    verticalSpace(10.h),
                    Container(
                      alignment: Alignment.center,
                      child: isTimerFinished == true
                          ? InkWell(
                              onTap: () {
                                cubit.validatePhone(cubit.phoneController.text,
                                    cubit.countryCodeSelected.toString());
                                phone = cubit.phoneController.text;

                                setState(() {
                                  isTimerFinished = false;
                                });
                                context.pop();
                              },
                              child: Text(
                                "إعادة الإرسال",
                                style: TextStyle(
                                    color: appColors.primaryColorYellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لم يصلك الرمز؟",
                                  style: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                TimerCountdown(
                                  endTime: DateTime.now().add(
                                    const Duration(
                                      minutes: 0,
                                      seconds: 180,
                                    ),
                                  ),
                                  onEnd: () {
                                    setState(() {
                                      isTimerFinished = true;
                                    });
                                  },
                                  colonsTextStyle: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                  timeTextStyle: TextStyle(
                                      color: appColors.grey5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                  spacerWidth: 3.w,
                                  enableDescriptions: false,
                                  format: CountDownTimerFormat.secondsOnly,
                                ),
                              ],
                            ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        cubit.verifyPhoneOtp(
                          phone!,
                          "966",
                          cubit.otpController.text,
                        );
                      },
                      child: Text(
                        'تحقق',
                        style: TextStyles.cairo_12_bold
                            .copyWith(color: appColors.primaryColorYellow),
                      )),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listener: (context, state) async {
        if (state is ErrorEditClient) {
          Navigator.pop(context);

          AppAlerts.showAlert(
              context: context,
              message: state.error.toString(),
              buttonText: LocaleKeys.retry.tr(),
              type: AlertType.error);
        }
        if (state is LoadingEditClient) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: appColors.primaryColorYellow,
              ),
            ),
          );
        }
        if (state is SuccessEditClient) {
          Navigator.pop(context);
          if (state.data.data!.account!.confirmationType == null &&
              state.data.data!.account!.accepted == 2 &&
              state.data.data!.account!.accepted == 1) {
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                route: Routes.homeLayout,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          } else if (state.data.data!.account!.accepted == 3 &&
              state.data.data!.account!.confirmationType == "phone") {
            token = await CacheHelper.getData(key: "token");
            getit<MyAccountCubit>().deleteFcmToken(token);
            CacheHelper.removeData(key: 'token');
            CacheHelper.removeData(key: 'rememberMe');
            CacheHelper.removeData(key: 'userType');
            context.pushNamedAndRemoveUntil(Routes.verify,
                predicate: (Route<dynamic> route) => false, arguments: 2);
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          } else if (state.data.data!.account!.accepted == 3 &&
              state.data.data!.account!.confirmationType == "email") {
            token = await CacheHelper.getData(key: "token");
            getit<MyAccountCubit>().deleteFcmToken(token);
            CacheHelper.removeData(key: 'token');
            CacheHelper.removeData(key: 'rememberMe');
            CacheHelper.removeData(key: 'userType');
            context.pushNamedAndRemoveUntil(Routes.login,
                predicate: (Route<dynamic> route) => false, arguments: 2);
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          } else if (state.data.data!.account!.accepted == 2 &&
              state.data.data!.account!.confirmationType == "email") {
            token = await CacheHelper.getData(key: "token");
            getit<MyAccountCubit>().deleteFcmToken(token);
            CacheHelper.removeData(key: 'token');
            CacheHelper.removeData(key: 'rememberMe');
            CacheHelper.removeData(key: 'userType');
            context.pushNamedAndRemoveUntil(Routes.login,
                predicate: (Route<dynamic> route) => false, arguments: 2);
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          } else if (state.data.data!.account!.accepted == 2 &&
              state.data.data!.account!.confirmationType == "phone") {
            token = await CacheHelper.getData(key: "token");
            getit<MyAccountCubit>().deleteFcmToken(token);
            CacheHelper.removeData(key: 'token');
            CacheHelper.removeData(key: 'rememberMe');
            CacheHelper.removeData(key: 'userType');
            context.pushNamedAndRemoveUntil(Routes.verify,
                predicate: (Route<dynamic> route) => false, arguments: 2);
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          } else {
            AppAlerts.showAlert(
                context: context,
                message: state.data.message!,
                route: Routes.login,
                buttonText: LocaleKeys.continueNext.tr(),
                type: AlertType.success);
          }
        }

        if (state is LoadingSignUpProviderOtp) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: appColors.primaryColorYellow,
              ),
            ),
          );
        } else if (state is SuccessSignUpProviderOtp) {
          context.pop();
          showOtpDialog(context, context.read<MyAccountCubit>());
        } else if (state is ErrorSignUpProviderOtp) {
          context.pop();
          AppAlerts.showAlert(
              context: context,
              message: state.error,
              buttonText: LocaleKeys.retry.tr(),
              type: AlertType.error);
        } else if (state is LoadingSignUpProviderOtpEdit) {
          AnimatedSnackBar.material(
            "جاري التحقق من الرمز",
            type: AnimatedSnackBarType.info,
          ).show(context);
        } else if (state is SuccessSignUpProviderOtpEdit) {
          print("dfsfds");
          context.pop();
          AnimatedSnackBar.material(
            "تم التحقق من الهاتف بنجاح",
            type: AnimatedSnackBarType.success,
          ).show(context);
          oldPhone = context.read<MyAccountCubit>().phoneController.text;
          oldPhoneCode = context.read<MyAccountCubit>().countryCodeSelected;
          isVerified = true;

          setState(() {});
        } else if (state is ErrorSignUpProviderOtpEdit) {
          AnimatedSnackBar.material(
            state.error,
            type: AnimatedSnackBarType.info,
          ).show(context);
        }
      },
      builder: (context, state) {
        print("_--------------");

        print(oldPhoneCode);
        print(myAccountCubit.countryCodeSelected);
        print(oldPhoneCode == myAccountCubit.countryCodeSelected);
        print("_--------------");

        print(oldPhone);
        print(myAccountCubit.phoneController.text);
        print(oldPhone == myAccountCubit.phoneController.text);
        print("_--------------");

        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.editProfile.tr(),
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return context.read<MyAccountCubit>().refresh();
            },
            color: appColors.primaryColorYellow,
            child: SingleChildScrollView(
              child: SafeArea(
                child: ConditionalBuilder(
                    condition: state is! LoadingGetProvider,
                    builder: (BuildContext context) => Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomTextFieldPrimary(
                                        hintText: LocaleKeys.name.tr(),
                                        externalController: context
                                            .read<MyAccountCubit>()
                                            .nameController,
                                        validator: Validators.validateNotEmpty,
                                        title: LocaleKeys.name.tr()),
                                    CustomTextFieldPrimary(
                                        hintText: LocaleKeys.email.tr(),
                                        validator: Validators.validateEmail,
                                        externalController: context
                                            .read<MyAccountCubit>()
                                            .emailController,
                                        title: LocaleKeys.email.tr()),
                                    verticalSpace(10.h),
                                    IntlPhoneField(
                                      languageCode: 'ar',
                                      pickerDialogStyle: PickerDialogStyle(
                                        backgroundColor: appColors.grey3,
                                        searchFieldInputDecoration:
                                            customInputDecorationPhone(),
                                      ),
                                      validator: (p0) =>
                                          Validators.validatePhoneNumber(
                                              p0?.completeNumber),
                                      controller: context
                                          .read<MyAccountCubit>()
                                          .phoneController,
                                      disableLengthCheck: false,
                                      initialCountryCode: context
                                                  .read<MyAccountCubit>()
                                                  .clientProfile!
                                                  .data!
                                                  .account!
                                                  .phoneCode !=
                                              null
                                          ? getCountryCodeFromDialingCode(
                                              context
                                                  .read<MyAccountCubit>()
                                                  .clientProfile!
                                                  .data!
                                                  .account!
                                                  .phoneCode!
                                                  .toString())
                                          : '966',
                                      decoration: customInputDecoration(),
                                      onChanged: (phone) {
                                        print(phone.countryCode);
                                        context
                                                .read<MyAccountCubit>()
                                                .countryCodeSelected =
                                            removePlusSign(phone.countryCode);
                                        setState(() {});
                                      },
                                      onCountryChanged: (phone) {
                                        print(phone.dialCode);
                                        context
                                                .read<MyAccountCubit>()
                                                .countryCodeSelected =
                                            removePlusSign(phone.dialCode);
                                        setState(() {});
                                      },
                                    ),
                                    context
                                                .read<MyAccountCubit>()
                                                .countryCodeSelected ==
                                            "966"
                                        ? Container(
                                            child: oldPhone !=
                                                    context
                                                        .read<MyAccountCubit>()
                                                        .phoneController
                                                        .text
                                                ? Row(
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons
                                                            .xmark_circle_fill,
                                                        color: Colors.red,
                                                        size: 18,
                                                      ),
                                                      horizontalSpace(4.w),
                                                      Text(
                                                        "برجاء تأكيد رقم الهاتف الجديد",
                                                        style: TextStyles
                                                            .cairo_12_bold,
                                                      ),
                                                      Spacer(),
                                                      CupertinoButton(
                                                        child: Text("تأكيد"),
                                                        onPressed: () {
                                                          var cubit = context.read<
                                                              MyAccountCubit>();
                                                          cubit.validatePhone(
                                                              cubit
                                                                  .phoneController
                                                                  .text,
                                                              cubit
                                                                  .countryCodeSelected
                                                                  .toString());
                                                          phone = cubit
                                                              .phoneController
                                                              .text;
                                                        },
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.verified,
                                                        color: Colors.green,
                                                        size: 18,
                                                      ),
                                                      horizontalSpace(4.w),
                                                      Text(
                                                        "رقم الهاتف مؤكد",
                                                        style: TextStyles
                                                            .cairo_12_bold,
                                                      ),
                                                    ],
                                                  ),
                                          )
                                        : Container(),
                                    verticalSpace(10.h),
                                    CustomContainerEditSignUp(
                                      title: LocaleKeys.accountType.tr(),
                                      child: CustomDropdown<String>(
                                        hintBuilder: (context, hint, enabled) {
                                          return Text(
                                            LocaleKeys.chooseYourAccountType
                                                .tr(),
                                            style: TextStyle(
                                              color: appColors.blue100,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                        items: context
                                            .read<MyAccountCubit>()
                                            .accountType
                                            .keys
                                            .map((key) => key.toString())
                                            .toList(),
                                        validator: (p0) =>
                                            Validators.validateNotEmpty(p0),
                                        initialItem: context
                                                .read<MyAccountCubit>()
                                                .accountType
                                                .values
                                                .contains(context
                                                    .read<MyAccountCubit>()
                                                    .accountTypeValue)
                                            ? context
                                                .read<MyAccountCubit>()
                                                .accountTypeValueName
                                            : null,
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            final selectedValue = context
                                                .read<MyAccountCubit>()
                                                .accountType[value];
                                            if (selectedValue != null) {
                                              context
                                                      .read<MyAccountCubit>()
                                                      .accountTypeValue =
                                                  selectedValue;

                                              // Optionally update `accountTypeValueName` to reflect the selected key
                                              context
                                                  .read<MyAccountCubit>()
                                                  .accountTypeValueName = value;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    ConditionalBuilder(
                                      condition: context
                                                  .read<MyAccountCubit>()
                                                  .nationalities !=
                                              null &&
                                          context
                                                  .read<MyAccountCubit>()
                                                  .countries !=
                                              null,
                                      builder: (BuildContext context) =>
                                          Animate(
                                        effects: const [
                                          FadeEffect(
                                            duration:
                                                Duration(milliseconds: 500),
                                          ),
                                        ],
                                        child: Column(
                                          children: [
                                            CustomContainerEditSignUp(
                                                title:
                                                    LocaleKeys.nationality.tr(),
                                                child: CustomDropdown.search(
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return LocaleKeys
                                                          .nationality
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  hintText: LocaleKeys
                                                      .nationality
                                                      .tr(),
                                                  initialItem: context
                                                      .read<MyAccountCubit>()
                                                      .targetNationality,
                                                  items: context
                                                      .read<MyAccountCubit>()
                                                      .nationalities!
                                                      .data!
                                                      .nationalities,
                                                  onChanged: (value) {
                                                    context
                                                            .read<MyAccountCubit>()
                                                            .selectedNationality =
                                                        value!.id!;
                                                  },
                                                )),
                                            CustomContainerEditSignUp(
                                                title: LocaleKeys.country.tr(),
                                                child: CustomDropdown.search(
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return LocaleKeys
                                                          .pleaseSelectCountry
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  hintText:
                                                      LocaleKeys.country.tr(),
                                                  initialItem: context
                                                      .read<MyAccountCubit>()
                                                      .targetCountry,
                                                  items: context
                                                      .read<MyAccountCubit>()
                                                      .countries!
                                                      .data!
                                                      .countries,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .selectCounrty(
                                                              value!.regions!,
                                                              value.id!,
                                                              value.phoneCode!);
                                                    });
                                                  },
                                                )),
                                            ConditionalBuilder(
                                              condition: context
                                                      .read<MyAccountCubit>()
                                                      .selectedCountry !=
                                                  -1,
                                              builder: (c) =>
                                                  ConditionalBuilder(
                                                condition: context
                                                    .read<MyAccountCubit>()
                                                    .regions!
                                                    .isNotEmpty,
                                                builder: (BuildContext
                                                        context) =>
                                                    CustomContainerEditSignUp(
                                                  title: LocaleKeys.region.tr(),
                                                  child: CustomDropdown<Region>(
                                                    hintText:
                                                        LocaleKeys.region.tr(),
                                                    initialItem: context
                                                        .read<MyAccountCubit>()
                                                        .targetRegion,
                                                    items: context
                                                        .read<MyAccountCubit>()
                                                        .regions!,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                MyAccountCubit>()
                                                            .selectRegion(
                                                                value!.cities!,
                                                                value.id!);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                fallback: (BuildContext
                                                        context) =>
                                                    const Text("لا يوجد منطقة"),
                                              ),
                                              fallback:
                                                  (BuildContext context) =>
                                                      const SizedBox(),
                                            ),
                                            ConditionalBuilder(
                                              condition: context
                                                      .read<MyAccountCubit>()
                                                      .selectedRegion !=
                                                  -1,
                                              builder: (c) =>
                                                  ConditionalBuilder(
                                                condition: context
                                                    .read<MyAccountCubit>()
                                                    .cities!
                                                    .isNotEmpty,
                                                builder: (BuildContext
                                                        context) =>
                                                    CustomContainerEditSignUp(
                                                  title: LocaleKeys.city.tr(),
                                                  child: CustomDropdown<City>(
                                                    hintText: LocaleKeys
                                                        .selectCity
                                                        .tr(),
                                                    initialItem: context
                                                        .read<MyAccountCubit>()
                                                        .targetCity,
                                                    items: context
                                                        .read<MyAccountCubit>()
                                                        .cities,
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .selectDistricts(
                                                              value!.id!);
                                                    },
                                                  ),
                                                ),
                                                fallback: (BuildContext
                                                        context) =>
                                                    const Text("لا يوجد مدن"),
                                              ),
                                              fallback: (context) => SizedBox(),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.location.tr(),
                                                    style: TextStyles
                                                        .cairo_14_semiBold
                                                        .copyWith(
                                                      color: appColors.blue100,
                                                    ),
                                                  ),
                                                  verticalSpace(10.h),
                                                  GestureDetector(
                                                    onTap: () => {
                                                      setState(() {
                                                        _getCurrentPosition();
                                                      })
                                                    },
                                                    child: Container(
                                                      height: 50.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 10.h),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            appColors.blue100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.sp),
                                                      ),
                                                      child: ConditionalBuilder(
                                                        condition:
                                                            locationLoading ==
                                                                true,
                                                        builder: (BuildContext
                                                                context) =>
                                                            const Center(
                                                          child:
                                                              CupertinoActivityIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        fallback: (BuildContext
                                                                context) =>
                                                            Animate(
                                                          effects: [
                                                            FadeEffect(
                                                                delay: 200.ms)
                                                          ],
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                context.read<MyAccountCubit>().currentPositionUser ==
                                                                        null
                                                                    ? LocaleKeys
                                                                        .selectLocation
                                                                        .tr()
                                                                    : '${context.read<MyAccountCubit>().currentPositionUser?.latitude}. تم اختيار الموقع',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      appColors
                                                                          .white,
                                                                ),
                                                              ),
                                                              const Icon(
                                                                CupertinoIcons
                                                                    .location,
                                                                color: appColors
                                                                    .white,
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
                                          ],
                                        ),
                                      ),
                                      fallback: (BuildContext context) =>
                                          const CupertinoActivityIndicator(),
                                    ),
                                    CustomContainerEditSignUp(
                                        title: LocaleKeys.gender.tr(),
                                        child: CustomDropdown(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'الرجاء اختيار الجنس';
                                            }
                                            return null;
                                          },
                                          hintText: LocaleKeys.gender.tr(),
                                          initialItem: context
                                              .read<MyAccountCubit>()
                                              .targetGender,
                                          items: context
                                              .read<MyAccountCubit>()
                                              .gender
                                              .keys
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<MyAccountCubit>()
                                                .gender
                                                .forEach((key, keyVal) {
                                              if (key == value) {
                                                context
                                                    .read<MyAccountCubit>()
                                                    .selectedGender = keyVal;
                                              }
                                            });
                                          },
                                        )),
                                    verticalSpace(16.0.h),
                                    CustomButton(
                                        title: LocaleKeys.save.tr(),
                                        onPress: () {
                                          if (oldPhone !=
                                                  context
                                                      .read<MyAccountCubit>()
                                                      .phoneController
                                                      .text &&
                                              context
                                                      .read<MyAccountCubit>()
                                                      .countryCodeSelected ==
                                                  "966") {
                                            AppAlerts.showAlert(
                                                context: context,
                                                message:
                                                    "برجاء تأكيد رقم الهاتف الجديد بالضغط علىتأكيد",
                                                buttonText: LocaleKeys
                                                    .continueNext
                                                    .tr(),
                                                type: AlertType.error);
                                          } else if (formKey.currentState!
                                              .validate()) {
                                            myAccountCubit
                                                .updateClientProfile();
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    fallback: (BuildContext context) => const Center(
                          child: CupertinoActivityIndicator(),
                        )),
              ),
            ),
          ),
        );
      },
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
      setState(
          () => context.read<MyAccountCubit>().currentPositionUser = position);
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
