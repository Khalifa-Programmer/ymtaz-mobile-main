import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({super.key, this.height = 70});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.white,
    );
  }
}
