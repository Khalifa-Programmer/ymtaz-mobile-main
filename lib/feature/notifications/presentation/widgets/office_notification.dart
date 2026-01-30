import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../data/model/notifications_resonse_model.dart';
import '../../logic/notification_cubit.dart';
import '../../logic/notification_state.dart';
import 'notification_item.dart';

class OfficeNotification extends StatefulWidget {
  const OfficeNotification({
    super.key, 
    required this.notifications, 
    required this.types
  });

  final NotificationData? notifications;
  final List<String> types;

  @override
  _OfficeNotificationState createState() => _OfficeNotificationState();
}

class _OfficeNotificationState extends State<OfficeNotification> {
  int? selectedIndex;
  final String filterKey = 'notification_filter';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializeFilter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearFilter() {
    prefs.remove(filterKey);
  }
  Future<void> _initializeFilter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt(filterKey);
    });
  }

  Future<void> _saveFilter(int? index) async {
    if (index == null) {
      await prefs.remove(filterKey);
    } else {
      await prefs.setInt(filterKey, index);
    }
  }

  List<NotificationItem> getFilteredNotifications(NotificationData? notifications) {
    final allNotifications = notifications?.notifications
        ?.where((element) => widget.types.contains(element.type))
        .toList() ?? [];

    if (selectedIndex == 0) {
      return allNotifications.where((element) => element.seen == 1).toList();
    } else if (selectedIndex == 1) {
      return allNotifications.where((element) => element.seen == 0).toList();
    }
    return allNotifications;
  }

  Future<void> handleNotificationTap(NotificationItem notification) async {
    if (!mounted) return;

    if (notification.seen == 0) {
      try {
        await getit<NotificationCubit>().markNotificationAsSeen({
          "id": notification.id.toString()
        });

        if (mounted) {
          context.pushNamed(
            typeNotificationNavigation(notification.type!),
            arguments: notification,
          );
        }

        if (mounted) {
          await getit<NotificationCubit>().getNotifications();
        }
      } catch (e) {
        print('Error handling notification: $e');
      }
    } else {
      if (mounted) {
        context.pushNamed(
          typeNotificationNavigation(notification.type!),
          arguments: notification,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (notificationsData) {
              final filteredNotifications = getFilteredNotifications(notificationsData.data);
              
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ToggleButtons(
                        borderRadius: BorderRadius.circular(30.r),
                        splashColor: appColors.lightYellow10,
                        isSelected: [selectedIndex == 0, selectedIndex == 1],
                        onPressed: (int index) {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = null;
                              _saveFilter(null);
                            } else {
                              selectedIndex = index;
                              _saveFilter(index);
                            }
                          });
                        },
                        selectedColor: const Color(0xFFD89F58),
                        fillColor: const Color(0xFFF9F4E8),
                        color: Colors.grey[600],
                        renderBorder: false,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            child: Text(
                              'مقروء',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            child: Text(
                              'غير مقروء',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (filteredNotifications.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(
                          selectedIndex == 1
                              ? 'لا توجد إشعارات غير مقروءة'
                              : selectedIndex == 0
                                  ? 'لا توجد إشعارات مقروءة'
                                  : 'لا توجد إشعارات',
                          style: TextStyles.cairo_14_medium.copyWith(
                            color: appColors.grey20,
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => handleNotificationTap(notification),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NotificationItemWidget(
                                  title: notification.title!,
                                  description: notification.description!,
                                  createdAt: notification.createdAt!,
                                  type: notification.type!,
                                  isSeen: notification.seen == 1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: appColors.grey10.withOpacity(0.5),
                          thickness: 0.5,
                        );
                      },
                    ),
                ],
              );
            },
            orElse: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      ),
    );
  }
}
