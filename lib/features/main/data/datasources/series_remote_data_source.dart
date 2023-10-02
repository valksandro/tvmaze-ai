import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tvmaze/core/error/failures.dart';
import '../models/series_model.dart';

abstract class SeriesRemoteDataSource {
  Future<List<Show>> getShow(final int page);
  Future<Show> getShowById(final int id);
  Future<List<Show>> searchShowByName(final String name);
  Future<List<Episode>> getShowEpisodes(final int id);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final Dio dio;

  SeriesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Show>> getShow(final int page) async {
    final response =
        await dio.get('/shows?page=$page').onError<DioError>((e, _) {
      throw ServerFailure(message: e.message);
    });
    if (response.statusCode == HttpStatus.ok) {
      if (response.data.isNotEmpty) {
        return (response.data as List).map((e) => Show.fromJson(e)).toList();
      } else {
        return <Show>[];
      }
    }
    throw ServerFailure(message: response.statusMessage ?? 'Error getShow');
  }

  @override
  Future<List<Episode>> getShowEpisodes(final int id) async {
    final response =
        await dio.get('/shows/$id/episodes').onError<DioError>((e, _) {
      throw ServerFailure(message: e.message);
    });
    if (response.statusCode == HttpStatus.ok) {
      if (response.data.isNotEmpty) {
        return (response.data as List).map((e) => Episode.fromJson(e)).toList();
      } else {
        return <Episode>[];
      }
    }
    throw ServerFailure(
        message: response.statusMessage ?? 'Error getShowEpisodes');
  }

  @override
  Future<List<Show>> searchShowByName(final String name) async {
    final response = await dio
        .get('/search/shows?q=$name'.replaceAll(' ', '%20'))
        .onError<DioError>((e, _) {
      throw ServerFailure(message: e.message);
    });
    if (response.statusCode == HttpStatus.ok) {
      if (response.data.isNotEmpty) {
        return (response.data as List)
            .map((e) => Show.fromJson(e['show']))
            .toList();
      } else {
        return <Show>[];
      }
    }
    throw ServerFailure(
        message: response.statusMessage ?? 'Error searchShowByName');
  }

  @override
  Future<Show> getShowById(int id) async {
    final response = await dio.get('/shows/$id').onError<DioError>((e, _) {
      throw ServerFailure(message: e.message);
    });
    if (response.statusCode == HttpStatus.ok) {
      if (response.data.isNotEmpty) {
        return Show.fromJson(response.data);
      } else {
        return Show();
      }
    }
    throw ServerFailure(message: response.statusMessage ?? 'Error getShowById');
  }
}
