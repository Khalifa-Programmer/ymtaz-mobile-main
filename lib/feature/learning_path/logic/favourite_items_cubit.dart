import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';
import 'package:yamtaz/feature/learning_path/logic/favourite_items_state.dart';

class FavouriteItemsCubit extends Cubit<FavouriteItemsState> {
  final LearningPathRepo _repo;
  
  FavouriteItemsCubit(this._repo) : super(FavouriteItemsInitial());
  
  Future<void> getFavouriteItems(int pathId) async {
    try {
      emit(FavouriteItemsLoading());
      final token = CacheHelper.getData(key: 'token') as String;
      final response = await _repo.getFavouriteItems(token, pathId);

      if (response.status) {
        emit(FavouriteItemsLoaded(
          items: response.data.favouriteLearningPathItems,
        ));
      } else {
        emit(FavouriteItemsLoaded(
          items: [],
          error: response.message,
        ));
      }
    } catch (e) {
      emit(FavouriteItemsError(e.toString()));
    }
  }
  
  Future<void> removeFromFavourites(int itemId) async {
    try {
      emit(RemovingFromFavourites(itemId));
      final token = CacheHelper.getData(key: 'token') as String;
      final result = await _repo.toggleFavourite(token, itemId);
      
      result.when(
        success: (response) {
          emit(RemovedFromFavourites(
            itemId: itemId,
            message: response.message,
          ));
        },
        failure: (error) {
          emit(RemoveFromFavouritesError(error['message'] ?? 'حدث خطأ أثناء إزالة العنصر من المفضلة'));
        },
      );
    } catch (e) {
      emit(RemoveFromFavouritesError(e.toString()));
    }
  }
} 
