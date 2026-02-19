import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';

class NotificationItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String createdAt;
  final String type;
  final bool isSeen;

  const NotificationItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.type,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w), // تحسين المسافات
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationIcon(),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  _buildDescription(), // تأكدت من إضافة الوصف هنا لأنه كان مفقوداً في build السابق
                  SizedBox(height: 5.h),
                  _buildFooter(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      width: 32.w, // تكبير بسيط لتناسب الأيقونة بشكل أفضل
      height: 32.w,
      decoration: BoxDecoration(
        // لون رمادي للمقروء ولون التطبيق للأصفر لغير المقروء
        color: isSeen ? appColors.grey20.withOpacity(0.5) : appColors.primaryColorYellow,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.notifications_none_outlined, // تغيير لشكل أخف بدون النقطة
          size: 18.sp,
          color: appColors.white,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyles.cairo_14_bold.copyWith(
        color: isSeen ? appColors.grey20 : appColors.black, // تمييز النص أيضاً
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.cairo_12_semiBold.copyWith(
        color: appColors.grey20,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getTimeDate(createdAt),
          style: TextStyles.cairo_10_semiBold.copyWith(
            color: appColors.grey20,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            getTypeNotificationText(type),
            style: TextStyles.cairo_10_bold.copyWith(
              color: appColors.primaryColorYellow,
            ),
          ),
        ),
      ],
    );
  }
}
