import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/chat_repository_impl.dart';
import 'chat_event.dart';
import 'chat_state.dart';

const kEnglish = 'English';

class ChatSynopsisBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatCompletionRepository;

  ChatSynopsisBloc(this.chatCompletionRepository) : super(EmptyChat()) {
    on<GetChatSynopsisCompletionEvent>((event, emit) => _handleChatSynopsisCompletion(event, emit));
    on<ClearChatEvent>((event, emit) async => emit(EmptyChat()));
  }

  void _handleChatSynopsisCompletion(GetChatSynopsisCompletionEvent event, Emitter<ChatState> emit) async {
    emit(LoadingChatSynopsis());
    if (event.country['lang'] == kEnglish) {
      emit(GotChatSynopsisSuccessfully(null, event.input));
      return;
    }

    final result = await chatCompletionRepository.getChatCompletion(event.country['lang']!, event.input);
    emit(result.fold(
            (l) => ErrorChat(l.getMessage()),
            (r) => GotChatSynopsisSuccessfully(r, null)
    ));
  }
}

class ChatEpisodeBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatCompletionRepository;
  String? _lang;
  String? _input;

  ChatEpisodeBloc(this.chatCompletionRepository) : super(EmptyChat()) {
    on<GetChatEpisodeCompletionEvent>((event, emit) => _handleChatEpisodeCompletion(event, emit));
    on<ClearChatEvent>((event, emit) async => emit(EmptyChat()));
  }

  void _handleChatEpisodeCompletion(GetChatEpisodeCompletionEvent event, Emitter<ChatState> emit) async {
    if (event.input == _input && _lang == event.country['lang']) {
      return;
    }

    _lang = event.country['lang'];
    _input = event.input;

    emit(LoadingChatEpisode());
    if (event.country['lang'] == kEnglish) {
      emit(GotChatEpisodeSuccessfully(null, event.input));
      return;
    }

    final result = await chatCompletionRepository.getChatCompletion(event.country['lang']!, event.input);
    emit(result.fold(
            (l) => ErrorChat(l.getMessage()),
            (r) => GotChatEpisodeSuccessfully(r, null)
    ));

  }
}
