import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/notifications/data/model/mark_notification_seen_response.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';

import '../../../../core/network/local/cache_helper.dart';

class NotificationRepo {
  final ApiService _apiService;

  NotificationRepo(this._apiService);

  Future<ApiResult<NotificationsResponseModel>> getNotifications() async {
    try {
      final token = CacheHelper.getData(key: 'token');
      if (token == null) {
        return ApiResult.failure('سجل دخولك لمشاهدة البيانات');
      }

      NotificationsResponseModel response;
      response = await _apiService.getNotifications(token);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MarkNotificationSeenResponse>> markNotificationAsSeen(
      Map<String, String> data) async {
    try {
      final token = CacheHelper.getData(key: 'token');
      if (token == null) {
        return ApiResult.failure('سجل دخولك لمشاهدة البيانات');
      }

      MarkNotificationSeenResponse response;
      response = await _apiService.notificationSeen(token, data);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
