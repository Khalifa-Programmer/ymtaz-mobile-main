import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_request_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';

import '../../../../../core/network/error/api_result.dart';
import '../model/available_lawyers_for_service_model.dart';
import '../model/respond_clinet_to_offer_response.dart';

class ServicesRepo {
  final ApiService _apiService;

  ServicesRepo(this._apiService);

  // reqquest services  to api

  Future<ApiResult<ServicesRequestResponse>> servicesRequest(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;
      if (userType == 'client') {
        response = await _apiService.servicesRequestClient(token, data);
      } else if (userType == 'provider') {
        response = await _apiService.servicesRequestProvider(token, data);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //serviceLawyersById

  Future<ApiResult<AvailableLawyersForServiceModel>> serviceLawyersById(
      String importanceId, String serviceId) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response =
          await _apiService.serviceLawyersById(token, importanceId, serviceId);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ServicesRequirementsResponse>> getServices() async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == 'guest') {
        response = await _apiService.getServicesClient(token ?? "");
      } else if (userType == 'provider') {
        response = await _apiService.ggetServicesProvider(token);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get services from api
  Future<ApiResult<MyServicesRequestsResponse>>
      getMyServicesRequestOffers() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getMyServicesRequestOffers(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<RespondClinetToOfferResponse>> myServicesClientOffersRespond(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response =
          await _apiService.myServicesClientOffersRespond(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
