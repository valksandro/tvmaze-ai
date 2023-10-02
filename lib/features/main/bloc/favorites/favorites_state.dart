import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tvmaze/features/main/data/models/series_model.dart';

import '../../../../core/db/database.dart';

@immutable
abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyFavorites extends FavoritesState {}
class InsertedFavoriteSuccessfully extends FavoritesState {}
class DeletedFavoriteSuccessfully extends FavoritesState {}

class GotFavoriteShowSuccessfully extends FavoritesState {
  final Show show;
  GotFavoriteShowSuccessfully(this.show);
}

class GotAllFavoritesSuccessfully extends FavoritesState {
  final List<FavoriteData> favoriteShows;
  GotAllFavoritesSuccessfully(this.favoriteShows);
}

class GotFavoriteSuccessfully extends FavoritesState {
  final FavoriteData? favorite;
  GotFavoriteSuccessfully(this.favorite);
}

class GotFavoritesSuccessfully extends FavoritesState {
  final List<MapEntry<int, List<Episode>>> episodeList;
  GotFavoritesSuccessfully(this.episodeList);
}

class LoadingFavorites extends FavoritesState {}

class ErrorFavorites extends FavoritesState {
  final String message;

  ErrorFavorites(this.message);
}

