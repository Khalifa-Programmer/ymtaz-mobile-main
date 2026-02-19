import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/layout/account/data/models/experience_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/iban_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/invites_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/my_payments_response.dart';
import 'package:yamtaz/feature/layout/account/data/models/success_fcm_response.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/data/models/remove_response.dart';

import '../../../../../core/network/error/api_result.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../auth/login/data/models/login_provider_response.dart';
import '../../../../auth/register/data/model/response_model.dart';
import '../../../../auth/sign_up/data/models/countries_response.dart';
import '../../../../auth/sign_up/data/models/nationalities_response.dart';
import '../models/points_rules.dart';

class MyAccountRepo {
  final ApiService _apiService;

  MyAccountRepo(this._apiService);

  // add experience
  Future<ApiResult<ExperienceModel>> addMyWorkExperience(
      List<dynamic> experience) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.addMyWorkExperience(token, experience);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get my work experience

  Future<ApiResult<ExperienceModel>> getMyWorkExperience() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getMyWorkExperience(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MyPaymentsResponse>> getPayments() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getPayments(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // add iban
  Future<ApiResult<IbanModel>> addIban(FormData iban) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.addMyIban(token, iban);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get iban
  Future<ApiResult<IbanModel>> getIban() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getMyIban(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get provider
  Future<ApiResult<LoginProviderResponse>> getProviderData() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getProfile(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<InvitesModel>> getInvitations() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getInvitedUsers(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseModel>> sendInvitation(
      Map<String, String> data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.inviteUser(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<List<ApiResult<dynamic>>> fetchAllDataRequest() async {
    try {
      List<Future<ApiResult<dynamic>>> futures = [
        _apiService
            .getCountries()
            .then((response) => ApiResult<CountriesResponse>.success(response)),
        _apiService.nationalities().then(
            (response) => ApiResult<NationalitiesResponse>.success(response)),
      ];
      List<ApiResult<dynamic>> results = await Future.wait(futures);

      return results;
    } catch (error) {
      // Handle errors
      return []; // You may want to return an empty list or handle errors differently
    }
  }

  //get client
  Future<ApiResult<LoginProviderResponse>> getClientData() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getProfile(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // remove account
  Future<ApiResult<RemoveResponse>> removeAccount(
      FormData removeAccount) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.removeProfile(token, removeAccount);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // remove account
  Future<ApiResult<RemoveResponse>> removeAccountProvider(
      FormData removeAccount) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response =
          await _apiService.removeProfileProvider(token, removeAccount);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // update client
  Future<ApiResult<LoginProviderResponse>> updateClientData(
      FormData clientProfile) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.updateProfile(token, clientProfile);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  // send fcm token
  Future<ApiResult> sendFcmToken() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final messaging = FirebaseMessaging.instance;

    String? fcm = await messaging.getToken();
    Map<String, dynamic> data = {
      'device_id': await _getId(),
      'type': Platform.isAndroid ? '1' : '2',
      'fcm_token': fcm
    };
    var body = FormData.fromMap(data);
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      final SuccessFcmResponse response;
      if (userType == 'client') {
        response = await _apiService.sendFcmToken(token, body);
      } else {
        response = await _apiService.sendFcmTokenProvider(token, body);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult> deleteFcmToken(String token) async {
    var userType = CacheHelper.getData(key: 'userType');
    String? id = await _getId();
    if (id == null) return ApiResult.failure("Device ID not found");

    try {
      final SuccessFcmResponse response;
      if (userType == 'client') {
        response = await _apiService.deleteFcmToken(token, id);
      } else {
        response = await _apiService.deleteFcmTokenProvider(token, id);
      }
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // gamification
  Future<ApiResult<PointsRules>> getPointsRules() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getPointsRules(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseModel>> validatePhone(
      String phone, String ccode) async {
    try {
      final response = await _apiService.verifyPhone(phone, ccode);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ResponseModel>> verifyPhoneOtp(
      String phone, String ccode, String code) async {
    try {
      final response = await _apiService.confirmPhone(code, phone, ccode);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
