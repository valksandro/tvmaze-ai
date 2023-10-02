import 'package:dartz/dartz.dart';
import 'package:tvmaze/core/error/failures.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import '../../../../core/db/database.dart';
import '../models/series_model.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, int>> insertFavorite(Show show);
  Future<Either<Failure, List<FavoriteData>>> getAllFavorites();
  Future<Either<Failure, FavoriteData?>> getFavoriteById(int id);
  Future<Either<Failure, int>> delete(final int id);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final AppDatabase appDatabase;

  FavoritesRepositoryImpl({
    required this.appDatabase,
  });

  @override
  Future<Either<Failure, int>> delete(int id) async {
    try {
      final result = await appDatabase.deleteFavorite(id);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> insertFavorite(Show show) async {
    try {
      final result = await appDatabase.insertFavorite(FavoriteCompanion.insert(
          id: moor.Value(show.id),
          url: moor.Value(show.url),
          name: moor.Value(show.name),
          image: moor.Value(show.image.medium),
          summary: moor.Value(show.summary)));

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteData>>> getAllFavorites() async {
    try {
      final result = await appDatabase.getAllFavorite();

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteData?>> getFavoriteById(int id) async {
    try {
      final result = await appDatabase.getFavoriteById(id);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
