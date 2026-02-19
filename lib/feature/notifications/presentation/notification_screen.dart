import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من استيرادها للـ .w والـ .h
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/notifications/logic/notification_cubit.dart';
import 'package:yamtaz/feature/notifications/logic/notification_state.dart';
import 'package:yamtaz/feature/notifications/presentation/widgets/office_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // ميثود مساعدة لفحص وجود إشعارات غير مقروءة لنوع معين
  bool _hasUnseen(List<String> types) {
    final model = getit<NotificationCubit>().notificationsResponseModel;
    if (model == null || model.data?.notifications == null) return false;
    
    return model.data!.notifications!.any(
      (n) => types.contains(n.type) && n.seen == 0,
    );
  }

  // ودجت لبناء التبويب مع النقطة الحمراء
  Widget _buildTabWithBadge(String label, List<String> types) {
    bool showBadge = _hasUnseen(types);
    return Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(label),
          if (showBadge)
            Positioned(
              top: -2.h,
              right: -10.w,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تعريف القوائم هنا لتسهيل استخدامها في الـ Tabs والـ TabBarView
    const List<String> publicTypes = [
      "global", "xp", "package", "store-update", "contact-us-request"
    ];
    const List<String> officeTypes = [
      "service", "appointment", "advisory_service", "service-lawyer",
      "appointment-lawyer", "advisory_service-lawyer", "service-offer-lawyer",
      "service-offer", "offer-reservation-lawyer", "offer-reservation",
      "package", "service_request_reply"
    ];
    const List<String> shatharatTypes = ['laws'];

    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "الإشعارات",
                style: TextStyles.cairo_16_bold.copyWith(
                  color: appColors.black,
                ),
              ),
              bottom: TabBar(
                indicatorColor: appColors.primaryColorYellow,
                labelStyle: TextStyles.cairo_14_bold,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                unselectedLabelColor: const Color(0xFF808D9E),
                unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                tabs: [
                  _buildTabWithBadge('العامة', publicTypes),
                  _buildTabWithBadge('المكتب', officeTypes),
                  _buildTabWithBadge('الشَّذرات', shatharatTypes),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is Loaded,
              fallback: (context) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
              builder: (context) {
                return TabBarView(children: [
                  OfficeNotification(
                    notifications: getit<NotificationCubit>().notificationsResponseModel!.data,
                    types: publicTypes,
                  ),
                  OfficeNotification(
                    notifications: getit<NotificationCubit>().notificationsResponseModel!.data,
                    types: officeTypes,
                  ),
                  OfficeNotification(
                    notifications: getit<NotificationCubit>().notificationsResponseModel!.data,
                    types: shatharatTypes,
                  ),
                ]);
              },
            ),
          ),
        );
      },
    );
  }
}
