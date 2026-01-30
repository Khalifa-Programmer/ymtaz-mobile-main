import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/themes/styles.dart';
import '../../../../../../core/constants/colors.dart';

class PrivacySecurityCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;

  const PrivacySecurityCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: appColors.primaryColorYellow),
            borderRadius:
                BorderRadius.circular(4.0.sp), // Customize border radius
          ),
          fillColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return appColors.primaryColorYellow; // Selected color
              }
              return null; // Unselected color
            },
          ),
        ),
        Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyles.cairo_12_semiBold,
        ),
      ],
    );
  }
}
