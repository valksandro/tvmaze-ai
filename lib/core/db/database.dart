import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

const kDbName = 'db.sqlite';
FlutterQueryExecutor? _queryExecutor;

FutureOr<FlutterQueryExecutor?> openConnection() async {
  if (_queryExecutor != null) {
    return _queryExecutor;
  }

  final dbFolder = await getApplicationDocumentsDirectory();
  _queryExecutor = FlutterQueryExecutor(path: p.join(dbFolder.path, kDbName));
  return _queryExecutor;
}

class Favorite extends Table {
  @override
  Set<Column> get primaryKey => {id};
  IntColumn get id => integer()();
  TextColumn get url => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get summary => text().nullable()();
}

@UseMoor(tables: [Favorite])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _appDatabase;
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: kDbName, logStatements: true));

  factory AppDatabase.single() => _appDatabase ??= AppDatabase();


  @override
  int get schemaVersion => 1;

  Future<List<FavoriteData>> getAllFavorite() => select(favorite).get();

  Future<FavoriteData?> getFavoriteById(int id) {
    return (select(favorite)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertFavorite(FavoriteCompanion entry) =>
      into(favorite).insert(entry, mode: InsertMode.insertOrReplace);

  Future<int> deleteFavorite(int id) async => (delete(favorite)..where((u) => u.id.equals(id))).go();
}
