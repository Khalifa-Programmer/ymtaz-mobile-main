import 'package:flutter/material.dart';

class appColors {
  appColors._();

  // Light Theme Colors
  static const Color primaryColorYellow = Color(0xFFDDB762);
  static const Color darkYellow100 = Color(0xFFB89445);
  static const Color darkYellow90 = Color(0xFFF0CF86);
  static const Color darkYellow10 = Color(0xFFD3BD82);
  static const Color lightYellow10 = Color(0xFFF9EDD3);

  static const Color blue100 = Color(0xFF00262f);
  static const Color blue70 = Color(0xff24475d);
  static const Color blue90 = Color(0xFF2B4868);

  static const Color grey10 = Color(0xFF8F8F8F);
  static const Color grey1 = Color(0xFFF8F8F8);
  static const Color grey1w5 = Color(0xFFD9D9D9);
  static const Color grey5 = Color(0xFFB0B0B0);
  static const Color grey8 = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFFCACACA);
  static const Color grey3 = Color(0xFFF7F8FA);
  static const Color grey2 = Color(0xFFE6E6E6);
  static const Color grey15 = Color(0xFF808D9E);
  static const Color grey20 = Color(0xFFA6A4A4);

  static const Color black = Color(0xFF000000);
  static const Color green = Color(0xFF20AE5C);
  static const Color red = Color(0xFFDA2D2D);
  static const Color red5 = Color(0xFFF5BABA);
  static const Color redLight = Color(0xFAFE1111);

  static const Color white = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF1E1E1E);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF222222);
  static const Color darkOnPrimary = Color(0xFFDDB762);
  static const Color darkOnSecondary = Color(0xFFF0CF86);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFD3BD82);
  static const Color gold = Color(0xFFFFD700); // Define the gold color
}

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColorYellow;
  final Color blue100;
  final Color darkPrimaryColor;
  final Color darkBackground;
  final Color darkSurface;

  AppColors({
    required this.primaryColorYellow,
    required this.blue100,
    required this.darkPrimaryColor,
    required this.darkBackground,
    required this.darkSurface,
  });

  @override
  AppColors copyWith({
    Color? primaryColorYellow,
    Color? blue100,
    Color? darkPrimaryColor,
    Color? darkBackground,
    Color? darkSurface,
  }) {
    return AppColors(
      primaryColorYellow: primaryColorYellow ?? this.primaryColorYellow,
      blue100: blue100 ?? this.blue100,
      darkPrimaryColor: darkPrimaryColor ?? this.darkPrimaryColor,
      darkBackground: darkBackground ?? this.darkBackground,
      darkSurface: darkSurface ?? this.darkSurface,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryColorYellow:
          Color.lerp(primaryColorYellow, other.primaryColorYellow, t)!,
      blue100: Color.lerp(blue100, other.blue100, t)!,
      darkPrimaryColor:
          Color.lerp(darkPrimaryColor, other.darkPrimaryColor, t)!,
      darkBackground: Color.lerp(darkBackground, other.darkBackground, t)!,
      darkSurface: Color.lerp(darkSurface, other.darkSurface, t)!,
    );
  }
}
