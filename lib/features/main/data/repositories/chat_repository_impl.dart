import 'package:dartz/dartz.dart';
import 'package:tvmaze/core/error/failures.dart';
import 'package:tvmaze/features/main/data/models/chat_completion.dart';

import '../datasources/chat_remote_data_source.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatCompletion>> getChatCompletion(String lang, String input);
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatDataSource;

  ChatRepositoryImpl({
    required this.chatDataSource,
  });


  @override
  Future<Either<Failure, ChatCompletion>> getChatCompletion(String lang, String input) async {
    try {
      final result = await chatDataSource.getChatCompletion(lang, input);

      return Right(result);
    } on Failure catch (e) {
      return Left(ServerFailure(message: e.getMessage()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
