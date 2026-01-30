import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/more_info/privacy_policy.dart';

import '../../../../../../core/router/routes.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  final String? route;

  const TermsAndConditionsDialog(this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: const Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        child: PrivacyPolicy(),
      ),
      actions: [
        // Center(
        //   child: CupertinoButton(
        //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        //     color: appColors.green,
        //     onPressed: () {
        //       context.pushNamedAndRemoveUntil(route ?? Routes.verify,
        //           predicate: (Route<dynamic> route) => false, arguments: 1);
        //     },
        //     child: Text(
        //       "قرأت وأوافق على الشروط والأحكام",
        //       style: TextStyles.cairo_12_bold.copyWith(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

void showTermsAndConditionsDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return TermsAndConditionsDialog(
        Routes.verify,
      );
    },
  );
}

class TermsAndConditionsDialogNew extends StatelessWidget {
  final String? route;
  Map<String, dynamic> data;

  TermsAndConditionsDialogNew({super.key, this.route, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        'الشروط والاحكام',
        style: TextStyle(
            color: appColors.blue100,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp),
      ),
      content: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          child: PrivacyPolicy(),
        ),
      ),
      actions: [
        Center(
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            color: appColors.green,
            onPressed: () {
              context.pop();
              context.pushNamed(route!, arguments: data);
            },
            child: Text(
              "قرأت وأوافق على الشروط والأحكام",
              style: TextStyles.cairo_12_bold.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

void showTermsAndConditionsDialognew(
    BuildContext context, String newRoute, Map<String, dynamic> data) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return TermsAndConditionsDialogNew(route: newRoute, data: data);
    },
  );
}
