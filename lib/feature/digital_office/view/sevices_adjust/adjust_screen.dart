import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/my_products_settings.dart';

import '../../../../core/constants/colors.dart';

class AdjustScreen extends StatelessWidget {
  const AdjustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التخصيص',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: const Column(
          children: [
            MyProductsSetting(),
          ],
        ),
      ),
    );
  }
}
