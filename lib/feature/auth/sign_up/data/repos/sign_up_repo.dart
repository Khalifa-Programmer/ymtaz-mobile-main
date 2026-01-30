import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/shared/models/accurate_speecialties.dart';
import 'package:yamtaz/core/shared/models/degrees.dart';
import 'package:yamtaz/core/shared/models/functional_cases.dart';
import 'package:yamtaz/core/shared/models/general_specialty.dart';
import 'package:yamtaz/core/shared/models/languages_response.dart';
import 'package:yamtaz/core/shared/models/lawyer_type.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/nationalities_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_provider_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_otp_request.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_request.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_response_body.dart';
import 'package:yamtaz/feature/layout/account/data/models/user_data_model.dart';

import '../../../../../core/network/error/api_result.dart';
import '../../../../../core/network/remote/api_service.dart';
import '../../../../../core/shared/models/resend_code.dart';
import '../../../register/data/model/response_model.dart';
import '../models/countries_response.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response_body.dart';

class SignUpRepo {
  final ApiService _apiService;

  SignUpRepo(this._apiService);

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

  Future<ApiResult<SignUpResponse>> registerClient(
      SignUpRequestBody signUpRequestBody) async {
    try {
      final response = await _apiService.registerClient(signUpRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // verify

  Future<ApiResult<VerifypResponse>> verifyClient(
      VerifyRequestBody verifyRequestBody) async {
    try {
      final response = await _apiService.verifyClient(verifyRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LoginResponse>> verifyOtpEdit(
      String token, String otp) async {
    try {
      final response = await _apiService.verifyOtpEdit(token, otp);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //register provider

  Future<ApiResult<SignUpProviderResponse>> registerProvider(
      FormData signUpRequestBody) async {
    try {
      final response = await _apiService.registerProvider(signUpRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get provider
  Future<ApiResult<UserDataResponse>> getProviderData() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getProvider(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // update provider
  Future<ApiResult<LoginProviderResponse>> editProvider(
      FormData signUpRequestBody) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.editProvider(signUpRequestBody, token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //
  Future<ApiResult<ResendCode>> resendCode(String token) async {
    try {
      final response = await _apiService.resendCode(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<List<ApiResult<dynamic>>> fetchAllData() async {
    try {
      List<Future<ApiResult<dynamic>>> futures = [
        _apiService
            .getCountries()
            .then((response) => ApiResult<CountriesResponse>.success(response)),
        _apiService.nationalities().then(
            (response) => ApiResult<NationalitiesResponse>.success(response)),
        _apiService
            .getGeneralSpecialty()
            .then((response) => ApiResult<GeneralSpecialty>.success(response)),
        _apiService.getAccurateSpecialty().then(
            (response) => ApiResult<AccurateSpecialties>.success(response)),
        _apiService
            .getDegrees()
            .then((response) => ApiResult<Degrees>.success(response)),
        _apiService
            .getLangs()
            .then((response) => ApiResult<LanguagesResponse>.success(response)),
        _apiService
            .getSections()
            .then((response) => ApiResult<SectionsType>.success(response)),
        _apiService
            .getFunctionalCases()
            .then((response) => ApiResult<FunctionalCases>.success(response)),
        _apiService
            .lawyerTypes()
            .then((response) => ApiResult<LawyerTypes>.success(response)),
      ];
      List<ApiResult<dynamic>> results = await Future.wait(futures);

      return results;
    } catch (error) {
      // Handle errors
      return []; // You may want to return an empty list or handle errors differently
    }
  }

  //get countries
  Future<ApiResult<CountriesResponse>> getCountries() async {
    try {
      final response = await _apiService.getCountries();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get nationalities
  Future<ApiResult<NationalitiesResponse>> getNationalities() async {
    try {
      final response = await _apiService.nationalities();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get general specialty
  Future<ApiResult<GeneralSpecialty>> getGeneralSpecialty() async {
    try {
      final response = await _apiService.getGeneralSpecialty();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get accurate specialty
  Future<ApiResult<AccurateSpecialties>> getAccurateSpecialty() async {
    try {
      final response = await _apiService.getAccurateSpecialty();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get degrees
  Future<ApiResult<Degrees>> getDegrees() async {
    try {
      final response = await _apiService.getDegrees();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<LanguagesResponse>> getLangs() async {
    try {
      final response = await _apiService.getLangs();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get sections
  Future<ApiResult<SectionsType>> getSections() async {
    try {
      final response = await _apiService.getSections();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get functional cases
  Future<ApiResult<FunctionalCases>> getFunctionalCases() async {
    try {
      final response = await _apiService.getFunctionalCases();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //get lawyer types
  Future<ApiResult<LawyerTypes>> getLawyerTypes() async {
    try {
      final response = await _apiService.lawyerTypes();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //send request verify provider
  Future<ApiResult<VerifypResponse>> verifyProvider(
      VerifyProviderRequest verifyRequestBody) async {
    try {
      final response = await _apiService.verifyProvider(verifyRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  //send request verify provider otp
  Future<ApiResult<VerifypResponse>> verifyProviderOtp(
      VerifyProviderOtpRequest verifyRequestBody) async {
    try {
      final response = await _apiService.verifyProviderOtp(verifyRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

// Future<ApiResult<SignUpResponse>> signUp (SignUpRequestBody signUpRequestBody) async{
//   try{
//     final response = await _apiService.register(signUpRequestBody);
//     return ApiResult.success(response);
//   } catch (error) {
//     return ApiResult.failure(error);
//   }
//
//
// }
//
// Future<ApiResult<VerifypResponse>> verify(
//     VerifyRequestBody verifyRequestBody) async {
//   try {
//     final response = await _apiService.verify(verifyRequestBody);
//     return ApiResult.success(response);
//   } catch (error) {
//     return ApiResult.failure(error);
//   }
// }
}
