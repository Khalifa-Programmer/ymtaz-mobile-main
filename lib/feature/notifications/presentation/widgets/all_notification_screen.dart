import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../logic/notification_cubit.dart';
import 'notification_item.dart';

class AllNotification extends StatelessWidget {
  const AllNotification({super.key, required this.notifications});

  final NotificationData? notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConditionalBuilder(
      condition: notifications!.notifications!.isNotEmpty,
      builder: (BuildContext context) {
        return Container(
          child: ListView.separated(
            itemCount: notifications!.notifications!.length,
            itemBuilder: (context, index) {
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (notifications!.notifications![index].seen == 0) {
                    getit<NotificationCubit>().markNotificationAsSeen({
                      "id": notifications!.notifications![index].id.toString()
                    });
                  }
                  context.pushNamed(
                      typeNotificationNavigation(
                          notifications!.notifications![index].type!),
                      arguments: notifications!.notifications![index]);
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotificationItemWidget(
                          title: notifications!.notifications![index].title!,
                          description:
                              notifications!.notifications![index].description!,
                          createdAt:
                              notifications!.notifications![index].createdAt!,
                          type: notifications!.notifications![index].type!,
                          isSeen:
                              notifications!.notifications![index].seen == 1,
                        ),
                      ],
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: appColors.grey10.withOpacity(0.5),
                thickness: 0.5,
              );
            },
          ),
        );
      },
      fallback: (BuildContext context) {
        return const Center(
          child: Text("لا يوجد اشعارات عامة"),
        );
      },
    ));
  }
}
