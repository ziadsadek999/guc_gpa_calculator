import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
part 'database.g.dart';

@DataClassName('Semester')
class Semesters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(min: 1, max: 64)();
  IntColumn get season => integer().unique()();
}

@DataClassName('Course')
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  IntColumn get hours => integer()();
  RealColumn get grade => real()
      .check(grade.isIn([0.7, 1, 1.3, 1.7, 2, 2.3, 2.7, 3, 3.3, 3.7, 4, 5]))();
  IntColumn get semester => integer().references(Semesters, #id)();
  @override
  List<Set<Column>> get uniqueKeys => [
        {name, semester},
      ];
}

@DriftDatabase(tables: [Semesters, Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Semester>> get allSemesters => select(semesters).watch();
  Stream<List<Course>> getSemesterCourses(Semester s) {
    return (select(courses)..where((c) => c.semester.equals(s.id))).watch();
  }

  Stream<List<Semester>> getAllSemesters() {
    return select(semesters).watch();
  }

  Future<int> createSemester(SemestersCompanion entry) {
    return into(semesters).insert(entry);
  }

  Future<int> createCourse(CoursesCompanion entry) {
    return into(courses).insert(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
