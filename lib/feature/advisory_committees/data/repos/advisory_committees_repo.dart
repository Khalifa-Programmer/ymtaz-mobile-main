import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';

import '../model/advisory_committees_response.dart';

class AdvisoryCommitteesRepo {
  final ApiService _apiService;

  AdvisoryCommitteesRepo(this._apiService);

  // get advisory committees

  Future<ApiResult<AdvisoryCommitteesResponse>> getAdvisoryCommittees() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response;


        response = await _apiService.getAdvisoryCommittees(token ?? "");


      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoryCommitteesLawyersResponse>>
      getAdvisoryCommitteeLawyersById(String committeeId) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response;


        // response = await _apiService.getAdvisoryCommitteesClient(token);
        response = await _apiService.getAdvisoryCommitteesLawyersById(
            token ?? "", committeeId);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }




  Future<List<ApiResult>> getLawyerData(String id) async {
    var token = CacheHelper.getData(key: 'token');
    List<ApiResult> results = [];

    // Fetch Advisory Services
    try {
      var advisoryData = await _apiService.getLawyerAdvisors(token ?? '', id);
      results.add(ApiResult.success(advisoryData));
    } catch (e) {
      results.add(ApiResult.failure(e.toString()));
    }

    // Fetch Regular Services
    try {
      var servicesData = await _apiService.getServices(token ?? '', id);
      results.add(ApiResult.success(servicesData));
    } catch (e) {
      results.add(ApiResult.failure(e.toString()));
    }

    return results;
  }
}
