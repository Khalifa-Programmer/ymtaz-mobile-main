
abstract class LawDetailsState {}

class LawDetailsInitial extends LawDetailsState {}

// حالات تحميل المادة
class LawContentLoading extends LawDetailsState {}
class LawContentLoaded extends LawDetailsState {}
class LawContentError extends LawDetailsState {
  final String message;
  LawContentError(this.message);
}

// حالات تحديث القراءة
class MarkingAsRead extends LawDetailsState {}
class MarkedAsRead extends LawDetailsState {
  final int itemId;
  MarkedAsRead(this.itemId);
}
class MarkAsReadError extends LawDetailsState {
  final String message;
  MarkAsReadError(this.message);
}

// حالات المفضلة
class FavouriteLoading extends LawDetailsState {}

class FavouriteSuccess extends LawDetailsState {
  final String message;
  final int itemId;
  final bool isFavourite;

  FavouriteSuccess(this.message, this.itemId, this.isFavourite);
}

class FavouriteError extends LawDetailsState {
  final String message;

  FavouriteError(this.message);
}

// حالات القراءة
// class ReadingStateLoading extends LawDetailsState {}
//
// class ReadingStateSuccess extends LawDetailsState {
//   final String message;
//
//   ReadingStateSuccess(this.message);
// }
//
// class ReadingStateError extends LawDetailsState {
//   final String message;
//
//   ReadingStateError(this.message);
// }
