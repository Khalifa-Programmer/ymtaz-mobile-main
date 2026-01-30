import 'package:equatable/equatable.dart';
import '../data/models/law_details_response.dart';
import '../data/models/learning_path_items_response.dart';
import '../data/models/learning_paths_response.dart';

sealed class LearningPathState extends Equatable {
  const LearningPathState();
  
  @override
  List<Object?> get props => [];
}

// حالات صفحة المسارات
class LearningPathInitial extends LearningPathState {}

class LearningPathsLoading extends LearningPathState {
  final List<LearningPath>? paths;
  const LearningPathsLoading([this.paths]);

  @override
  List<Object?> get props => [paths];
}

class LearningPathsLoaded extends LearningPathState {
  final List<LearningPath> paths;
  const LearningPathsLoaded(this.paths);

  @override
  List<Object> get props => [paths];
}

class LearningPathError extends LearningPathState {
  final String message;
  final List<LearningPath>? paths;

  const LearningPathError(this.message, [this.paths]);

  @override
  List<Object?> get props => [message, paths];
}

// حالات صفحة تفاصيل المسار
class LearningPathItemsLoading extends LearningPathState {
  final List<PathItem>? items;
  final PathAnalytics? analytics;
  
  const LearningPathItemsLoading([this.items, this.analytics]);

  @override
  List<Object?> get props => [items, analytics];
}

class LearningPathItemsLoaded extends LearningPathState {
  final List<PathItem> items;
  final PathAnalytics analytics;
  final String? error;
  final LawDetails? currentLaw;
  final bool isLoadingLaw;
  final bool isMarkingAsRead;

  const LearningPathItemsLoaded({
    required this.items,
    required this.analytics,
    this.error,
    this.currentLaw,
    this.isLoadingLaw = false,
    this.isMarkingAsRead = false,
  });

  @override
  List<Object?> get props => [
    items, 
    analytics, 
    error, 
    currentLaw, 
    isLoadingLaw,
    isMarkingAsRead
  ];

  LearningPathItemsLoaded copyWith({
    List<PathItem>? items,
    PathAnalytics? analytics,
    String? error,
    LawDetails? currentLaw,
    bool? isLoadingLaw,
    bool? isMarkingAsRead,
  }) {
    return LearningPathItemsLoaded(
      items: items ?? this.items,
      analytics: analytics ?? this.analytics,
      error: error,
      currentLaw: currentLaw ?? this.currentLaw,
      isLoadingLaw: isLoadingLaw ?? this.isLoadingLaw,
      isMarkingAsRead: isMarkingAsRead ?? this.isMarkingAsRead,
    );
  }
}
class ReadingStateLoading extends LearningPathState {}

// حالات القراءة
class ReadingStateSuccess extends LearningPathState {
  final String message;
  const ReadingStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ReadingStateError extends LearningPathState {
  final String message;
  const ReadingStateError(this.message);

  @override
  List<Object> get props => [message];
}

class LawDetailsLoading extends LearningPathState {}

class LawDetailsLoaded extends LearningPathState {}

class LawDetailsError extends LearningPathState {
  final String message;

  const LawDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// إضافة حالات الكتب
class BookDetailsLoading extends LearningPathState {}

class BookDetailsLoaded extends LearningPathState {}

class BookDetailsError extends LearningPathState {
  final String message;

  const BookDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// حالات المفضلة
class FavouriteLoading extends LearningPathState {}

class FavouriteSuccess extends LearningPathState {
  final String message;
  final int itemId;
  final bool isFavourite;

  const FavouriteSuccess(this.message, this.itemId, this.isFavourite);

  @override
  List<Object> get props => [message, itemId, isFavourite];
}

class FavouriteError extends LearningPathState {
  final String message;

  const FavouriteError(this.message);

  @override
  List<Object> get props => [message];
}