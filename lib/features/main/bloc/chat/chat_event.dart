import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetChatSynopsisCompletionEvent extends ChatEvent {
  final String input;
  final Map<String, String> country;

  GetChatSynopsisCompletionEvent(this.country, this.input);
}

class GetChatEpisodeCompletionEvent extends ChatEvent {
  final String input;
  final Map<String, String> country;

  GetChatEpisodeCompletionEvent(this.country, this.input);
}


class ClearChatEvent extends ChatEvent {}

