import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yamtaz/core/constants/colors.dart';

class AppTheme {
  static String fontFamily = "Cairo";
  static ThemeData appTheme = ThemeData(

      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: appColors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: Colors.grey[600],
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
                fontWeight: FontWeight.bold, color: appColors.blue100);
          }
          return const TextStyle(
            fontWeight: FontWeight.normal,
          );
        }),
      ),
      scaffoldBackgroundColor: appColors.white,
      fontFamily: fontFamily,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: appColors.primaryColorYellow),
      inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColors.primaryColorYellow),
          ),
          focusColor: appColors.primaryColorYellow),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColors.primaryColorYellow,
        selectionColor: appColors.primaryColorYellow.withOpacity(0.3),
        selectionHandleColor: appColors.primaryColorYellow,
      ));
}
