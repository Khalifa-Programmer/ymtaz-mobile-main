import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

class Validators {
  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validateNotEmpty
          .tr(); // Provide an appropriate error message
    }
    return null; // Return null if validation passes
  }

  static String? validatePasswordMatch(
      String? password, String? confirmPassword) {
    if (password != confirmPassword &&
        password!.length != confirmPassword!.length) {
      return "كلمة السر غير متطابقة"; // Provide an appropriate error message
    }
    return null; // Return null if validation passes
  }

  static String? validateExactly10Characters(String? value) {
    if (value == null || value.length != 10) {
      return 'يجب ان يكون ١٠ ارقام فقط'; // Provide an appropriate error message
    }
    return null; // Return null if validation passes
  }

  static String? validateEmail(String? value) {
    // Simple email validation regex
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value == null || !emailRegex.hasMatch(value)) {
      return LocaleKeys.validateEmail
          .tr(); // Provide an appropriate error message
    }
    return null; // Return null if validation passes
  }

  static String? validatePhoneNumber(String? value) {
    // Simple phone number validation regex
    final phoneRegex = RegExp(r'^\+?\d{10,}$');

    if (value == null || value.isEmpty || !phoneRegex.hasMatch(value)) {
      return LocaleKeys.validatePhoneNumber
          .tr(); // Provide an appropriate error message
    }

    return null; // Return null if validation passes
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validatePassword.tr();
    }

    // Define the regular expression
    final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

    if (!passwordRegex.hasMatch(value)) {
      return LocaleKeys.passwordComplexity.tr();
    }

    if (value.length < 8) {
      return LocaleKeys.passwordLength.tr();
    }

    return null; // Password is valid
  }
}
