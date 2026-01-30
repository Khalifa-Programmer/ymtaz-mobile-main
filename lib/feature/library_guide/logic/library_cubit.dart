import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yamtaz/feature/library_guide/data/model/books_response.dart';
import 'package:yamtaz/feature/library_guide/data/repo/library_guide_repo.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryGuideRepo _repo;

  LibraryCubit(this._repo) : super(LibraryInitial());

  BooksResponse? booksResponse;

  void getLawGuide() async {
    emit(LoadingBooks());
    try {
      final response = await _repo.getBooks();
      response.when(
        success: (data) {
          booksResponse = data;
          emit(SuccessBooks());
        },
        failure: (error) {
          emit(SuccessBooks());
        },
      );
    } catch (e) {
      emit(ErrorBooks());
    }
  }

  void clearData() {
    booksResponse = null;
  }
}
