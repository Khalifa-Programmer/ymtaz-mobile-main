import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class AppRatingScreen extends StatefulWidget {
  const AppRatingScreen({super.key});

  @override
  State<AppRatingScreen> createState() => _AppRatingScreenState();
}

class _AppRatingScreenState extends State<AppRatingScreen> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final InAppReview _inAppReview = InAppReview.instance;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      _showMessage('الرجاء اختيار تقييم');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // محاولة فتح صفحة التقييم في المتجر
      if (Platform.isAndroid) {
        final Uri url = Uri.parse(
            'https://play.google.com/store/apps/details?id=com.ymtaz.ymtaz');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
          _showMessage('شكراً لتقييمك!');
          Navigator.pop(context);
        } else {
          _showMessage('حدث خطأ في فتح المتجر');
        }
      } else if (Platform.isIOS) {
        await _inAppReview.openStoreListing(
          appStoreId: '6602893553',
        );
        _showMessage('شكراً لتقييمك!');
        Navigator.pop(context);
      }
    } catch (e) {
      _showMessage('حدث خطأ، الرجاء المحاولة مرة أخرى');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyles.cairo_14_semiBold),
        backgroundColor: appColors.blue100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: Text(
          'تقييم التطبيق',
          style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
        ),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(20.h),

            // App Icon or Logo
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: appColors.primaryColorYellow.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.star_fill,
                size: 80.sp,
                color: appColors.primaryColorYellow,
              ),
            ),

            verticalSpace(30.h),

            // Title
            Text(
              'ما رأيك في تطبيق يمتاز؟',
              style: TextStyles.cairo_20_bold.copyWith(color: appColors.blue100),
              textAlign: TextAlign.center,
            ),

            verticalSpace(10.h),

            // Subtitle
            Text(
              'رأيك يهمنا! ساعدنا في تحسين التطبيق',
              style: TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey15),
              textAlign: TextAlign.center,
            ),

            verticalSpace(40.h),

            // Star Rating
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: appColors.grey2, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'اختر التقييم',
                    style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Icon(
                            index < _rating
                                ? CupertinoIcons.star_fill
                                : CupertinoIcons.star,
                            size: 40.sp,
                            color: index < _rating
                                ? appColors.primaryColorYellow
                                : appColors.grey15,
                          ),
                        ),
                      );
                    }),
                  ),
                  if (_rating > 0) ...[
                    verticalSpace(10.h),
                    Text(
                      _getRatingText(_rating),
                      style: TextStyles.cairo_12_semiBold.copyWith(
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            verticalSpace(30.h),

            // Review Text Field
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: appColors.grey2, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أخبرنا المزيد (اختياري)',
                    style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(10.h),
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'شاركنا تجربتك مع التطبيق...',
                      hintStyle: TextStyles.cairo_12_semiBold.copyWith(
                        color: appColors.grey15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: appColors.grey2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: appColors.grey2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: appColors.primaryColorYellow),
                      ),
                    ),
                    style: TextStyles.cairo_14_semiBold,
                  ),
                ],
              ),
            ),

            verticalSpace(40.h),

            // Submit Button
            CustomButton(
              title: _isSubmitting ? 'جاري الإرسال...' : 'إرسال التقييم',
              onPress: _isSubmitting ? null : _submitReview,
              bgColor: _rating == 0 ? appColors.grey15 : appColors.blue100,
              borderRadius: 12.r,
              width: double.infinity,
            ),

            verticalSpace(50.h),
          ],
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'سيء جداً';
      case 2:
        return 'سيء';
      case 3:
        return 'جيد';
      case 4:
        return 'جيد جداً';
      case 5:
        return 'ممتاز';
      default:
        return '';
    }
  }
}
