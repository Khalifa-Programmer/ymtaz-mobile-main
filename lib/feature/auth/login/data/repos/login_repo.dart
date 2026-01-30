import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_request_body.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/visitor_login.dart';

import '../../../../../core/models/base_response.dart';
import '../../../../../core/network/remote/api_service.dart';
import '../models/login_provider_response.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> loginClient(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.loginClient(loginRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // lgoin provider
  Future<ApiResult<LoginProviderResponse>> loginProvider(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

// visitor login

  Future<ApiResult<VisitorLogin>> visitorLogin(String token) async {
    try {
      final response = await _apiService.visitorLogin(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // Add Apple Sign In method
  Future<ApiResult<BaseResponse>> appleLogin(String token) async {
    try {
      final response = await _apiService.appleLogin(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
