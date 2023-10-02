import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SeriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetShowEvent extends SeriesEvent {
  final int page;
  final bool refresh;
  GetShowEvent({this.page = 0, this.refresh = false});
}

class SearchShowByNameEvent extends SeriesEvent {
  final String name;
  SearchShowByNameEvent(this.name);
}

class ClearEvent extends SeriesEvent {}


