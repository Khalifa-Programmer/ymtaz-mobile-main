import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DesignSystem {
  DesignSystem._();

  /// Shared Icon Widget To [png Icons] in [Assets/icons]
  static Widget iconWidget({
    Function()? onTap,
    required String iconName,
    bool isDirectional = false,
    double? size,
    double? height,
    double? width,
    Color? iconColor,
    BoxFit? fit,
  }) =>
      InkWell(
        onTap: onTap,
        child: Image.asset(
          iconName,
          matchTextDirection: isDirectional,
          color: iconColor,
          height: height ?? size ?? 24.h,
          width: width ?? size ?? 24.w,
          fit: fit,
        ),
      );

  /// Shared Image Widget To [png Images] in [Assets/images]
  static Widget imageWidget({
    Function()? onTap,
    required String imageName,
    bool isDirectional = false,
    double? size,
    double? height,
    double? width,
    Color? imageColor,
    BoxFit? boxFit,
  }) =>
      InkWell(
        onTap: onTap,
        child: Image.asset(
          imageName,
          matchTextDirection: isDirectional,
          fit: boxFit ?? BoxFit.fill,
          color: imageColor,
          height: height ?? size ?? 24.h,
          width: width ?? size ?? 24.w,
        ),
      );

  /// Shared SVGs Widget To [Svg Icons] in [Assets/svgs]
  static Widget svgWidget({
    Function()? onTap,
    required String svgName,
    bool isDirectional = false,
    double? size,
    double? height,
    double? width,
    Color? svgColor,
    BoxFit? boxFit,
  }) =>
      InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          svgName,
          matchTextDirection: isDirectional,
          fit: boxFit ?? BoxFit.fill,
          color: svgColor,
          height: height ?? size ?? 24.h,
          width: width ?? size ?? 24.h,
        ),
      );
}
