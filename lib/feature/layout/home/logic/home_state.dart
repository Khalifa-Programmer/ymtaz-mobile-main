import 'package:yamtaz/feature/layout/home/data/models/banners_model.dart';

import '../data/models/recent_joined_lawyers_model.dart';

sealed class HomeState {}

final class HomeStateInitial extends HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}

// recent joined lawyers
final class HomeStateRecentJoinedLawyersLoading extends HomeState {}

final class HomeStateRecentJoinedLawyersLoaded extends HomeState {
  final List<NewAdvisory> homeData;

  HomeStateRecentJoinedLawyersLoaded(this.homeData);
}

final class HomeStateRecentJoinedLawyersError extends HomeState {
  final String message;

  HomeStateRecentJoinedLawyersError(this.message);
}

// banners

final class HomeStateBannersLoading extends HomeState {}

final class HomeStateBannersLoaded extends HomeState {
  final List<Banner> banners;

  HomeStateBannersLoaded(this.banners);
}

final class HomeStateBannersError extends HomeState {
  final String message;

  HomeStateBannersError(this.message);
}
