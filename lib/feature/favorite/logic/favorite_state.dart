import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState<T> with _$FavoriteState {
  const factory FavoriteState.initial() = _Initial;

  const factory FavoriteState.loadingAddLawyerToFavorite() =
      LoadingAddLawyerToFavorite;

  const factory FavoriteState.loadedAddLawyerToFavorite() =
      LoadedAddLawyerToFavorite;

  const factory FavoriteState.errorAddLawyerToFavorite(String message) =
      ErrorAddLawyerToFavorite;

  const factory FavoriteState.loadingGetFavoriteLawyers() =
      LoadingGetFavoriteLawyers;

  const factory FavoriteState.loadedGetFavoriteLawyers(T data) =
      LoadedGetFavoriteLawyers;

  const factory FavoriteState.errorGetFavoriteLawyers(String message) =
      ErrorGetFavoriteLawyers;
}
