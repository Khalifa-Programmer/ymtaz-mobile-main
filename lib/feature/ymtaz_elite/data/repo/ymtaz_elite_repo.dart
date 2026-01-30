import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
// import 'package:yamtaz/core/network/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_category_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_offer_approval_response.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_pricing_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_pricing_response.dart';

import '../model/elite_my_requests_model.dart';
import '../model/elite_request_model.dart';

class YmtazEliteRepo {
  final ApiService _apiService;

  YmtazEliteRepo(this._apiService);

  Future<ApiResult<EliteCategoryModel>> getEliteCategories() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getEliteCategories('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<EliteRequestModel>> sendEliteRequest(
      FormData formData) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response =
          await _apiService.sendEliteRequest('Bearer $token', formData);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<EliteMyRequestsModel>> getEliteRequests() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getEliteRequests('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ElitePricingRequestsModel>> getPricingRequests() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getPricingRequests('Bearer $token');
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ElitePricingResponse>> replyToPricingRequest(
      Map<String, dynamic> body) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.replyToPricingRequest('Bearer $token', body);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<EliteOfferApprovalResponse>> approveOffer(
      String offerId, String type) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.approveEliteOffer(
        'Bearer $token',
        offerId,
        {'type': type},
      );
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
