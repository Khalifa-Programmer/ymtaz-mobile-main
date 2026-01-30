import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/helpers/fuctions_helpers/functions_helpers.dart';

class ReadNotificationScreen extends StatelessWidget {
  const ReadNotificationScreen({super.key, required this.data});

  final NotificationItem data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.title!,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: appColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 9,
                offset: const Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.title!,
                      style: const TextStyle(
                        color: appColors.primaryColorYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: appColors.primaryColorYellow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      getTypeNotificationText(data.type!),
                      style: TextStyles.cairo_10_bold.copyWith(
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(5.h),
              Text(
                getTimeDate(data.createdAt!),
                style: TextStyles.cairo_10_semiBold.copyWith(
                  color: appColors.grey,
                ),
              ),
              verticalSpace(10.h),
              Text(data.description!,
                  style: const TextStyle(
                    color: appColors.blue100,
                    fontSize: 14,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
