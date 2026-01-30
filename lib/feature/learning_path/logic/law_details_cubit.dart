import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/law_details_response.dart';

import 'law_details_state.dart';

class LawDetailsCubit extends Cubit<LawDetailsState> {
  final LearningPathRepo _repo;
  LawDetails? _law;

  LawDetailsCubit(this._repo) : super(LawDetailsInitial());

  LawDetails? get law => _law;

  Future<void> getLawDetails(int lawId) async {
    try {
      emit(LawContentLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getLawDetails(token, lawId);

      if (response.status) {
        _law = response.data.law;
        emit(LawContentLoaded());
      } else {
        emit(LawContentError(response.message));
      }
    } catch (e) {
      emit(LawContentError('فشل في تحميل تفاصيل المادة'));
    }
  }

  Future<void> markAsRead(
    int itemId,
    int pathId,
  ) async {
    emit(MarkingAsRead());
    try {
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.updateLearningProgress(token, 'read', itemId);
      
      response.when(
        success: (data) {
          emit(MarkedAsRead(itemId));
        },
        failure: (error) {
          emit(MarkAsReadError('فشل في تحديث حالة القراءة'));
        },
      );
    } catch (e) {
      emit(MarkAsReadError('فشل في تحديث حالة القراءة'));
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
