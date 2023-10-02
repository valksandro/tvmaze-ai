
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tvmaze/core/error/failures.dart';
import '../../../../di.dart';
import '../models/chat_completion.dart';

abstract class ChatRemoteDataSource {
  Future<ChatCompletion> getChatCompletion(String lang, String input);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio = sl.get<Dio>(instanceName: 'openaiDio');

  @override
  Future<ChatCompletion> getChatCompletion(String lang, String input) async {
    final response = await dio.post(
      '/chat/completions',
      data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": "You will be provided with a sentence in English, and your task is to translate it into $lang. Do not change the html format if there is one"
          },
          {
            "role": "user",
            "content": input }
        ],
        "temperature": 0,
        "max_tokens": 256,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      },
    ).onError<DioError>((e, _) {
      throw ServerFailure(message: e.message);
    });

    if (response.statusCode == HttpStatus.ok) {
      if (response.data.isNotEmpty) {
        return ChatCompletion.fromJson(response.data);
      } else {
        throw ServerFailure(message: 'Empty response data');
      }
    }
    throw ServerFailure(message: response.statusMessage ?? 'Error getChatCompletion');
  }
}

