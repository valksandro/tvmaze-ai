import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tvmaze/features/main/data/models/series_model.dart';

@immutable
abstract class EpisodesState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyEpisodeList extends EpisodesState {}

class GotEpisodesSuccessfully extends EpisodesState {
  final List<MapEntry<int, List<Episode>>> episodeList;
  GotEpisodesSuccessfully(this.episodeList);
}

class LoadingEpisodes extends EpisodesState {}

class ErrorEpisodes extends EpisodesState {
  final String message;

  ErrorEpisodes(this.message);
}

