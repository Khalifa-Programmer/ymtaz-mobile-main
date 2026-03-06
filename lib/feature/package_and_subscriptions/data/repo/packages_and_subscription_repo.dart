import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/package_and_subscriptions/data/model/my_package_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/success_fcm_response.dart';

import '../model/packages_model.dart';
import '../model/packages_subscribe_model.dart';


class PacakagesAndSubscriptionRepo {

  final ApiService _packageApi;

  PacakagesAndSubscriptionRepo(this._packageApi);

  //
  // Future<(ApiResult<PackagesModel>, ApiResult<MyPackageModel>)> getParallelPackageData() async {
  //   var token = CacheHelper.getData(key: 'token');
  //
  //   // Create both Future requests
  //   final Future<ApiResult<PackagesModel>> packagesRequest = getPackages();
  //   final Future<ApiResult<MyPackageModel>> myPackageRequest = myPackage();
  //
  //   // Run them in parallel and wait for both to complete
  //   final results = await Future.wait([
  //     packagesRequest,
  //     myPackageRequest,
  //   ]);
  //
  //   // Return results as a tuple using Records (Dart 3.0+)
  //   return (
  //   results[0] as ApiResult<PackagesModel>,
  //   results[1] as ApiResult<MyPackageModel>
  //   );
  // }

  Future<ApiResult<PackagesModel>> getPackages() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _packageApi.getPackages(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<ApiResult<MyPackageModel>> myPackage() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _packageApi.myPackage(token);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }



  Future<ApiResult<PackagesSubscribeModel>> subscribePackage(String id) async {
    var token = CacheHelper.getData(key: 'token');

    if (token == null) {
      print('❌ Subscribe Package Error: Token is null');
      return ApiResult.failure({'message': 'الرجاء تسجيل الدخول أولاً'});
    }

    Map<String, dynamic> data = {
      'package_id': int.parse(id),
    };

    print('═══════════════════════════════════════');
    print('📦 [SUBSCRIBE] محاولة الاشتراك بالباقة رقم: $id');
    print('🔑 [SUBSCRIBE] Token: ${token.substring(0, 20)}...');
    print('📤 [SUBSCRIBE] Request Body: $data');
    print('═══════════════════════════════════════');

    try {
      final response = await _packageApi.subscribePackage(token, data);

      print('═══════════════════════════════════════');
      print('✅ [SUBSCRIBE] نجح الطلب!');
      print('📋 [SUBSCRIBE] status: ${response.status}');
      print('📋 [SUBSCRIBE] code: ${response.code}');
      print('📋 [SUBSCRIBE] message: ${response.message}');
      print('📋 [SUBSCRIBE] data: ${response.data}');
      print('📋 [SUBSCRIBE] data.paymentUrl: ${response.data?.paymentUrl}');
      print('📋 [SUBSCRIBE] data.transactionId: ${response.data?.transactionId}');
      print('📋 [SUBSCRIBE] Full JSON: ${response.toJson()}');
      print('═══════════════════════════════════════');

      if (response.data?.paymentUrl == null || response.data!.paymentUrl!.isEmpty) {
        print('⚠️ [SUBSCRIBE] payment_url فارغ أو null');
        print('⚠️ [SUBSCRIBE] هذا يعني أن البيك إند لم يُعيّن Moyasar API Key!');
      } else {
        print('💳 [SUBSCRIBE] Payment URL من ميسر: ${response.data!.paymentUrl}');
      }

      return ApiResult.success(response);
    } on DioException catch (error) {
      print('═══════════════════════════════════════');
      print('❌ [SUBSCRIBE] DioException!');
      print('📋 [SUBSCRIBE] Status Code: ${error.response?.statusCode}');
      print('📋 [SUBSCRIBE] Error Data: ${error.response?.data}');
      print('📋 [SUBSCRIBE] Error Message: ${error.message}');
      print('═══════════════════════════════════════');

      // Extract error message from response
      String errorMessage = 'حدث خطأ أثناء الاشتراك';

      if (error.response?.statusCode == 500) {
        errorMessage = 'خطأ في الخادم (500). الرجاء التواصل مع الدعم الفني';
      } else if (error.response?.data != null) {
        if (error.response!.data is Map) {
          errorMessage = error.response!.data['message'] ?? errorMessage;
        } else if (error.response!.data is String) {
          String dataStr = error.response!.data.toString();
          if (dataStr.contains('<!DOCTYPE html>') || dataStr.contains('<html')) {
            errorMessage = 'خطأ في الخادم. الرجاء المحاولة لاحقاً';
          } else {
            errorMessage = dataStr;
          }
        }
      }

      return ApiResult.failure({'message': errorMessage});
    } catch (error) {
      print('❌ [SUBSCRIBE] General Error: $error');
      return ApiResult.failure({'message': 'حدث خطأ غير متوقع: $error'});
    }
  }



  // // buy package
  //
  // Future<ApiResult<BuyPackageModel>> buyPackage(FormData data) async {
  //   var token = CacheHelper.getData(key: 'token');
  //   try {
  //     final response = await _packageApi.buyPackage(token, data);
  //     return ApiResult.success(response);
  //   } on DioException catch (error) {
  //     return ApiResult.failure(error.response?.data);
  //   }
  // }
  //
  Future<ApiResult<SuccessFcmResponse>> confirmPaymentPackage(String id) async {
    var token = CacheHelper.getData(key: 'token');
    try {
      final response = await _packageApi.confirmPayment(token!, id);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
