import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/layout/account/data/models/success_fcm_response.dart';

import '../model/favorite_response_model.dart';

class FavoriteRepo {
  final ApiService _apiService;

  FavoriteRepo(this._apiService);

  Future<ApiResult<SuccessFcmResponse>> addLawyerToFavorite(
      String lawyerId) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response;
      response = await _apiService.addFavorite(token, lawyerId);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get favorite lawyers
  Future<ApiResult<FavoriteResponseModel>> getFavoriteLawyers() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response;
      response = await _apiService.getFavorite(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
