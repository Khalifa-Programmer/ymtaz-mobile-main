import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/learning_path/data/models/book_details_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_paths_response.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';

import '../data/models/book_guide_items_response.dart';
import '../data/models/law_details_response.dart';
import '../data/models/law_guide_items_response.dart';
import 'learning_path_state.dart';


class LearningPathCubit extends Cubit<LearningPathState> {
  final LearningPathRepo _repo;
  List<LearningPath>? _paths;
  LawDetails? currentLaw;
  BookDetails? currentBook;

  LearningPathCubit(this._repo) : super(LearningPathInitial());
  LawDetails? get law => currentLaw;
  BookDetails? get book => currentBook;

  List<LearningPath>? get paths => _paths;

  Future<void> getLearningPaths() async {
    try {
      if (_paths != null) {
        emit(LearningPathsLoaded(_paths!));
        return;
      }

      emit(LearningPathsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getLearningPaths(token);
      _paths = response.data.paths;
      emit(LearningPathsLoaded(_paths!));
    } catch (e) {
      emit(LearningPathError(e.toString(), _paths));
    }
  }

  Future<void> getPathItems(int pathId) async {
    if (_paths == null) {
      await getLearningPaths();
    }

    try {
      emit(LearningPathItemsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getLearningPathItems(token, pathId);

      if (response.status) {
        emit(LearningPathItemsLoaded(
          items: response.data.items,
          analytics: response.data.analytics,
        ));
      } else {
        emit(LearningPathItemsLoaded(
          items: [],
          analytics: PathAnalytics(
            totalItems: 0,
            readItems: 0,
            learnedItems: 0,
            notDoneItems: 0,
            totalSubCategories: 0,
            doneSubCategories: 0,
            notDoneSubCategories: 0,
            totalFavourite: 0,
            lawGuidesFavourite: 0,
            bookGuidesFavourite: 0,
          ),
          error: response.message,
        ));
      }
    } catch (e) {
      emit(LearningPathError(e.toString(), _paths));
    }
  }

  Future<void> retryPathItems(int pathId) async {
    try {
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getLearningPathItems(token, pathId);

      if (response.status) {
        emit(LearningPathItemsLoaded(
          items: response.data.items,
          analytics: response.data.analytics,
        ));
      } else {
        emit(LearningPathItemsLoaded(
          items: [],
          analytics: PathAnalytics(
            totalItems: 0,
            readItems: 0,
            learnedItems: 0,
            notDoneItems: 0,
            totalSubCategories: 0,
            doneSubCategories: 0,
            notDoneSubCategories: 0,
            totalFavourite: 0,
            lawGuidesFavourite: 0,
            bookGuidesFavourite: 0,
          ),
          error: response.message,
        ));
      }
    } catch (e) {
      emit(LearningPathError(e.toString(), _paths));
    }
  }

  Future<void> getLawDetails(int lawId) async {
    try {
      emit(LawDetailsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getLawDetails(token, lawId);

      if (response.status) {
        currentLaw = response.data.law;
        emit(LawDetailsLoaded());
      } else {
        emit(LawDetailsError(response.message));
      }
    } catch (e) {
      emit(LawDetailsError('فشل في تحميل تفاصيل المادة'));
    }
  }

  Future<void> markAsRead(
      int itemId,
      int pathId,
      int currentIndex,
  ) async {
    emit(ReadingStateLoading());
    try {
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.updateLearningProgress(token, 'read', itemId);
      
      response.when(
        success: (data) {
          // تحديث حالة القراءة محلياً فقط
          emit(ReadingStateSuccess('تم تحديث حالة القراءة بنجاح'));
        },
        failure: (error) {
          emit(ReadingStateError('فشل في تحديث حالة القراءة'));
        },
      );
    } catch (e) {
      emit(ReadingStateError('فشل في تحديث حالة القراءة'));
    }
  }

  Future<void> getBookDetails(int bookId) async {
    try {
      emit(BookDetailsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getBookDetails(token, bookId);

      if (response.status) {
        currentBook = response.data.book;
        emit(BookDetailsLoaded());
      } else {
        emit(BookDetailsError(response.message));
      }
    } catch (e) {
      emit(BookDetailsError('فشل في تحميل تفاصيل الكتاب'));
    }
  }

  Future<void> toggleFavourite(int itemId, bool currentState) async {
    emit(FavouriteLoading());
    try {
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.toggleFavourite(token, itemId);
      
      response.when(
        success: (data) {
          emit(FavouriteSuccess(data.message, itemId, !currentState));
        },
        failure: (error) {
          emit(FavouriteError('فشل في تحديث المفضلة'));
        },
      );
    } catch (e) {
      emit(FavouriteError('فشل في تحديث المفضلة'));
    }
  }
}