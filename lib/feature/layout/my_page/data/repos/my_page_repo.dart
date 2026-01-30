import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/last_added.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_lawyers_response.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_page_response_model.dart';

import '../../../../../core/network/error/api_result.dart';
import '../../../../../core/network/local/cache_helper.dart';

class MyPageRepo {
  final ApiService _apiService;

  MyPageRepo(this._apiService);

  Future<ApiResult<MyPageResponseModel>> getMyPageClient() async {
    var token = CacheHelper.getData(key: 'token');
    // var userType = CacheHelper.getData(key: 'userType');

    try {
      MyPageResponseModel response;
      response = await _apiService.getMyPageDataClient(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LastAdded>> myLastAdded() async {
    var token = CacheHelper.getData(key: 'token');
    // var userType = CacheHelper.getData(key: 'userType');

    try {
      LastAdded response;
      response = await _apiService.myLastAdded(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MyLawyersResponse>> getMyLawyers() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.myLawyers(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
