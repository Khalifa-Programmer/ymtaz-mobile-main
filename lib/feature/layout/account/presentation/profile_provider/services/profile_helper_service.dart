import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';

class ProfileHelperService {

  static bool validateForm({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      if (context.read<SignUpCubit>().selectedBirthDate == null) {
        return false;
      }
      form.save();
      return true;
    }
    return false;
  }

  static Future<void> getCurrentPosition({
    required BuildContext context,
    required Function(bool) setLoadingState,
    required Function(Position) onPositionReceived,
  }) async {
    setLoadingState(true);

    final hasPermission = await _getLocationPermission(context);
    if (!hasPermission) {
      setLoadingState(false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      onPositionReceived(position);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoadingState(false);
    }
  }

  /// التحقق من أذونات الموقع
  ///
  /// يتحقق من أذونات الموقع ويطلبها إذا لزم الأمر
  static Future<bool> _getLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // عرض حوار يطلب من المستخدم فتح إعدادات الموقع
      bool? openSettings = await _showLocationServiceDialog(context);
      if (openSettings != null && openSettings) {
        openLocationSettings();
      }
      return false;
    }

    // التحقق من أذونات الموقع
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

    // التحقق من أن الأذونات لم يتم رفضها بشكل دائم
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم رفض أذونات الموقع بشكل دائم، لا يمكننا طلب الأذونات.'),
        ),
      );
      return false;
    }

    return true;
  }

  /// عرض حوار خدمة الموقع
  ///
  /// يعرض حوار يطلب من المستخدم فتح إعدادات الموقع
  static Future<bool?> _showLocationServiceDialog(BuildContext context) {
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
                  openLocationSettings(); // فتح إعدادات الموقع
                }
              },
            ),
          ],
        );
      },
    );
  }

  /// فتح إعدادات الموقع
  ///
  /// يفتح إعدادات الموقع على الجهاز
  static void openLocationSettings() {
    // سيفتح إعدادات الموقع على الجهاز باستخدام android_intent_plus
    const intent = AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    intent.launch().catchError((e) {
      print('خطأ في إطلاق النية: $e');
    });
  }

  /// اختيار التاريخ
  ///
  /// يعرض منتقي التاريخ ويحدث قيمة تاريخ الميلاد
  static Future<void> selectDate({
    required BuildContext context,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  /// إخفاء لوحة المفاتيح
  ///
  /// يخفي لوحة المفاتيح الظاهرة على الشاشة
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// عرض صورة في حوار
  ///
  /// يعرض الصورة المحددة في حوار منبثق
  static void viewImage(BuildContext context, File? image) {
    if (image == null) return;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('X'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
