import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';

List<Map<String, dynamic>> services = [
  { 'id': 1, 'name': 'التوثيق الازرق', 'icon': AppAssets.verify },
  { 'id': 2, 'name': 'اشتراك في النشرة البريدية القانونية', 'icon': AppAssets.mail },
  { 'id': 3, 'name': 'لاندنج بيج خاصة بالمحامي', 'icon': AppAssets.window },
  { 'id': 4, 'name': 'ظهوره في مقدمي الخدمة المميزين في الرئيسية في يمتاز', 'icon': AppAssets.crown},
  { 'id': 5, 'name': 'الحصول على تصميم مميز في الدليل الرقمي', 'icon': AppAssets.customDesign },
  { 'id': 6, 'name': 'تميز الحساب في البحث السريع', 'icon': AppAssets.star},
  { 'id': 7, 'name': 'توثيق الحساب الذهبية', 'icon': AppAssets.verify },
  { 'id': 8, 'name': 'الحصول على دعم فني وقانوني من يمتاز', 'icon':AppAssets.contact },
];

Widget getFeatureRowById(int id , String name) {
  // البحث عن الميزة بناءً على الـ id
  var feature = services.firstWhere(
        (service) => service['id'] == id,
    orElse: () => {'id': 0, 'name': 'ميزة غير موجودة', 'icon': 'assets/icons/default_icon.svg'},
  );

  // إرجاع Row يحتوي على الأيقونة والاسم
  return Row(
    children: [
      SvgPicture.asset(
        feature['icon'],
        width: 20,
        height: 20,
        placeholderBuilder: (context) => CircularProgressIndicator(), // عرض مؤشر التحميل إذا كانت الأيقونة قيد التحميل
      ),
      SizedBox(width: 8),
      Expanded(child: Text(name, style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.blue100))),
    ],
  );
}