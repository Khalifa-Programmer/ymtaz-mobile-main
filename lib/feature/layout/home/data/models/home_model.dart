import 'package:flutter_svg/flutter_svg.dart';

class HomeModel {
  final String title;
  final String description;
  final SvgPicture icon;
  String? route;
  List<String>? subSpecializations;

  HomeModel({
    required this.title,
    required this.description,
    required this.icon,
    this.route,
    this.subSpecializations,
  });
}
