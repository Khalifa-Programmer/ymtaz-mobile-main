import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/notifications/logic/notification_cubit.dart';
import 'package:yamtaz/feature/notifications/logic/notification_state.dart';
import 'package:yamtaz/feature/notifications/presentation/widgets/office_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    tabs: const [
                      Tab(
                        text: 'العامة',
                      ),
                      Tab(
                        text: 'المكتب',
                      ),
                      Tab(
                        text: 'الشَّذرات',
                      ),
                    ]),
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
                        notifications: getit<NotificationCubit>()
                            .notificationsResponseModel!
                            .data,
                        types: const [
                          "global",
                          "xp",
                          "package",
                          "store-update",
                          "contact-us-request"
                        ],
                      ),
                      OfficeNotification(
                        notifications: getit<NotificationCubit>()
                            .notificationsResponseModel!
                            .data,
                        types: const [
                          "service",
                          "appointment",
                          "advisory_service",
                          "service-lawyer",
                          "appointment-lawyer",
                          "advisory_service-lawyer",
                          "service-offer-lawyer",
                          "service-offer",
                          "offer-reservation-lawyer",
                          "offer-reservation",
                          "package",
                          "service_request_reply"
                        ],
                      ),
                      OfficeNotification(
                        notifications: getit<NotificationCubit>()
                            .notificationsResponseModel!
                            .data,
                        types: const ['laws'],
                      ),

                      // UnderStudyServices(),
                    ]);
                  }),
            ));
      },
    );
  }
}
