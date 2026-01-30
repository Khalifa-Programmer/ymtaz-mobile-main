import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';

import '../../../../../core/network/error/api_result.dart';
import '../model/response_model.dart';

class RegisterRepo {
  final ApiService _apiService;

  RegisterRepo(this._apiService);

  Future<ApiResult<ResponseModel>> register(
      FormData registerRequestBody) async {
    try {
      final response = await _apiService.register(registerRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseModel>> validatePhone(
      String phone, String ccode) async {
    try {
      final response = await _apiService.verifyPhone(phone, ccode);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseModel>> verifyPhoneOtp(
      String phone, String ccode, String code) async {
    try {
      final response = await _apiService.confirmPhone(code, phone, ccode);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
