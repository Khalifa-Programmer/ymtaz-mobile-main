import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

/// خدمة التحقق من صحة بيانات الملف الشخصي
///
/// توفر هذه الخدمة وظائف للتحقق من صحة البيانات المدخلة في نموذج تعديل الملف الشخصي
class ProfileValidationService {
  /// تحقق من صحة البيانات في الخطوة الصفرية
  /// 
  /// يقوم بالتحقق من رقم الهاتف والتأكد من صحة النموذج
  /// 
  /// يُرجع [true] إذا كانت البيانات صحيحة، [false] إذا كانت هناك مشكلة
  static bool validateStep0({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String oldPhone,
    required String oldPhoneCode,
  }) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    
    // التحقق من تغيير رقم الهاتف للأرقام السعودية
    if (oldPhone != cubit.phoneController.text &&
        cubit.providerphoneCode == "966") {
      _showAlert(
        context: context,
        message: "برجاء تأكيد رقم الهاتف الجديد بالضغط على تأكيد",
        buttonText: LocaleKeys.continueNext.tr(),
      );
      return false;
    } else if (formKey.currentState!.validate()) {
      // النموذج صحيح
      return true;
    }
    
    // النموذج غير صحيح
    return false;
  }

  /// تحقق من صحة البيانات في الخطوة الأولى
  /// 
  /// يقوم بالتحقق من البيانات المطلوبة في الخطوة الأولى مثل اسم الجهة ورقم الترخيص والمرفقات
  /// 
  /// يُرجع [true] إذا كانت البيانات صحيحة، [false] إذا كانت هناك مشكلة
  static bool validateStep1({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    
    // التحقق من وجود اسم الجهة إذا كان مطلوبا
    if (cubit.needCompanyName == 1 &&
        cubit.companyNameController.text.isEmpty) {
      showErrorMessage(
        context: context,
        message: "يرجى إدخال اسم الجهة",
      );
      return false;
    } 
    
    // التحقق من وجود رقم الترخيص إذا كان مطلوبا
    else if (cubit.needLicenseNo == 1 &&
        cubit.licenseNoController.text.isEmpty) {
      showErrorMessage(
        context: context,
        message: "يرجى إدخال رقم الترخيص",
      );
      return false;
    } 
    
    // التحقق من وجود رخصة الشركة إذا كانت مطلوبة
    else if (cubit.needLicenseFile == 1 &&
        cubit.licenseFileCompany == null &&
        !cubit.isNetworkImageCompany!) {
      showErrorMessage(
        context: context,
        message: "يرجى إرفاق رخصة الشركة",
      );
      return false;
    } 
    
    // التحقق من تاريخ الميلاد
    else if (cubit.selectedBirthDate == null) {
      showErrorMessage(
        context: context,
        message: "الرجاء اختيار تاريخ الميلاد و ملئ البيانات المطلوبة",
      );
      return false;
    } 
    
    // التحقق من وجود السيرة الذاتية للأفراد
    else if (cubit.accountTypeValue == 1 &&
        cubit.resumeImage == null &&
        !cubit.isNetworkImageCv!) {
      showErrorMessage(
        context: context,
        message: "يرجى إرفاق السيرة الذاتية بصفة فرد",
      );
      return false;
    } 
    
    // التحقق من صحة النموذج
    else if (validateForm(formKey)) {
      return true;
    }
    
    // في حالة فشل التحقق من صحة النموذج
    showErrorMessage(
      context: context,
      message: "يرجى التأكد من ملء البيانات كاملة",
    );
    return false;
  }

  /// تحقق من صحة البيانات في الخطوة الثانية
  /// 
  /// يقوم بالتحقق من البيانات المطلوبة في الخطوة الثانية مثل الموقع والمنطقة والمدينة
  /// 
  /// يُرجع [true] إذا كانت البيانات صحيحة، [false] إذا كانت هناك مشكلة
  static bool validateStep2({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    
    // التحقق من وجود الموقع
    if (cubit.currentPositionUser == null) {
      showErrorMessage(
        context: context,
        message: "يرجى اختيار موقع",
      );
      return false;
    } 
    
    // التحقق من صحة النموذج
    else if (validateForm(formKey)) {
      // للسعودية، يجب اختيار منطقة ومدينة
      if (cubit.selectedCountryPhoneCode == 966 &&
          cubit.selectedDistricts == -1) {
        showErrorMessage(
          context: context,
          message: "يجب اختيار منطقة و مدينة",
        );
        return false;
      } 
      
      // جميع الشروط محققة
      return true;
    }
    
    // في حالة فشل التحقق من صحة النموذج
    showErrorMessage(
      context: context,
      message: "يرجى التأكد من ملء البيانات كاملة",
    );
    return false;
  }

  /// تحقق من صحة البيانات في الخطوة الثالثة
  /// 
  /// يقوم بالتحقق من البيانات المطلوبة في الخطوة الثالثة مثل الهوية والتخصصات والرخص المهنية
  /// 
  /// يُرجع [true] إذا كانت البيانات صحيحة، [false] إذا كانت هناك مشكلة
  static bool validateStep3({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    
    // التحقق من وجود أي ملفات رخص مفقودة
    bool hasInvalidData = cubit.selectedSectionsNeedLicenseFiles.asMap().entries.any((entry) {
      int index = entry.key;
      return entry.value == null &&
          !cubit.selectedSectionsContainLicenseImageBool[index]!;
    });

    if (hasInvalidData) {
      showErrorMessage(
        context: context,
        message: "تاكد من ارفاقك ملفات الرخص المهنية",
      );
      return false;
    }

    // التحقق من ملف الهوية
    if (cubit.idImage == null && !cubit.isNetworkImageId!) {
      showErrorMessage(
        context: context,
        message: "يرجى إرفاق ملف الهوية",
      );
      return false;
    }

    // التحقق من إثبات الدرجة العلمية
    if (cubit.isNetworkImageDegree == false) {
      // إذا كانت الدرجة مميزة
      if (cubit.selectedDegreeIsSpecial) {
        if (cubit.degreeVerifyImage == null) {
          showErrorMessage(
            context: context,
            message: "يرجى إرفاق إثبات الدرجة العلمية المميزة.",
          );
          return false;
        }
      } else {
        // إذا كانت المهن المختارة لا تحتاج لترخيص، يجب إرفاق الدرجة
        if (cubit.selectedSectionsNeedLicense.isEmpty && cubit.degreeVerifyImage == null) {
          showErrorMessage(
            context: context,
            message: "يرجى إرفاق إثبات الدرجة العلمية.",
          );
          return false;
        }
      }

      // التحقق من الدرجة العلمية "أخرى"
      if (cubit.selectedDegree == 4 && cubit.degreeVerifyImage == null) {
        showErrorMessage(
          context: context,
          message: "يرجى إرفاق إثبات الدرجة العلمية واسم الدرجة.",
        );
        return false;
      }
    }

    // التحقق من صحة النموذج
    if (validateForm(formKey)) {
      return true;
    }
    
    // في حالة فشل التحقق من صحة النموذج
    showErrorMessage(
      context: context,
      message: "يرجى التأكد من ملء البيانات كاملة",
    );
    return false;
  }

  /// تحقق من صحة البيانات في الخطوة الرابعة
  /// 
  /// يقوم بالتحقق من البيانات المطلوبة في الخطوة الرابعة مثل الصورة الشخصية والشعار
  /// 
  /// يُرجع [true] إذا كانت البيانات صحيحة، [false] إذا كانت هناك مشكلة
  static bool validateStep4({
    required BuildContext context,
  }) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    
    // التحقق من شعار المؤسسة إذا كان مطلوباً
    if (cubit.logoImage == null &&
        (cubit.accountTypeValue == 2 || cubit.accountTypeValue == 3) &&
        !cubit.isNetworkImageCompany!) {
      showErrorMessage(
        context: context,
        message: "يرجى إرفاق شعار الشركة",
      );
      return false;
    }
    
    // جميع الشروط محققة
    return true;
  }

  /// التحقق من صحة نموذج معين
  ///
  /// يمكن استخدام هذه الدالة للتحقق من أي نموذج
  static bool validateForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// عرض رسالة تنبيه للمستخدم
  static void _showAlert({
    required BuildContext context, 
    required String message, 
    required String buttonText,
    AlertType type = AlertType.error,
  }) {
    AppAlerts.showAlert(
      context: context,
      message: message,
      buttonText: buttonText,
      type: type,
    );
  }

  /// عرض رسالة خطأ للمستخدم
  static void showErrorMessage({
    required BuildContext context, 
    required String message,
    String buttonText = "أعد المحاولة",
  }) {
    _showAlert(
      context: context,
      message: message,
      buttonText: buttonText,
      type: AlertType.error,
    );
  }
}
