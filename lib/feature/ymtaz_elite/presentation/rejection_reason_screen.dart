import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

class RejectionReasonScreen extends StatefulWidget {
  final String offerId;

  const RejectionReasonScreen({super.key, required this.offerId});

  @override
  State<RejectionReasonScreen> createState() => _RejectionReasonScreenState();
}

class _RejectionReasonScreenState extends State<RejectionReasonScreen> {
  final TextEditingController _reasonController = TextEditingController();
  bool _submitted = false;
  String _submittedReason = '';

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          setState(() {
            _submitted = true;
            _submittedReason = _reasonController.text;
          });
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: const TextStyle(fontFamily: 'Cairo')),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: buildBlurredAppBar(context, "رفض العرض نهائياً"),
        body: _submitted ? _buildSuccessView(context) : _buildInputView(context),
      ),
    );
  }

  // ── حالة النجاح: عرض الرفض وسببه ──────────────────────────────────────────
  Widget _buildSuccessView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace(32.h),

          // أيقونة تأكيد الرفض
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE54560).withOpacity(0.1),
            ),
            child: Icon(
              Icons.cancel_rounded,
              size: 60.sp,
              color: const Color(0xFFE54560),
            ),
          ),
          verticalSpace(24.h),

          Text(
            "تم رفض العرض نهائياً",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(8.h),
          Text(
            "تمّ إرسال قرارك إلى فريق النخبة الاستشاري",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
              fontFamily: 'Cairo',
            ),
          ),

          verticalSpace(32.h),

          // صندوق سبب الرفض
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE54560).withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: const Color(0xFFE54560), size: 20.sp),
                    horizontalSpace(8.w),
                    Text(
                      "سبب الرفض",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                verticalSpace(12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBFBFB),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Text(
                    _submittedReason,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF0F2D37),
                      fontFamily: 'Cairo',
                      height: 1.7,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),

          verticalSpace(48.h),

          // زر العودة لقائمة الطلبات
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // نرجع لشاشة تفاصيل الطلب ثم لقائمة الطلبات
                Navigator.maybePop(context);
                Navigator.maybePop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F2D37),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "العودة إلى طلباتي",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          verticalSpace(16.h),
        ],
      ),
    );
  }


  // ── نموذج إدخال سبب الرفض ────────────────────────────────────────────────
  Widget _buildInputView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بانر تحذيري
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE54560).withOpacity(0.06),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE54560).withOpacity(0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: const Color(0xFFE54560), size: 22.sp),
                horizontalSpace(10.w),
                Expanded(
                  child: Text(
                    "سيتم رفض العرض نهائياً ولا يمكن التراجع عن هذا الإجراء. سيطّلع فريق النخبة على ملاحظاتك.",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF0F2D37),
                      fontFamily: 'Cairo',
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          verticalSpace(24.h),

          Text(
            "سبب الرفض",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(8.h),
          Text(
            "يرجى توضيح سبب رفضك للعرض المقدم",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[500],
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
                borderSide: const BorderSide(color: Color(0xFFE54560)),
              ),
            ),
          ),

          verticalSpace(48.h),

          SizedBox(
            width: double.infinity,
            child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is YmtazEliteOfferApprovalLoading
                      ? null
                      : () {
                          if (_reasonController.text.trim().isNotEmpty) {
                            context.read<YmtazEliteCubit>().rejectOffer(
                                  widget.offerId,
                                  _reasonController.text.trim(),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("يرجى كتابة سبب الرفض",
                                    style: TextStyle(fontFamily: 'Cairo')),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE54560),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: state is YmtazEliteOfferApprovalLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          "تأكيد الرفض النهائي",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                );
              },
            ),
          ),
          verticalSpace(16.h),
        ],
      ),
    );
  }

}
