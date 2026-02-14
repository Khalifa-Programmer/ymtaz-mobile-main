import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/my_appointments/data/model/my_reservations_response_model.dart';
import 'package:yamtaz/feature/my_appointments/data/model/working_hours_response.dart';

import '../../../../core/network/error/api_result.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../auth/sign_up/data/models/countries_response.dart';
import '../model/appointment_offers_client.dart';
import '../model/appointment_request_response.dart';
import '../model/avaliable_appointment_lawyer_model.dart';
import '../model/dates_types_response_model.dart';
import '../model/reply_to_offer_appointment_response.dart';

class AppointmentRepo {
  final ApiService _apiService;

  AppointmentRepo(this._apiService);

  // Future<ApiResult<AvailableDatesResponse>> getAvailableTimes() async {
  //   var token = CacheHelper.getData(key: 'token');
  //   var userType = CacheHelper.getData(key: 'userType');
  //   try {
  //     var response;
  //
  //     if (userType == 'client') {
  //       response = await _apiService.getAppointmentsAvaliableTimes(token);
  //     } else if (userType == 'provider') {
  //       response = await _apiService.getAppointmentsAvaliableTimes(token);
  //     }
  //     return ApiResult.success(response);
  //   } on DioException catch (error) {
  //     return ApiResult.failure(error.response?.data);
  //   }
  // }

  Future<ApiResult<CountriesResponse>> getCountries() async {
    try {
      final response = await _apiService.getCountries();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<DatesTypesResponseModel>> getAppointmentsTypes() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getAppointmentsTypes(token ?? "");

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }


  Future<ApiResult<AppointmentOffersClient>> getAppointmentsoffersClient() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response =  await _apiService.getAppointmentsoffersClient(token);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AvaliableAppointmentLawyerModel>> getAppointmentLawyers(
    String importanceId,
    String cityId,
    String regionId,
    String id,
  ) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getAppointmentLawyers(
          token, importanceId, cityId, regionId, id);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // request appointment
Future<ApiResult<AppontmentRequestResponse>> requestAppointment(FormData data) async {
  var token = CacheHelper.getData(key: 'token');
  var userType = CacheHelper.getData(key: 'userType');
  
  try {
    // التحقق من وجود التوكن ونوع المستخدم أولاً لضمان الأمان
    if (token == null || userType == null) {
      return const ApiResult.failure({"message": "يجب تسجيل الدخول أولاً"});
    }

    // بما أن الدالة المستدعاة من الـ API واحدة للحالتين، يمكننا طلبها مباشرة
    // أو استخدام final لضمان تعيين القيمة
    final AppontmentRequestResponse response;

    if (userType == 'client' || userType == 'provider') {
      response = await _apiService.appointmentsRequest(token, data);
    } else {
      return const ApiResult.failure({"message": "عذراً، هذه الخدمة غير متاحة لنوع حسابك"});
    }

    return ApiResult.success(response);
  } on DioException catch (error) {
    return ApiResult.failure(error.response?.data);
  } catch (e) {
    return ApiResult.failure({"message": e.toString()});
  }
}
  Future<ApiResult<ReplyToOfferAppointmentResponse>> respondToAppointmentOffer(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.respondToAppointmentOffer(token, data);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  // get my appointments
  Future<ApiResult<MyReservationsResponseModel>> getMyAppointments() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getMyAppointments(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<WorkingHoursResponse>> getWorkingHours(
      int requiredTime) async {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
    String fromDate = formatter.format(now);
    String toDate = formatter.format(lastDayOfMonth);

    var token = CacheHelper.getData(key: 'token');
    try {
      var response = await _apiService.getAppointmentsWorkHours(
          token, fromDate, toDate, requiredTime.toString());
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }


}
