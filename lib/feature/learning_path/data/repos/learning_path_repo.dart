import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/learning_path/data/models/law_details_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_paths_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_progress_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/book_details_response.dart';
import 'package:yamtaz/core/models/base_response.dart';
import 'package:dio/dio.dart';
import 'package:yamtaz/feature/learning_path/data/models/favourite_items_response.dart';

class LearningPathRepo {
  final ApiService _apiService;

  LearningPathRepo(this._apiService);

  Future<LearningPathsResponse> getLearningPaths(String token) async {
    try {
      final response = await _apiService.getLearningPaths('Bearer $token');
      return response;
    } catch (e) {
      throw 'فشل في تحميل البيانات، يرجى المحاولة مرة أخرى';
    }
  }

  Future<LearningPathItemsResponse> getLearningPathItems(String token, int pathId) async {
    try {
      return await _apiService.getLearningPathItems('Bearer $token', pathId);
    } catch (e) {
      throw 'فشل في تحميل عناصر المسار';
    }
  }

  Future<LawDetailsResponse> getLawDetails(String token, int lawId) async {
    try {
      return await _apiService.getLawDetails('Bearer $token', lawId);
    } catch (e) {
      throw 'فشل في تحميل بيانات المادة';
    }
  }

  Future<ApiResult<LearningProgressResponse>> updateLearningProgress(
    String token,
    String type,
    int itemId,
  ) async {
    try {
      LearningProgressResponse response;
      response = await _apiService.updateLearningProgress('Bearer $token', type, itemId);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<BookDetailsResponse> getBookDetails(String token, int sectionId) async {
    try {
      return await _apiService.getBookDetails('Bearer $token', sectionId);
    } catch (e) {
      throw 'فشل في تحميل تفاصيل الكتاب';
    }
  }

  Future<ApiResult<BaseResponse>> toggleFavourite(String token, int itemId) async {
    try {
      final response = await _apiService.toggleFavouriteLearningPathItem('Bearer $token', itemId);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(error.response?.data);
    }
  }

  Future<FavouriteItemsResponse> getFavouriteItems(String token, int pathId) async {
    try {
      return await _apiService.getFavouriteLearningPathItems('Bearer $token', pathId);
    } catch (e) {
      throw 'فشل في تحميل العناصر المفضلة';
    }
  }
} 
