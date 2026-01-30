import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../config/themes/styles.dart';
import '../../../../../../core/constants/colors.dart';

class PinCodeWidget extends StatelessWidget {
  PinCodeWidget({super.key, required this.pinOtpController});

  final pinOtpController;
  final focusNode = FocusNode();
  final length = 6;
  final borderColor = appColors.primaryColorYellow;
  final errorColor = appColors.red;
  final fillColor = appColors.grey5;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyles.cairo_16_bold,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: appColors.primaryColorYellow),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Animate(
        effects: const [FadeEffect(delay: Duration(milliseconds: 300))],
        child: SizedBox(
          height: 77.h,
          child: Pinput(
            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            length: length,
            // validator: Validators.validateNotEmpty,
            controller: pinOtpController,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: fillColor),
              ),
            ),
            onCompleted: (pin) {},
            focusedPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: borderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: BoxDecoration(
                color: errorColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinCodeAlertWidget extends StatelessWidget {
  PinCodeAlertWidget({super.key, required this.pinOtpController});

  final pinOtpController;
  final focusNode = FocusNode();
  final length = 6;
  final borderColor = appColors.primaryColorYellow;
  final errorColor = appColors.red;
  final fillColor = appColors.grey5;
  final defaultPinTheme = PinTheme(
    width: 30,
    height: 30,
    textStyle: TextStyles.cairo_16_bold,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: appColors.primaryColorYellow),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Animate(
        effects: const [FadeEffect(delay: Duration(milliseconds: 300))],
        child: SizedBox(
          height: 40.h,
          child: Pinput(
            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            length: length,
            // validator: Validators.validateNotEmpty,
            controller: pinOtpController,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: fillColor),
              ),
            ),
            onCompleted: (pin) {},
            focusedPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: borderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              height: 62.h,
              width: 58.w,
              decoration: BoxDecoration(
                color: errorColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
