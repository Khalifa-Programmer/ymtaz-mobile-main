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
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationIcon(),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
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
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: isSeen ? appColors.grey20 : appColors.primaryColorYellow,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: isSeen
          ? Center(
              child: Icon(
                Icons.notifications,
                size: 18.sp,
                color: appColors.white,
              ),
            )
          : Badge(
              smallSize: 10,
              alignment: Alignment.topRight,
              child: Center(
                child: Icon(
                  Icons.notifications,
                  size: 18.sp,
                  color: appColors.white,
                ),
              ),
            ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyles.cairo_14_bold.copyWith(
        color: appColors.black,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      description,
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
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
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
