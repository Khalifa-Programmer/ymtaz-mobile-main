import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/package_and_subscriptions/data/model/my_package_model.dart';

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

    FormData data = FormData.fromMap({
      'package_id': id,
    }) ;


    try {
      final response = await _packageApi.subscribePackage(token , data);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
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
  // Future<ApiResult<SuccessFcmResponse>> confirmPaymentPackage(String id) async {
  //   var token = CacheHelper.getData(key: 'token');
  //   try {
  //     final response = await _packageApi.confirmPayment(token, id);
  //     return ApiResult.success(response);
  //   } on DioException catch (error) {
  //     return ApiResult.failure(error.response?.data['message']);
  //   }
  // }
}
