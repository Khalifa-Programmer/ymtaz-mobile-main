import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';

class InviteShareButtons extends StatelessWidget {
  final VoidCallback onInviteTap;
  final VoidCallback onShareTap;

  const InviteShareButtons({
    super.key,
    required this.onInviteTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _buildButton(
          icon: AppAssets.userAdd,
          label: 'ادع أصدقاءك',
          onTap: onInviteTap,
        )),
        SizedBox(width: 12.w),
        Expanded(
            child: _buildButton(
          icon: AppAssets.shareIcon,
          label: 'شارك التطبيق',
          onTap: onShareTap,
        )),
      ],
    );
  }

  Widget _buildButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.lightYellow10.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 20.w),
                SvgPicture.asset(icon, width: 20.w, height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
