import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';
import 'package:yamtaz/feature/notifications/logic/notification_state.dart';

import '../data/repo/notification_repo.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;

  // ValueNotifier to track the unread notifications count
  ValueNotifier<int> unreadCount = ValueNotifier<int>(0);

  NotificationCubit(this._notificationRepo)
      : super(const NotificationState.initial());

  NotificationsResponseModel? notificationsResponseModel;

  Future<void> getNotifications() async {
    emit(const NotificationState.loading());
    final result = await _notificationRepo.getNotifications();
    result.when(
      success: (data) {
        notificationsResponseModel = data;

        // Update the unread count after fetching notifications
        updateUnreadCount();

        emit(NotificationState.loaded(data));
      },
      failure: (error) {
        emit(NotificationState.error(error));
      },
    );
  }

  // Method to mark a notification as seen and update the count
  Future<void> markNotificationAsSeen(Map<String, String> data) async {
    final result = await _notificationRepo.markNotificationAsSeen(data);
    result.when(
      success: (dataModel) {
        // Update local notifications data
        final notification = notificationsResponseModel!.data!.notifications!
            .firstWhere((element) => element.id.toString() == data['id']);
        notification.seen = 1; // Mark as seen locally

        // Update the unread count
        updateUnreadCount();
        getNotifications(); // Fetch the data again to update the UI
        // Emit success message without fetching the data again
        // emit(NotificationState.success(dataModel.message!));
      },
      failure: (error) {
        emit(NotificationState.error(error));
      },
    );
  }

  // Update unread notification count
  void updateUnreadCount() {
    final count = notificationsResponseModel!.data!.notifications!
        .where((element) => element.seen == 0)
        .length;
    unreadCount.value = count; // Notify listeners of the new count
  }
}
