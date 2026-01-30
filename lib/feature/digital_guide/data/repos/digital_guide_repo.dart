import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/digital_guide/data/model/fast_search_response_model.dart';

import '../model/lawyer_model.dart';

class DigitalGuideRepo {
  final ApiService _apiService;

  DigitalGuideRepo(this._apiService);

  // fast search digital guide
  Future<ApiResult<FastSearchResponseModel>> fastSearchDigitalGuideClient(
      String name) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      FastSearchResponseModel response;
      response = await _apiService.fastSearch(token, name);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawyerModel>> getLawyerDataById(String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawyerModel response;
      response = await _apiService.getLawyerDataById(token, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<List<ApiResult>> getLawyerData(String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var lawyerData = _apiService.getLawyerDataById(token, id);

      var results = await Future.wait([lawyerData]);

      return results.map((response) => ApiResult.success(response)).toList();
    } on DioException catch (error) {
      return [ApiResult.failure(error.response?.data)];
    }
  }
}
