import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';

import '../../config/themes/styles.dart';
import '../constants/assets.dart';
import 'custom_button.dart';

enum AlertType { error, success, warning }

class AppAlerts {
  const AppAlerts._(); // Private constructor to prevent instantiation

  static void showAlert({
    required BuildContext context,
    required String message,
    String? route,
    bool isForceRouting = true,
    required String buttonText,
    required AlertType type,
  }) {
    Color titleColor =
        type == AlertType.error ? appColors.red : appColors.green;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: appColors.white,
          surfaceTintColor: appColors.white,
          content: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    // SvgPicture.asset(
                    //     width: 50.w,
                    //     height: 50.h,
                    //     type == AlertType.error
                    //     ? AppAssets.mainLogo
                    //     : AppAssets.mainLogo),
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    Text(
                      textDirection: TextDirection.rtl,
                      type == AlertType.error ? "خطأ" : "نجاح",
                      style:
                          TextStyles.cairo_24_bold.copyWith(color: titleColor),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      message,
                      style: TextStyles.cairo_14_medium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 238.w,
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
                    color: type == AlertType.error
                        ? appColors.red
                        : appColors.green,
                    onPressed: () {
                      if (route != null) {
                        if (isForceRouting) {
                          context.pushNamedAndRemoveUntil(route,
                              predicate: (route) => false);
                        } else {
                          context.pushNamed(route);
                        }
                      } else {
                        context.pop();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyles.cairo_16_semiBold
                          .copyWith(color: Colors.white),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showYesOrNoAlert({
    required BuildContext context,
    required String message,
    String? route,
    bool isForceRouting = true,
    required String buttonText,
    required AlertType type,
  }) {
    Color titleColor =
        type == AlertType.error ? appColors.red : appColors.green;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: appColors.white,
          surfaceTintColor: appColors.white,
          content: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    // SvgPicture.asset(
                    //     width: 50.w,
                    //     height: 50.h,
                    //     type == AlertType.error
                    //     ? AppAssets.mainLogo
                    //     : AppAssets.mainLogo),
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    Text(
                      textDirection: TextDirection.rtl,
                      type == AlertType.error ? "خطأ" : "نجاح",
                      style:
                          TextStyles.cairo_24_bold.copyWith(color: titleColor),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      message,
                      style: TextStyles.cairo_14_medium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 238.w,
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
                    color: type == AlertType.error
                        ? appColors.red
                        : appColors.green,
                    onPressed: () {
                      if (route != null) {
                        if (isForceRouting) {
                          context.pushNamedAndRemoveUntil(route,
                              predicate: (route) => false);
                        } else {
                          context.pushNamed(route);
                        }
                      } else {
                        context.pop();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyles.cairo_16_semiBold
                          .copyWith(color: Colors.white),
                    )),
              ),
            ),
            Center(
              child: SizedBox(
                width: 238.w,
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
                    color: type == AlertType.error
                        ? appColors.red
                        : appColors.green,
                    onPressed: () {
                      if (route != null) {
                        if (isForceRouting) {
                          context.pushNamedAndRemoveUntil(route,
                              predicate: (route) => false);
                        } else {
                          context.pushNamed(route);
                        }
                      } else {
                        context.pop();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyles.cairo_16_semiBold
                          .copyWith(color: Colors.white),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showAlertWithoutError({
    required BuildContext context,
    required String message,
    String? route,
    required String buttonText,
    required AlertType type,
  }) {
    // Color titleColor =
    //     type == AlertType.error ? ColorsPalletes.red : ColorsPalletes.green;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appColors.white,
          content: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    SvgPicture.asset(type == AlertType.error
                        ? AppAssets.mainLogo
                        : AppAssets.mainLogo),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      message,
                      style: TextStyles.cairo_16_medium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            CustomButton(
              width: 238.w,
              bgColor: type == AlertType.error
                  ? appColors.red
                  : type == AlertType.warning
                      ? appColors
                          .primaryColorYellow // Replace with the desired color for warning
                      : appColors.green,
              onPress: () {
                if (route != null) {
                  context.pushNamedAndRemoveUntil(route,
                      predicate: (route) => false);
                } else {
                  context.pop();
                }
              },
              title: buttonText,
            ),
          ],
        );
      },
    );
  }
}
