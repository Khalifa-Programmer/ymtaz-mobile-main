import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamtaz/core/helpers/extentions.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../data/model/notifications_resonse_model.dart';
import '../../logic/notification_cubit.dart';
import 'notification_item.dart';

class GlobalNotification extends StatelessWidget {
  const GlobalNotification({super.key, required this.notifications});

  final NotificationData? notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConditionalBuilder(
      condition: notifications!.notifications!
          .where((element) => element.type == "global")
          .isNotEmpty,
      builder: (BuildContext context) {
        return Container(
          child: ListView.separated(
            itemCount: notifications!.notifications!
                .where((element) => element.type == "global")
                .length,
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
                      typeNotificationNavigation(notifications!.notifications!
                          .where((element) => element.type == "global")
                          .toList()[index]
                          .type!),
                      arguments: notifications!.notifications!
                          .where((element) => element.type == "global")
                          .toList()[index]);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotificationItemWidget(
                          title: notifications!.notifications!
                              .where((element) => element.type == "global")
                              .toList()[index]
                              .title!,
                          description: notifications!.notifications!
                              .where((element) => element.type == "global")
                              .toList()[index]
                              .description!,
                          createdAt: notifications!.notifications!
                              .where((element) => element.type == "global")
                              .toList()[index]
                              .createdAt!,
                          type: notifications!.notifications!
                              .where((element) => element.type == "global")
                              .toList()[index]
                              .type!,
                          isSeen: notifications!.notifications!
                                  .where((element) => element.type == "global")
                                  .toList()[index]
                                  .seen ==
                              1,
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
