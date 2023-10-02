import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/series_model.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFavoritesShowEvent extends FavoritesEvent {
  final int id;
  GetFavoritesShowEvent(this.id);
}

class GetAllFavoriteEvent extends FavoritesEvent {}
class DeleteFavoriteEvent extends FavoritesEvent {
  final int id;
  DeleteFavoriteEvent(this.id);
}

class GetFavoriteByIdEvent extends FavoritesEvent {
  final int id;
  GetFavoriteByIdEvent(this.id);
}

class ClearFavoriteEvent extends FavoritesEvent {}
class InsertFavoriteEvent extends FavoritesEvent {
  final Show show;
  InsertFavoriteEvent(this.show);
}
