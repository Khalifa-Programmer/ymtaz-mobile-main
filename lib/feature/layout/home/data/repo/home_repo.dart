import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/remote/api_constants.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/layout/home/data/models/banners_model.dart';
import 'package:yamtaz/feature/layout/home/data/models/recent_joined_lawyers_model.dart';
import 'package:yamtaz/feature/layout/home/data/models/specialization_response.dart';

import '../../../../../core/network/error/api_result.dart';

class HomeRepo {
  final ApiService _apiService;
  final Dio _dio;

  HomeRepo(this._apiService, this._dio);

  Future<ApiResult<RecentJoinedLawyersModel>> getRecentLawyers() async {
    try {
      final response = await _apiService.getRecentLawyers();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<BannersModel>> getBanners() async {
    try {
      final response = await _apiService.getBanners();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<SpecializationResponse>> getSpecializations() async {
    try {
      final baseUrl = await ApiConstants.baseUrl;
      final response = await _dio.get('${baseUrl}${ApiConstants.specializations}');
      return ApiResult.success(SpecializationResponse.fromJson(response.data));
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    } catch (e) {
      return ApiResult.failure({'message': e.toString()});
    }
  }
}
