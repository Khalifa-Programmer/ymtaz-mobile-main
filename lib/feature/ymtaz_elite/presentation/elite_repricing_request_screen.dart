import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/recorder_player_widget.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';

class EliteRepricingRequestScreen extends StatefulWidget {
  final Request request;
  final TypesImportance offer;

  const EliteRepricingRequestScreen({super.key, required this.request, required this.offer});

  @override
  State<EliteRepricingRequestScreen> createState() => _EliteRepricingRequestScreenState();
}

class _EliteRepricingRequestScreenState extends State<EliteRepricingRequestScreen> {
  final TextEditingController _commentController = TextEditingController();
  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();
  String? _recordingPath;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YmtazEliteCubit, YmtazEliteState>(
        listener: (context, state) {
          if (state is YmtazEliteRepricingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم إرسال طلب إعادة التسعير بنجاح", style: TextStyle(fontFamily: 'Cairo')),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is YmtazEliteRepricingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message, style: const TextStyle(fontFamily: 'Cairo')),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildBlurredAppBar(context, "طلب إعادة تسعير"),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Comment Box
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: const Color(0xFFF2F2F2), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _commentController,
                              maxLines: 8,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "أضف ملاحظاتك...",
                                hintStyle: TextStyle(
                                  color: const Color(0xFFBDBDBD), 
                                  fontSize: 14.sp, 
                                  fontFamily: 'Cairo'
                                ),
                                contentPadding: EdgeInsets.all(20.w),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                                color: const Color(0xFF0F2D37),
                              ),
                            ),
                          ),
                          verticalSpace(24.h),
                          
                          // Audio Section (Matches the dark box in the image)
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F2D37), // Dark navy from image
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: RecorderPlayerWidget(
                              onRecordingComplete: (path) => setState(() => _recordingPath = path),
                              recorderController: _recorderController,
                              playerController: _playerController,
                              isDark: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Submit Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: state is YmtazEliteRepricingLoading
                            ? null
                            : () {
                                if (_commentController.text.trim().isEmpty && _recordingPath == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("يرجى إضافة ملاحظات أو تسجيل صوتي", style: TextStyle(fontFamily: 'Cairo')),
                                    ),
                                  );
                                  return;
                                }
                                
                                context.read<YmtazEliteCubit>().requestRepricing(
                                  requestId: widget.request.id!,
                                  offerId: widget.offer.id!,
                                  comment: _commentController.text,
                                  categoryId: widget.request.eliteServiceCategory?.id,
                                  voicePath: _recordingPath,
                                );
                              },
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37), // Golden color
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: state is YmtazEliteRepricingLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "إرسال الطلب", 
                                    style: TextStyle(
                                      fontSize: 16.sp, 
                                      fontWeight: FontWeight.bold, 
                                      fontFamily: 'Cairo',
                                      color: Colors.white,
                                    )
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}
