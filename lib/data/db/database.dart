import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:films_viewer/data/db/tables/movie_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'database.g.dart';

@DriftDatabase(tables: [MovieTable])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
}
