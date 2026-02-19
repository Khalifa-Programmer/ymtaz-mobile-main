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
    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      return ApiResult.failure('سجل دخولك لمشاهدة البيانات');
    }

    try {
      MyPageResponseModel response;
      response = await _apiService.getMyPageDataClient(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LastAdded>> myLastAdded() async {
    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      return ApiResult.failure('سجل دخولك لمشاهدة البيانات');
    }

    try {
      LastAdded response;
      response = await _apiService.myLastAdded(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MyLawyersResponse>> getMyLawyers() async {
    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      return ApiResult.failure('سجل دخولك لمشاهدة البيانات');
    }

    try {
      final response = await _apiService.myLawyers(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
