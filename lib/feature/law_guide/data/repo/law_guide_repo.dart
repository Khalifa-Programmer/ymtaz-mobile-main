import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_by_id_response.dart';

import '../../../../core/network/error/api_result.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../model/law_guide_main_response.dart';
import '../model/law_guide_search_response.dart';
import '../model/law_guide_sub_main_response.dart';
import '../model/law_response.dart';

class LawGuideRepo {
  final ApiService _apiService;

  LawGuideRepo(this._apiService);

  Future<ApiResult<LawGuideMainResponse>> getLawGuide() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawGuideMainResponse response;
      response = await _apiService.getLawGuide(token ?? "");
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawGuideSubMainResponse>> getLawGuideSubFromMain(
      String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawGuideSubMainResponse response;

      response = await _apiService.getLawGuideSubFromMain(token ?? "", id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawResponse>> getLawsGuideSubFromSub(
      String subId, int perPage, int page) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getLawsGuideSubFromSub(
          token ?? "", subId, perPage, page);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawByIdResponse>> getLawById(String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawByIdResponse response;

      response = await _apiService.getLawById(token ?? "", id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawGuideSearchResponse>> searchLawGuide(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawGuideSearchResponse response;

      response = await _apiService.searchLawGuide(token ?? "", data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
