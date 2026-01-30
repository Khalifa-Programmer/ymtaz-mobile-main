import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/favorite/data/model/favorite_response_model.dart';
import 'package:yamtaz/feature/favorite/data/repo/favorite_repo.dart';
import 'package:yamtaz/feature/favorite/logic/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteRepo _favoriteRepo;

  FavoriteCubit(this._favoriteRepo) : super(const FavoriteState.initial());

  void addLawyerToFavorite(String lawyerId) async {
    emit(const FavoriteState.loadingAddLawyerToFavorite());
    final result = await _favoriteRepo.addLawyerToFavorite(lawyerId);
    result.when(
      success: (data) {
        getFavoriteLawyers();
        emit(const FavoriteState.loadedAddLawyerToFavorite());
      },
      failure: (message) {
        emit(FavoriteState.errorAddLawyerToFavorite(message));
      },
    );
  }

  FavoriteResponseModel? favoriteResponseModel;

  void getFavoriteLawyers() async {
    emit(const FavoriteState.loadingGetFavoriteLawyers());
    final result = await _favoriteRepo.getFavoriteLawyers();
    result.when(
      success: (data) {
        favoriteResponseModel = data;
        emit(FavoriteState.loadedGetFavoriteLawyers(data));
      },
      failure: (message) {
        emit(FavoriteState.errorGetFavoriteLawyers(message));
      },
    );
  }
}
