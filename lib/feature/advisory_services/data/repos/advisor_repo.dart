import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_category_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_payment_types.dart';
import 'package:yamtaz/feature/advisory_services/data/model/all_advirsory_response.dart';
import 'package:yamtaz/feature/layout/account/data/models/advisory_services_types_response.dart';

import '../../../my_appointments/data/model/working_hours_response.dart';
import '../model/advisory_main_category_response.dart';
import '../model/advisory_request_response.dart';

class AdvisorRepo {
  final ApiService _apiService;

  AdvisorRepo(this._apiService);

  // get all advisory services orders
  Future<ApiResult<AllAdvisoryResponse>> getAdvisoriesFromYmtaz() async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client') {
        response = await _apiService.getMyAdvisorClientFromYmtaz(token);
      } else if (userType == 'provider') {
        response = await _apiService.getMyAdvisorProviderFromYmtaz(token);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AllAdvisoryResponse>> getAdvisoriesFromDigital() async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client') {
        response = await _apiService.getMyAdvisorClientFromDigital(token);
      } else if (userType == 'provider') {
        response = await _apiService.getMyAdvisorProviderFromDigital(token);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoryRequestResponse>> createAppointment(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == 'guest') {
        response =
            await _apiService.createAdvisorServicesClient(token ?? '', data);
      } else if (userType == 'provider') {
        response = await _apiService.createAdvisorServicesProvider(token, data);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<AdvisoryRequestResponse>> createAppointmentWithLawyer(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == 'guest') {
        response =
        await _apiService.createAdvisorServicesClientWithLawyer(token , data);
      } else if (userType == 'provider') {
        response = await _apiService.createAdvisorServicesProviderWithLawyer(token, data);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }


  Future<ApiResult<AdvisoryPaymentsResponse>> getPaymentTypesById(
      String id) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == 'guest') {
        response =
            await _apiService.getAdvisorPaymentsTypesById(token ?? "", id);
      } else if (userType == 'provider') {
        response = await _apiService.getAdvisorPaymentsTypesById(token, id);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoryServicesTypesResponse>> getTypes(String id) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == 'guest') {
        response =
            await _apiService.getAdvisorServicesTypesClient(token ?? "", id);
      } else if (userType == 'provider') {
        response = await _apiService.getAdvisorServicesTypesClient(token, id);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // Future<List<ApiResult<dynamic>>> getTypesAndPaymentTypes() async {
  //   var token = CacheHelper.getData(key: 'token');
  //   var userType = CacheHelper.getData(key: 'userType');
  //
  //   try {
  //     List<Future<ApiResult<dynamic>>> futures = [
  //       if (userType == 'client') _apiService.getAdvisorServicesTypesClient(token).then(
  //             (response) => ApiResult.success(response),
  //       ),
  //       if (userType == 'provider') _apiService.getAdvisorServicesTypesProvider(token).then(
  //             (response) => ApiResult.success(response),
  //       ),
  //       if (userType == 'client') _apiService.getAdvisorPaymentsTypesClient(token).then(
  //             (response) => ApiResult.success(response),
  //       ),
  //       if (userType == 'provider') _apiService.getAdvisorPaymentsTypesProvider(token).then(
  //             (response) => ApiResult.success(response),
  //       ),
  //     ];
  //
  //     List<ApiResult<dynamic>> results = await Future.wait(futures);
  //
  //     return results;
  //   } on DioException catch (error) {
  //     return [
  //       ApiResult.failure(error.response?.data),
  //       ApiResult.failure(error.response?.data),
  //     ];
  //   }
  // }
  Future<ApiResult<AdvisoryMainCategory>> getMainCategories() async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == "guest") {
        response = await _apiService.getMainCategoryAdvisory(token ?? "");
      } else if (userType == 'provider') {
        response = await _apiService.getMainCategoryAdvisory(token);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoryCateogryResponse>> getSections(String id) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response;

      if (userType == 'client' || userType == "guest") {
        response =
            await _apiService.getAdvisorSectionsByIDClient(token ?? "", id);
      } else if (userType == 'provider') {
        response = await _apiService.getAdvisorSectionsByIDClient(token, id);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<WorkingHoursResponse>> getWorkingHours(int requiredTime,
      [String? lawyerId]) async {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
    String fromDate = formatter.format(now);
    String toDate = formatter.format(lastDayOfMonth);

    var token = CacheHelper.getData(key: 'token');
    try {
      if (lawyerId == null) {
        var response = await _apiService.getAdvisoryWorkHours(
            token, fromDate, toDate, requiredTime.toString());
        return ApiResult.success(response);
      } else {
        var response = await _apiService.getAdvisoryWorkHoursToLawyer(
            token, fromDate, toDate, lawyerId, requiredTime.toString(), );
        return ApiResult.success(response);
      }
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
