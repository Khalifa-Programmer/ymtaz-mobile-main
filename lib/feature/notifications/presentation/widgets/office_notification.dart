// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

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
    required this.types,
  });

  final NotificationData? notifications;
  final List<String> types;

  @override
  _OfficeNotificationState createState() => _OfficeNotificationState();
}

class _OfficeNotificationState extends State<OfficeNotification> {
  // 0: الكل (الافتراضي)، 1: غير مقروء، 2: مقروء
  int selectedIndex = 0;
  final String filterKey = 'notification_filter_final';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializeFilter();
  }

  Future<void> _initializeFilter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // جلب الفلتر المحفوظ أو استخدام 0 (الكل) كافتراضي
      selectedIndex = prefs.getInt(filterKey) ?? 0;
    });
  }

  Future<void> _saveFilter(int index) async {
    await prefs.setInt(filterKey, index);
  }

  // تصفية القائمة بناءً على التبويب المختار والأنواع المطلوبة (مكتب، عامة، شذرات)
  List<NotificationItem> _getFilteredList(NotificationData? data) {
    final allInType = data?.notifications
            ?.where((element) => widget.types.contains(element.type))
            .toList() ?? [];

    if (selectedIndex == 1) {
      return allInType.where((element) => element.seen == 0).toList();
    } else if (selectedIndex == 2) {
      return allInType.where((element) => element.seen == 1).toList();
    }
    return allInType; // الكل
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (notificationsData) {
              // حساب الأعداد بناءً على نوع القسم الحالي
              final allItems = notificationsData.data?.notifications
                      ?.where((e) => widget.types.contains(e.type))
                      .toList() ?? [];
              
              int countAll = allItems.length;
              int countUnseen = allItems.where((e) => e.seen == 0).length;
              int countSeen = allItems.where((e) => e.seen == 1).length;

              final displayedList = _getFilteredList(notificationsData.data);

              return Column(
                children: [
                  verticalSpace(15.h),
                  // --- أزرار التصفية مع العدادات ---
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToggleButtons(
                        borderRadius: BorderRadius.circular(30.r),
                        constraints: BoxConstraints(minHeight: 40.h, minWidth: 105.w),
                        isSelected: [
                          selectedIndex == 0,
                          selectedIndex == 1,
                          selectedIndex == 2
                        ],
                        onPressed: (int index) {
                          setState(() {
                            selectedIndex = index;
                            _saveFilter(index);
                          });
                        },
                        selectedColor: const Color(0xFFD89F58),
                        fillColor: const Color(0xFFF9F4E8),
                        color: Colors.grey[600],
                        renderBorder: false,
                        children: [
                          _buildTabChild("الكل", countAll),
                          _buildTabChild("غير مقروء", countUnseen),
                          _buildTabChild("مقروء", countSeen),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10.h),

                  // --- قائمة الإشعارات ---
                  Expanded(
                    child: displayedList.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemCount: displayedList.length,
                            itemBuilder: (context, index) {
                              final notification = displayedList[index];
                              return CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _handleNotificationTap(notification),
                                child: NotificationItemWidget(
                                  title: notification.title ?? "",
                                  description: notification.description ?? "",
                                  createdAt: notification.createdAt ?? "",
                                  type: notification.type ?? "",
                                  isSeen: notification.seen == 1,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: appColors.grey10.withOpacity(0.3),
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                          ),
                  ),
                ],
              );
            },
            orElse: () => const Center(child: CupertinoActivityIndicator()),
          );
        },
      ),
    );
  }

  // ودجت بناء شكل التبويب (النص + الدائرة)
  Widget _buildTabChild(String label, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        horizontalSpace(6.w),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: const BoxDecoration(
            color: Color(0xFFE8E8E8),
            shape: BoxShape.circle,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(fontSize: 10.sp, color: Colors.black87),
          ),
        )
      ],
    );
  }

  Widget _buildEmptyState() {
    String msg = selectedIndex == 0 
        ? 'لا توجد إشعارات' 
        : (selectedIndex == 1 ? 'لا توجد إشعارات غير مقروءة' : 'لا توجد إشعارات مقروءة');
    return Center(
      child: Text(
        msg,
        style: TextStyles.cairo_14_medium.copyWith(color: appColors.grey20),
      ),
    );
  }

  // معالجة الضغط: فتح الشاشة فوراً ثم التحديث في الخلفية
  Future<void> _handleNotificationTap(NotificationItem notification) async {
    if (!mounted) return;

    // 1. الانتقال الفوري لشاشة التفاصيل
    context.pushNamed(
      typeNotificationNavigation(notification.type!),
      arguments: notification,
    );

    // 2. تحديث الحالة إذا كان غير مقروء
    if (notification.seen == 0) {
      try {
        await getit<NotificationCubit>().markNotificationAsSeen({
          "id": notification.id.toString()
        });
        
        // إعادة جلب الإشعارات لتحديث الأعداد والحالة في القائمة
        if (mounted) {
          await getit<NotificationCubit>().getNotifications();
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }
}
