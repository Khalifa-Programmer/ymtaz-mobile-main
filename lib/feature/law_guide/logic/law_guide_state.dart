part of 'law_guide_cubit.dart';

@immutable
sealed class LawGuideState {}

final class LawGuideInitial extends LawGuideState {}

final class LawGuideLoading extends LawGuideState {}

final class LawGuideLoadingMore extends LawGuideState {}

final class LawGuideLoaded extends LawGuideState {}

final class LawGuideNext extends LawGuideState {}

final class LawGuideError extends LawGuideState {
  final String message;

  LawGuideError(this.message);
}
