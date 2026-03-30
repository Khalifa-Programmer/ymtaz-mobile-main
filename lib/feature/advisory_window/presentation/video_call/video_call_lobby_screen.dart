import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/config/themes/styles.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/spacing.dart';
import 'agora_video_call_screen.dart';

class VideoCallLobbyScreen extends StatefulWidget {
  final int durationMinutes;
  final String date;
  final String time;

  const VideoCallLobbyScreen({
    Key? key,
    required this.durationMinutes,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<VideoCallLobbyScreen> createState() => _VideoCallLobbyScreenState();
}

class _VideoCallLobbyScreenState extends State<VideoCallLobbyScreen> {
  bool _isMicMuted = false;
  bool _isVideoDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: Text(
          "استشارة مرئية",
          style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appColors.blue100),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Spacer(flex: 2),
            
            // Video and Mic Toggles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _toggleButton(
                  icon: _isVideoDisabled ? Icons.videocam_off : Icons.videocam,
                  isActive: !_isVideoDisabled,
                  onTap: () {
                    setState(() {
                      _isVideoDisabled = !_isVideoDisabled;
                    });
                  },
                ),
                horizontalSpace(20.w),
                _toggleButton(
                  icon: _isMicMuted ? Icons.mic_off : Icons.mic,
                  isActive: !_isMicMuted,
                  isRed: _isMicMuted,
                  onTap: () {
                    setState(() {
                      _isMicMuted = !_isMicMuted;
                    });
                  },
                ),
              ],
            ),
            
            Spacer(flex: 2),

            // Warning Banner
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: appColors.primaryColorYellow, size: 20.sp),
                      horizontalSpace(8.w),
                      Text("تحذير", style: TextStyles.cairo_14_bold.copyWith(color: appColors.grey15)),
                    ],
                  ),
                  verticalSpace(5.h),
                  Text(
                    "هذه المكالمة مدتها \${widget.durationMinutes} دقيقة فقط تبدأ من الموعد المحدد مسبقًا.",
                    style: TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(15.h),
                  Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined, color: appColors.primaryColorYellow, size: 20.sp),
                      horizontalSpace(8.w),
                      Text("الخصوصية والأمان", style: TextStyles.cairo_14_bold.copyWith(color: appColors.grey15)),
                    ],
                  ),
                  verticalSpace(5.h),
                  Text(
                    "جميع الحقوق محفوظة تبعًا للشروط والأحكام الموافق عليها.",
                    style: TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
                  ),
                ],
              ),
            ),
            
            Spacer(flex: 1),

            // Join Button
            CustomButton(
              onPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgoraVideoCallScreen(
                      // We can pass initial mute/video states here if we modify AgoraVideoCallScreen to accept them
                    ),
                  ),
                );
              },
              title: "الانضمام",
              height: 50.h,
              fontSize: 16.sp,
              bgColor: appColors.primaryColorYellow,
            ),
            verticalSpace(20.h),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton({
    required IconData icon,
    required bool isActive,
    bool isRed = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: isRed ? Colors.red : (isActive ? appColors.grey3 : appColors.grey5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isRed ? Colors.white : (isActive ? appColors.grey15 : Colors.white),
          size: 28.sp,
        ),
      ),
    );
  }
}
