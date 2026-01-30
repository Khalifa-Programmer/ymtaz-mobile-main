import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/about_ymtaz.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/contact_us_types.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/contact_ymtaz_response.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/faq.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/my_contact_ymtaz_Response.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/privacy_policy.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/social_media.dart';

class ContactYmtazRepo {
  final ApiService _apiService;

  ContactYmtazRepo(this._apiService);

  // get contact ymtaz
  Future<ApiResult<MyContactYmtazResponse>> getContactYmtazClient() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getMyYmtazMessagesClient(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // post contact ymtaz
  Future<ApiResult<ContactYmtazResponse>> postContactYmtazClient(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.contactYmtazClient(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // get contact ymtaz
  Future<ApiResult<MyContactYmtazResponse>> getContactYmtazProvider() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getMyYmtazMessagesProvider(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<ContactUsTypes>> getContactUsTypes() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.getContactUsTypes(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // post contact ymtaz
  Future<ApiResult<ContactYmtazResponse>> postContactYmtazProvider(
      FormData data) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _apiService.contactYmtazProvider(token, data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // about us
  Future<ApiResult<AboutYmtaz>> getAboutUs() async {
    try {
      final response = await _apiService.getAboutUs();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // privacy policy
  Future<ApiResult<PrivacyPolicy>> getPrivacyPolicy() async {
    try {
      final response = await _apiService.getPrivacyPolicy();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  // faq
  Future<ApiResult<Faq>> getFaq() async {
    try {
      final response = await _apiService.getFaq();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<SocialMedia>> getSocial() async {
    try {
      final response = await _apiService.getSocial();
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
