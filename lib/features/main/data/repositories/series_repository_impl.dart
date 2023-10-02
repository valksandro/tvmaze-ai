import 'package:dartz/dartz.dart';
import 'package:tvmaze/core/error/failures.dart';
import 'package:tvmaze/features/main/data/datasources/series_remote_data_source.dart';

import '../models/series_model.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Show>>> getShow({final int page = 0});
  Future<Either<Failure, Show>> getShowById(final int id);
  Future<Either<Failure, List<Show>>> searchShowByName(final String name);
  Future<Either<Failure, List<Episode>>> getShowEpisodes(final int id);
}

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDataSource remoteDataSource;

  SeriesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Show>>> getShow({final int page = 0}) async {
    try {
      final result = await remoteDataSource.getShow(page);

      return Right(result);
    } on Failure catch (e) {
      return Left(ServerFailure(message: e.getMessage()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getShowEpisodes(final int id) async {
    try {
      final result = await remoteDataSource.getShowEpisodes(id);

      return Right(result);
    } on Failure catch (e) {
      return Left(ServerFailure(message: e.getMessage()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Show>>> searchShowByName(final String name) async {
    try {
      final result = await remoteDataSource.searchShowByName(name);

      return Right(result);
    } on Failure catch (e) {
      return Left(ServerFailure(message: e.getMessage()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Show>> getShowById(int id) async {
    try {
      final result = await remoteDataSource.getShowById(id);

      return Right(result);
    } on Failure catch (e) {
      return Left(ServerFailure(message: e.getMessage()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
