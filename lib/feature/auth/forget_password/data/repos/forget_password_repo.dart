import 'package:dio/dio.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_response_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/reset_password_request_body.dart';

import '../../../../../core/network/error/api_result.dart';
import '../../../../../core/network/remote/api_service.dart';
import '../../../login/data/models/login_response.dart';
import '../model/forget_request_body.dart';
import '../model/forget_response_body.dart';

class ForgetPasswordRepo {
  final ApiService _apiService;

  ForgetPasswordRepo(this._apiService);

  // celient forget pass
  Future<ApiResult<ForgetResponse>> forgetPasswordClient(
      ForgetRequestBody forgetRequestBody) async {
    try {
      final response =
          await _apiService.forgetPasswordClient(forgetRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }

  // verify client
  Future<ApiResult<CheckCodeResponse>> verifyForgetClient(
      CheckCodeRequestBody forgetRequestBody) async {
    try {
      final response = await _apiService.verifyForgetClient(forgetRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }

  // reset pass
  Future<ApiResult<LoginResponse>> resetPasswordClient(
      ResetPasswordRequestBody forgetRequestBody) async {
    try {
      final response = await _apiService.resetPasswordClient(forgetRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }

  // lawyer forget pass
  Future<ApiResult<ForgetResponse>> forgetPasswordLawyer(String email) async {
    try {
      final response = await _apiService.forgetPasswordLawyer(email);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }

  // verify lawyer
  Future<ApiResult<CheckCodeResponse>> verifyForgetLawyer(
      CheckCodeRequestBody checkCodeRequestBody) async {
    try {
      final response =
          await _apiService.verifyForgetLawyer(checkCodeRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }

  // reset pass lawyer
  Future<ApiResult<LoginResponse>> resetPasswordLawyer(
      ResetPasswordRequestBody resetPasswordRequestBody) async {
    try {
      final response =
          await _apiService.resetPasswordLawyer(resetPasswordRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
