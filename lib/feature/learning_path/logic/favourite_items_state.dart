import 'package:equatable/equatable.dart';
import '../data/models/favourite_items_response.dart';

sealed class FavouriteItemsState extends Equatable {
  const FavouriteItemsState();
  
  @override
  List<Object?> get props => [];
}

class FavouriteItemsInitial extends FavouriteItemsState {}

class FavouriteItemsLoading extends FavouriteItemsState {
  final List<FavouriteItem>? items;
  
  const FavouriteItemsLoading([this.items]);

  @override
  List<Object?> get props => [items];
}

class FavouriteItemsLoaded extends FavouriteItemsState {
  final List<FavouriteItem> items;
  final String? error;

  const FavouriteItemsLoaded({
    required this.items,
    this.error,
  });

  @override
  List<Object?> get props => [items, error];
}

class FavouriteItemsError extends FavouriteItemsState {
  final String message;

  const FavouriteItemsError(this.message);

  @override
  List<Object> get props => [message];
}

class RemovingFromFavourites extends FavouriteItemsState {
  final int itemId;
  
  const RemovingFromFavourites(this.itemId);
  
  @override
  List<Object> get props => [itemId];
}

class RemovedFromFavourites extends FavouriteItemsState {
  final int itemId;
  final String message;
  
  const RemovedFromFavourites({
    required this.itemId,
    required this.message,
  });
  
  @override
  List<Object> get props => [itemId, message];
}

class RemoveFromFavouritesError extends FavouriteItemsState {
  final String message;
  
  const RemoveFromFavouritesError(this.message);
  
  @override
  List<Object> get props => [message];
} 
