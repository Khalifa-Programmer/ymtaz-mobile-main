import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0.h),
      child: ListTile(
          // tileColor: ColorsPalletes.grey3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Icon(
            icon,
            color: appColors.primaryColorYellow, // Change to your desired color
          ),
          title: Text(
            title,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: appColors.blue100,
            ),
          ),
          onTap: onTap,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15.sp,
            color: appColors.blue100,
          )),
    );
  }
}
