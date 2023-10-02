import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tvmaze/features/main/data/models/series_model.dart';

@immutable
abstract class SeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends SeriesState {}

class GotShowSuccessfully extends SeriesState {
  final List<Show> showList;
  GotShowSuccessfully(this.showList);
}

class GotShowByNameSuccessfully extends SeriesState {
  final List<Show> showList;
  GotShowByNameSuccessfully(this.showList);
}

class Loading extends SeriesState {}

class Error extends SeriesState {
  final String message;

  Error(this.message);
}
