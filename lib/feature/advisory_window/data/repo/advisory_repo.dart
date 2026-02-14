import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_accurate_specialization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_categories_types.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_general_specialization.dart';

import '../../../../core/network/error/api_result.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_service.dart';
import '../../../my_appointments/data/model/working_hours_response.dart';
import '../model/advisory_request_response.dart';
import '../model/all_advirsory_response.dart';
import '../model/available_lawyers_for_advisory_type_model.dart';

class AdvisoryRepo {
  final ApiService _apiService;

  AdvisoryRepo(this._apiService);

  Future<ApiResult<AdvisoriesCategoriesTypes>> getAdvisoriesTypes() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getAdvisoriesTypes(token ?? '');

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AvailableLawyersForAdvisoryTypeModel>> advisoryLawyersById(
      String importanceId, String serviceId) async {
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      var response =
          await _apiService.advisoryLawyersById(token, importanceId, serviceId);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoriesGeneralSpecialization>>
      getGeneralTypesByAdvisoryId(String advisoryTypeId) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getGeneralTypesByAdvisoryId(
          token ?? "", advisoryTypeId);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoriesAccurateSpecialization>>
      getAccurateTypesByGeneralAndAdvisoryId(
    String advisoryTypeId,
    String generalTypeId,
  ) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getAccurateTypesByGeneralAndAdvisoryId(
          token ?? "", advisoryTypeId, generalTypeId);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AdvisoryRequestResponse>> createAppointment(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.createAdvisoryRequest(token ?? '', data);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
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
          token,
          fromDate,
          toDate,
          lawyerId,
          requiredTime.toString(),
        );
        return ApiResult.success(response);
      }
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // orders

  Future<ApiResult<AllAdvisoryResponse>> getAdvisoriesFromYmtaz() async {
  var token = CacheHelper.getData(key: 'token');
  var userType = CacheHelper.getData(key: 'userType');
  
  try {
    // نستخدم late أو نعطي قيمة ابتدائية، والأفضل استخدام الـ else لضمان التعيين
    final AllAdvisoryResponse response;

    if (userType == 'client') {
      response = await _apiService.getMyAdvisorClientFromYmtaz(token);
    } else if (userType == 'provider') {
      response = await _apiService.getMyAdvisorProviderFromYmtaz(token);
    } else {
      // التعامل مع حالة الزائر أو نوع مستخدم غير معروف
      return const ApiResult.failure({"message": "يجب تسجيل الدخول لعرض الاستشارات"});
    }

    return ApiResult.success(response);
  } on DioException catch (error) {
    return ApiResult.failure(error.response?.data);
  } catch (e) {
    return ApiResult.failure({"message": e.toString()});
  }
}

  Future<ApiResult<AllAdvisoryResponse>> getAdvisoriesFromDigital() async {
  var token = CacheHelper.getData(key: 'token');
  var userType = CacheHelper.getData(key: 'userType');
  
  try {
    // التحقق من نوع المستخدم أولاً لضمان عدم وجود أخطاء منطقية
    if (userType != 'client' && userType != 'provider') {
      return const ApiResult.failure({"message": "نوع المستخدم غير معروف"});
    }

    // تعيين القيمة مباشرة باستخدام final لضمان الأمان البرمجي
    final AllAdvisoryResponse response = (userType == 'client')
        ? await _apiService.getMyAdvisorClientFromDigital(token)
        : await _apiService.getMyAdvisorProviderFromDigital(token);

    return ApiResult.success(response);
  } on DioException catch (error) {
    return ApiResult.failure(error.response?.data);
  } catch (e) {
    return ApiResult.failure({"message": e.toString()});
  }
}
}
