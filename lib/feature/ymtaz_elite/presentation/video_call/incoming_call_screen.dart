import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/call_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/call_model.dart';
import 'package:yamtaz/feature/advisory_window/presentation/video_call/agora_video_call_screen.dart';

import 'package:yamtaz/core/helpers/file_helper.dart';

class IncomingCallScreen extends StatelessWidget {
  final CallModel call;

  const IncomingCallScreen({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2D37),
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(80.h),
            // Caller Avatar
            Center(
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(5.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.w),
                  child: Image.network(
                    FileHelper.resolveUrl("https://ymtaz.sa/uploads/person.png"), // Placeholder
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            verticalSpace(30.h),
            Text(
              "مكالمة واردة",
              style: TextStyle(
                color: const Color(0xFFD4AF37),
                fontSize: 16.sp,
                fontFamily: 'Cairo',
              ),
            ),
            verticalSpace(10.h),
            Text(
              "المستشار القانوني",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const Spacer(),
            // Call Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Reject Button
                  _buildCallAction(
                    icon: Icons.call_end,
                    color: Colors.red,
                    label: "رفض",
                    onTap: () {
                      context.read<CallCubit>().rejectCall(call.id.toString());
                      Navigator.pop(context);
                    },
                  ),
                  // Accept Button
                  _buildCallAction(
                    icon: Icons.call,
                    color: Colors.green,
                    label: "قبول",
                    onTap: () {
                      context.read<CallCubit>().acceptCall(call.id.toString());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgoraVideoCallScreen(
                            customToken: call.token,
                            customChannelName: call.channelName,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30.sp),
          ),
        ),
        verticalSpace(12.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
