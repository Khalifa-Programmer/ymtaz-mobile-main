import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import '../model/call_model.dart';
import '../../../../core/network/local/cache_helper.dart';

class CallRepo {
  final ApiService _apiService;

  CallRepo(this._apiService);

  Future<ApiResult<dynamic>> getCalls() async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getCalls('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> startCall(Map<String, dynamic> body) async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.startCall('Bearer $token', body);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> getCallDetails(String callId) async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getCallDetails('Bearer $token', callId);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> acceptCall(String callId) async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.acceptCall('Bearer $token', callId);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> rejectCall(String callId) async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.rejectCall('Bearer $token', callId);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> endCall(String callId) async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.endCall('Bearer $token', callId);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> getActiveCalls() async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getActiveCalls('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }

  Future<ApiResult<dynamic>> getCallHistory() async {
    final token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getCallHistory('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e.response?.data);
    }
  }
}
