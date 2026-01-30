import 'package:dio/dio.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/library_guide/data/model/books_response.dart';

import '../../../../core/network/error/api_result.dart';
import '../../../../core/network/local/cache_helper.dart';

class LibraryGuideRepo {
  final ApiService _apiService;

  LibraryGuideRepo(this._apiService);

  Future<ApiResult<BooksResponse>> getBooks() async {
    var token = CacheHelper.getData(key: 'token');
    try {
      BooksResponse response;
      response = await _apiService.getMainCategoryBooks(token ?? "");
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }
}
