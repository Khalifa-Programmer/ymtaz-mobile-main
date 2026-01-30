import '../data/models/book_details_response.dart';

abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsLoaded extends BookDetailsState {
  final BookDetails book;

  BookDetailsLoaded(this.book);
}

class BookDetailsError extends BookDetailsState {
  final String message;

  BookDetailsError(this.message);
}

// حالات جديدة خاصة بالقراءة
class ReadingStateLoading extends BookDetailsState {}

class ReadingStateSuccess extends BookDetailsState {
  final String message;

  ReadingStateSuccess(this.message);
}

class ReadingStateError extends BookDetailsState {
  final String message;

  ReadingStateError(this.message);
} 