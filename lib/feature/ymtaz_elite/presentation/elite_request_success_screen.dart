import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/elite_request_model.dart';

class EliteRequestSuccessScreen extends StatelessWidget {
  final EliteRequestModel request;

  const EliteRequestSuccessScreen({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: appColors.white,
        appBar: buildBlurredAppBar(context, "تم ارسال الطلب بنجاح"),
        body: Animate(
          effects: [FadeEffect(duration: 500.ms)],
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSuccessHeader(),
                _buildRequestDetails(),
                _buildBottomActions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appColors.primaryColorYellow.withOpacity(0.1),
            appColors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          verticalSpace(30.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                ),
              ),
              Icon(
                Icons.check_circle,
                color: appColors.primaryColorYellow,
                size: 100.sp,
              ),
            ],
          ),
          verticalSpace(20.h),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                appColors.primaryColorYellow,
                appColors.primaryColorYellow.withOpacity(0.8),
              ],
            ).createShader(bounds),
            child: Text(
              "تم ارسال طلبك بنجاح 🎉",
              style: TextStyles.cairo_20_bold.copyWith(
                // تغيير من 24 إلى 20
                color: appColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpace(10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: Text(
              "سيتم مراجعة طلبك والرد عليك خلال 24 ساعة",
              style: TextStyles.cairo_14_medium.copyWith(
                // تغيير من 16 إلى 14
                color: appColors.grey15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpace(30.h),
        ],
      ),
    );
  }

  Widget _buildRequestDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: appColors.primaryColorYellow.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: appColors.primaryColorYellow.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: appColors.lightYellow10,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: appColors.primaryColorYellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    AppAssets.crown,
                    width: 20.sp,
                    height: 20.sp,
                    color: appColors.white,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "تفاصيل الطلب",
                  style: TextStyles.cairo_16_bold, // تغيير من 18 إلى 16
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "#${request.data?.id ?? ''}",
                    style: TextStyles.cairo_12_bold.copyWith(
                      // تغيير من 14 إلى 12
                      color: appColors.primaryColorYellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                    "الوصف:", request.data?.description ?? '', false),
                if (request.data?.files?.isNotEmpty == true) ...[
                  verticalSpace(15.h),
                  Text(
                    "المرفقات:",
                    style: TextStyles.cairo_16_bold,
                  ),
                  verticalSpace(10.h),
                  ...request.data!.files!
                      .map((file) => _buildAttachmentItem(file)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Column(
        children: [
          CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            color: appColors.primaryColorYellow,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined,
                    color: appColors.white, size: 20.sp), // تصغير الأيقونة
                SizedBox(width: 10.w),
                Text(
                  "العودة للرئيسية",
                  style: TextStyles.cairo_14_bold
                      .copyWith(color: appColors.white), // تغيير من 16 إلى 14
                ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.homeLayout,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isHighlighted) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.cairo_14_bold.copyWith(
              // تغيير من 16 إلى 14
              color: isHighlighted ? appColors.primaryColorYellow : null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              style: TextStyles.cairo_14_medium, // تغيير من 16 إلى 14
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(FileElement file) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: appColors.grey5),
        boxShadow: [
          BoxShadow(
            color: appColors.grey5.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: appColors.lightYellow10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              file.isVoice == 1 ? Icons.mic : Icons.attachment,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              file.file?.split('/').last ?? '',
              style: TextStyles.cairo_14_medium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
