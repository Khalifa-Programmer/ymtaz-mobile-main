import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../../../config/themes/styles.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/validators.dart';
import '../../../../../../../core/helpers/shared_functions.dart';
import '../../../../../../../core/widgets/custom_decoration_style.dart';
import '../../../../../../../core/widgets/primary/text_form_primary.dart';
import '../../../../../../../core/widgets/spacing.dart';
import '../../../../../../../core/widgets/textform_auth_field.dart';
import '../../../../../../../l10n/locale_keys.g.dart';
import '../../../../../../auth/sign_up/logic/sign_up_cubit.dart';

class ZeroStepForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String oldPhone;
  final String oldPhoneCode;
  final VoidCallback onConfirmPhone;
  final Function(String) onPhoneChanged;

  const ZeroStepForm({
    super.key,
    required this.formKey,
    required this.oldPhone,
    required this.oldPhoneCode,
    required this.onConfirmPhone,
    required this.onPhoneChanged,
  });

  @override
  State<ZeroStepForm> createState() => _ZeroStepFormState();
}

class _ZeroStepFormState extends State<ZeroStepForm> {
  bool isVerified = true;

  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();
    
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(20.h),
            _buildNameFields(signUpCubit),
            _buildEmailField(signUpCubit),
            _buildPhoneField(signUpCubit),
            _buildPhoneVerificationStatus(signUpCubit),
          ],
        ),
      )
    );
  }

  Widget _buildNameFields(SignUpCubit signUpCubit) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: CustomAuthTextField(
                validator: Validators.validateNotEmpty,
                hintText: LocaleKeys.firstNamePlaceholder.tr(),
                externalController: signUpCubit.providerFirstNameController,
                title: LocaleKeys.firstName.tr()
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: CustomAuthTextField(
                validator: Validators.validateNotEmpty,
                hintText: LocaleKeys.secondNamePlaceholder.tr(),
                externalController: signUpCubit.providerSecondNameController,
                title: LocaleKeys.secondName.tr()
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: CustomAuthTextFieldWithOutValidate(
                hintText: LocaleKeys.thirdNamePlaceholder.tr(),
                externalController: signUpCubit.providerThirdNameController,
                title: LocaleKeys.thirdName.tr()
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: CustomAuthTextField(
                validator: Validators.validateNotEmpty,
                hintText: LocaleKeys.fourthNamePlaceholder.tr(),
                externalController: signUpCubit.providerFourthNameController,
                title: LocaleKeys.fourthName.tr()
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailField(SignUpCubit signUpCubit) {
    return CustomTextFieldPrimary(
      hintText: LocaleKeys.email.tr(),
      externalController: signUpCubit.emailController,
      validator: Validators.validateEmail,
      title: LocaleKeys.email.tr()
    );
  }

  Widget _buildPhoneField(SignUpCubit signUpCubit) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: IntlPhoneField(
        languageCode: 'ar',
        pickerDialogStyle: PickerDialogStyle(
          backgroundColor: appColors.grey3,
          searchFieldInputDecoration: customInputDecorationPhone(),
        ),
        validator: (p0) => Validators.validatePhoneNumber(p0?.completeNumber),
        controller: signUpCubit.phoneController,
        disableLengthCheck: false,
        initialCountryCode: getCountryCodeFromDialingCode(signUpCubit.providerphoneCode),
        decoration: customInputDecoration(),
        onChanged: (phone) {
          signUpCubit.phoneController.text = phone.number;
          widget.onPhoneChanged(phone.number);
          setState(() {});
        },
        onCountryChanged: (phone) {
          signUpCubit.providerphoneCode = phone.dialCode;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPhoneVerificationStatus(SignUpCubit signUpCubit) {
    if (signUpCubit.providerphoneCode != "966") {
      return const SizedBox();
    }

    bool isPhoneChanged = widget.oldPhone != signUpCubit.phoneController.text;
    
    return Container(
      child: isPhoneChanged
        ? Row(
            children: [
              const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.red,
                size: 18,
              ),
              horizontalSpace(4.w),
              Text(
                "برجاء تأكيد رقم الهاتف الجديد",
                style: TextStyles.cairo_12_bold,
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: widget.onConfirmPhone,
                child: const Text("تأكيد"),
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
                style: TextStyles.cairo_12_bold,
              ),
            ],
          ),
    );
  }
}
