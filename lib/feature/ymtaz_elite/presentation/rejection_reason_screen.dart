import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class RejectionReasonScreen extends StatefulWidget {
  final String offerId;

  const RejectionReasonScreen({super.key, required this.offerId});

  @override
  State<RejectionReasonScreen> createState() => _RejectionReasonScreenState();
}

class _RejectionReasonScreenState extends State<RejectionReasonScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: buildBlurredAppBar(context, "سبب الرفض"),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "يرجى كتابة سبب رفض العرض",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            verticalSpace(16.h),
            TextField(
              controller: _reasonController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "اكتب السبب هنا...",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                  fontFamily: 'Cairo',
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_reasonController.text.isNotEmpty) {
                    // For now, just show a success message and pop
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم إرسال سبب الرفض بنجاح", style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context); // Go back to details
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("يرجى كتابة سبب الرفض", style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "تأكيد الرفض",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
