import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';

import '../../../../core/network/local/cache_helper.dart';

class ForensicRepo {
  final ApiService _apiService;

  ForensicRepo(this._apiService);

  Future<ApiResult<JudicialGuideResponseModel>> getDigitalGuide() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      JudicialGuideResponseModel response;
      response = await _apiService.getJudicialGuide(token ?? "");

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
