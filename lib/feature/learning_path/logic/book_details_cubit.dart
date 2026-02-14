import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/learning_path/data/models/book_details_response.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';

import 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final LearningPathRepo _repo;
  BookDetails? currentBook;
  bool isLoadingRead = false;
  bool isLoadingLearn = false;

  BookDetailsCubit(this._repo) : super(BookDetailsInitial());

  Future<void> getBookDetails(int sectionId) async {
    try {
      emit(BookDetailsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getBookDetails(token, sectionId);
      
      if (response.status) {
        currentBook = response.data.book;
        emit(BookDetailsLoaded(currentBook!));
      } else {
        emit(BookDetailsError(response.message));
      }
    } catch (e) {
      emit(BookDetailsError('فشل في تحميل تفاصيل الكتاب'));
    }
  }

  // Future<bool> markAsRead(int itemId) async {
  //   if (currentBook == null) return false;
  //
  //   try {
  //     emit(ReadingStateLoading());
  //
  //     final token = CacheHelper.getData(key: 'token') as String;
  //     final response = await _repo.updateLearningProgress(token, 'read', itemId);
  //
  //     if (response.status) {
  //       emit(ReadingStateSuccess('تم تحديث حالة القراءة بنجاح'));
  //       emit(BookDetailsLoaded(currentBook!));
  //       return true;
  //     } else {
  //       emit(ReadingStateError(response.message));
  //       return false;
  //     }
  //   } catch (e) {
  //     emit(ReadingStateError('فشل في تحديث حالة القراءة'));
  //     return false;
  //   }
  // }

  // Future<bool> markAsLearned(int itemId) async {
  //   if (currentBook == null) return false;
  //
  //   try {
  //     isLoadingLearn = true;
  //     emit(BookDetailsLoaded(currentBook!));
  //
  //     final token = CacheHelper.getData(key: 'token') as String;
  //     final response = await _repo.updateLearningProgress(token, 'learned', itemId);
  //
  //     isLoadingLearn = false;
  //     if (response.status) {
  //       emit(BookDetailsLoaded(currentBook!));
  //       return true;
  //     } else {
  //       emit(BookDetailsLoaded(currentBook!));
  //       return false;
  //     }
  //   } catch (e) {
  //     isLoadingLearn = false;
  //     emit(BookDetailsLoaded(currentBook!));
  //     return false;
  //   }
  // }

  bool get isReadLoading => isLoadingRead;
  bool get isLearnLoading => isLoadingLearn;
} 
