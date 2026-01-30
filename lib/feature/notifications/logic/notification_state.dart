import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState<T> with _$NotificationState<T> {
  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading() = Loading;

  const factory NotificationState.loaded(NotificationsResponseModel data) =
      Loaded;

  const factory NotificationState.error(String message) = Error;

  const factory NotificationState.success(String message) = Success;
}
