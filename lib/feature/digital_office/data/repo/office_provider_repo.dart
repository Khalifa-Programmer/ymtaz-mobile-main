import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/response_lawyer_to_offer.dart';
import 'package:yamtaz/feature/digital_office/data/models/success_model.dart';

import '../../../../core/network/error/api_result.dart';
import '../models/advisory_available_types_response.dart';
import '../models/advisory_types_add_response.dart';
import '../models/appointment_offers_lawyer.dart';
import '../models/appointment_office_reservations_client.dart';
import '../models/create_services_ymtaz_response_model.dart';
import '../models/lawyer_advisory_requests_responnse.dart';
import '../models/lawyer_appointments.dart';
import '../models/my_clients_response.dart';
import '../models/response_lawyer_to_appointment_offer.dart';
import '../models/service_lawyer_offres_response.dart';
import '../models/services_from_client_response.dart';
import '../models/services_reply_success_response.dart';
import '../models/services_ymtaz_response_model.dart';
import '../models/success_appointments_request.dart';
import '../models/work_days_and_times.dart';
import '../models/work_time_response_model.dart';

class OfficeProviderRepo {
  final ApiService _apiService;

  OfficeProviderRepo(this._apiService);

  //get analysis for products
  Future<ApiResult<MyOfficeResponseModel>> getAnalytics() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getOfficeAnalytics(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get services ymtaz
  Future<ApiResult<ServicesYmtazResponseModel>>
      getServicesYmtazToProvider() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getServicesYmtazToProvider(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LawyerAppointments>> getAppointmentsLawyerTypes() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      LawyerAppointments response;

      response = await _apiService.getAppointmentsLawyerTypes(token);

      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MyClientsResponse>> getMyClients(String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getClients(token, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // create services request
  Future<ApiResult<CreateServicesYmtazResponseModel>>
      createServicesYmtazToProvider(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.createServicesYmtazToProvider(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> hideServices(
      String id, Map<String, String> data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.hideServiceFromProfile(token, id, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> deleteServices(
    String id,
  ) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.deleteServiceFromProfile(token, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> hideAdvisoryServices(
      String id, Map<String, String> data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.hideAdvisoryServiceFromProfile(token, id, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> deleteAdvisory(
    String id,
  ) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.deleteAdvisoryServiceFromProfile(token, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> hideAppointments(
      String id, Map<String, String> data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.hideAppointmentsProfile(token, id, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessModel>> deleteAppointments(
    String id,
  ) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.deleteAppointmentsFromProfile(token, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<SuccessAppointmentsRequest>>
      createAppointmentsTypesToProvider(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.createAppointmentsTypesToProvider(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  // get services from clents and reply to them
  Future<ApiResult<ServicesFromClientsResponse>>
      getServicesRequestFromClients() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getServicesRequestFromClients(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ServiceLawyerOffresResponse>>
      servicesRequestsPending() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.servicesRequestsPending(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<AppointmentOffersLawyer>>
      appointmentsRequestsPending() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.appointmentsRequestsPending(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ServicesReplySuccessResponse>>
      replyServicesRequestFromClients(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.replyServicesRequestFromClients(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseLawyerToOffer>>
      replyServicesOfferProviderOfficeClient(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.replyServicesOfferProviderOfficeClient(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseLawyerToAppointmentOffer>>
      replyAppointmentsOfferProviderOfficeClient(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService
          .replyAppointmentsOfferProviderOfficeClient(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  Future<ApiResult<ServicesReplySuccessResponse>>
      replyAdvisoryRequestFromClients(FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.replyAdvisorServicesProvider(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get advisory and reply to them

  Future<ApiResult<LawyerAdvisoriesRequestsResponnse>>
      getAdvisoryRequestFromClients() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getAdvisoryRequestFromClients(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get appointments

  Future<ApiResult<AppointmentOfficeReservationsClient>>
      getAppointmentsRequestFromClients() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getAppointmetnsFromClients(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<SuccessModel>> appointmentsRequestsAttend(
      FormData data, String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.appointmentsRequestsAttend(token, id, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get advisory and add advisory
  Future<ApiResult<AdvisoryAvailableTypesResponse>>
      getAdvisorServicesProviderOffice() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.getAdvisorServicesProviderOffice(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // addAdvisorServicesProviderOffice
  Future<ApiResult<AdvisoryTypesAddResponse>> addAdvisorServicesProviderOffice(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.addAdvisorServicesProviderOffice(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data['message']);
    }
  }

  // post working hours
  Future<ApiResult<WorkTimeResponseModel>> postWorkingHours(data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.lawyerWorkingHours(token, data);
      print("success");
      return ApiResult.success(response);
    } on DioException catch (error) {
      print(error.error);

      return ApiResult.failure(error.response?.data);
    }
  }

  // get working hours

  Future<ApiResult<WorkDaysAndTimes>> getWorkingHours() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getLawyerWorkingHours(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
