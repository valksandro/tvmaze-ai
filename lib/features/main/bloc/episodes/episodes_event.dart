import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EpisodesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClearEpisodesEvent extends EpisodesEvent {}
class GetEpisodesEvent extends EpisodesEvent {
  final int id;
  GetEpisodesEvent(this.id);
}
