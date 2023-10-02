import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tvmaze/features/main/data/models/chat_completion.dart';

@immutable
abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyChat extends ChatState {}

class GotChatSynopsisSuccessfully extends ChatState {
  final ChatCompletion? chatCompletion;
  final String? input;
  GotChatSynopsisSuccessfully(this.chatCompletion, this.input);
}

class GotChatEpisodeSuccessfully extends ChatState {
  final ChatCompletion? chatCompletion;
  final String? input;
  GotChatEpisodeSuccessfully(this.chatCompletion, this.input);
}

class LoadingChatSynopsis extends ChatState {}
class LoadingChatEpisode extends ChatState {}

class ErrorChat extends ChatState {
  final String message;

  ErrorChat(this.message);
}

