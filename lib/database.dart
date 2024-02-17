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
}

@DataClassName('Course')
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  IntColumn get hours => integer()();
  RealColumn get grade => real().check(
      grade.isIn([0, 0.7, 1, 1.3, 1.7, 2, 2.3, 2.7, 3, 3.3, 3.7, 4, 5]))();
  IntColumn get semester => integer().references(Semesters, #id)();
  @override
  List<Set<Column>> get uniqueKeys => [
        {name, semester},
      ];
}

@DataClassName('Grade')
class Grades extends Table {
  TextColumn get name => text()();
  IntColumn get hours => integer()();
  RealColumn get grade => real()();
  @override
  Set<Column> get primaryKey => {name};
}

@DriftDatabase(tables: [Semesters, Courses, Grades])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()) {
    initialize();
  }
  int germanSemesterId = 0;
  int englishSemesterId = 0;
  @override
  int get schemaVersion => 3;
  Future<void> initialize() async {
    Semester? s = await (select(semesters)..limit(1)).getSingleOrNull();
    if (s == null) {
      await initSemesters();
    } else {
      assign();
    }
  }

  Future<void> assign() async {
    Semester? s = await (select(semesters)
          ..where((s) => s.name.equals("German")))
        .getSingleOrNull();
    if (s != null) germanSemesterId = s.id;
    s = await (select(semesters)
          ..where((s) => s.name.equals("English Courses")))
        .getSingleOrNull();
    if (s != null) englishSemesterId = s.id;
  }

  Stream<List<Course>> getSemesterCourses(Semester s) {
    return (select(courses)..where((c) => c.semester.equals(s.id))).watch();
  }

  Stream<List<Course>> getAllCourses() {
    return select(courses).watch();
  }

  Stream<List<Semester>> getAllSemesters() {
    return select(semesters).watch();
  }

  Future<int> createSemester(SemestersCompanion entry) {
    return into(semesters).insert(entry);
  }

  Future<bool> createNormalCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("normal")))
          .getSingle();
      double newGrade =
          grade.grade * grade.hours + entry.grade.value * entry.hours.value;
      int newHours = grade.hours + entry.hours.value;
      await update(grades).replace(
          Grade(name: "normal", hours: newHours, grade: newGrade / newHours));
      await into(courses).insert(entry);
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Stream<List<Grade>> getNormalGrade() {
    return (select(grades)..where((g) => g.name.equals("normal"))).watch();
  }

  Stream<Grade> getEnglishGrade() {
    return (select(grades)..where((g) => g.name.equals("english")))
        .watchSingle();
  }

  Stream<Grade> getGermanGrade() {
    return (select(grades)..where((g) => g.name.equals("german")))
        .watchSingle();
  }

  Stream<List<Grade>> getAllGrades() {
    return select(grades).watch();
  }

  Future<bool> createEnglishCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("english")))
          .getSingle();
      double newGrade = grade.grade * grade.hours +
          entry.grade.value * (entry.hours.value / 2).round();
      int newHours = grade.hours + (entry.hours.value / 2).round();
      await update(grades).replace(
          Grade(name: "english", hours: newHours, grade: newGrade / newHours));
      await into(courses).insert(entry);
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> updateNormalCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("normal")))
          .getSingle();
      Course oldCourse = await (select(courses)
            ..where((c) => c.id.equals(entry.id.value)))
          .getSingle();
      double newGrade =
          (grade.grade * grade.hours - oldCourse.grade * oldCourse.hours);
      int newHours = grade.hours - oldCourse.hours;
      if (newHours > 0) {
        newGrade = newGrade / newHours;
      } else {
        newGrade = 0;
      }
      newGrade = newGrade * newHours + entry.grade.value * entry.hours.value;
      newHours += entry.hours.value;
      await update(grades).replace(
          Grade(name: "normal", hours: newHours, grade: newGrade / newHours));
      await update(courses).replace(entry);
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> updateEnglishCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("english")))
          .getSingle();
      Course oldCourse = await (select(courses)
            ..where((c) => c.id.equals(entry.id.value)))
          .getSingle();
      double newGrade =
          (grade.grade * grade.hours - oldCourse.grade * (oldCourse.hours / 2));
      int newHours = grade.hours - (oldCourse.hours / 2).round();
      if (newHours > 0) {
        newGrade = newGrade / newHours;
      } else {
        newGrade = 0;
      }
      newGrade =
          newGrade * newHours + entry.grade.value * (entry.hours.value / 2);
      newHours += (entry.hours.value / 2).round();
      await update(grades).replace(
          Grade(name: "english", hours: newHours, grade: newGrade / newHours));
      await update(courses).replace(entry);
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> updateGermanCourse(CoursesCompanion entry) {
    return transaction(() async {
      await update(courses).replace(entry);
      List<Course> germanCourses = await (select(courses)
            ..where((c) => c.semester.equals(germanSemesterId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.hours, mode: OrderingMode.desc)
            ]))
          .get();
      for (int i = 0; i < germanCourses.length; i++) {
        if (germanCourses[i].grade != 0) {
          return await update(grades).replace(Grade(
              name: "german",
              hours: germanCourses[i].hours,
              grade: germanCourses[i].grade));
        }
      }
      await update(grades)
          .replace(const Grade(name: "german", hours: 0, grade: 0));
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<int> deleteNormalCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("normal")))
          .getSingle();
      Course oldCourse = await (select(courses)
            ..where((c) => c.id.equals(entry.id.value)))
          .getSingle();
      double newGrade =
          (grade.grade * grade.hours - oldCourse.grade * oldCourse.hours);
      int newHours = grade.hours - oldCourse.hours;
      await update(grades).replace(Grade(
          name: "normal",
          hours: newHours,
          grade: newHours > 0 ? newGrade / newHours : 0));
      return delete(courses).delete(entry);
    });
  }

  Future<int> deleteEnglishCourse(CoursesCompanion entry) {
    return transaction(() async {
      Grade grade = await (select(grades)
            ..where((g) => g.name.equals("english")))
          .getSingle();
      Course oldCourse = await (select(courses)
            ..where((c) => c.id.equals(entry.id.value)))
          .getSingle();
      double newGrade =
          (grade.grade * grade.hours - oldCourse.grade * (oldCourse.hours / 2));
      int newHours = grade.hours - (oldCourse.hours / 2).round();
      await update(grades).replace(Grade(
          name: "english",
          hours: newHours,
          grade: newHours > 0 ? newGrade / newHours : 0));
      return delete(courses).delete(entry);
    });
  }

  Future<void> initSemesters() async {
    englishSemesterId = await into(semesters)
        .insert(SemestersCompanion.insert(name: "English Courses"));
    germanSemesterId =
        await into(semesters).insert(SemestersCompanion.insert(name: "German"));
    await initGermanCourses(germanSemesterId);
    for (int i = 1; i <= 10; i++) {
      await into(semesters)
          .insert(SemestersCompanion.insert(name: "Semester $i"));
      if (i % 2 == 0) {
        await into(semesters).insert(
            SemestersCompanion.insert(name: "Summer ${(i / 2).floor()}"));
      }
    }
    await into(grades).insert(const Grade(name: "german", hours: 0, grade: 0));
    await into(grades).insert(const Grade(name: "english", hours: 0, grade: 0));
    await into(grades).insert(const Grade(name: "normal", hours: 0, grade: 0));
  }

  Future<void> initGermanCourses(int semesterId) async {
    await into(courses).insert(CoursesCompanion.insert(
        name: "German 1", hours: 2, grade: 0, semester: semesterId));
    await into(courses).insert(CoursesCompanion.insert(
        name: "German 2", hours: 4, grade: 0, semester: semesterId));
    await into(courses).insert(CoursesCompanion.insert(
        name: "German 3", hours: 6, grade: 0, semester: semesterId));
    await into(courses).insert(CoursesCompanion.insert(
        name: "German 4", hours: 8, grade: 0, semester: semesterId));
  }

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.drop(semesters);
          await migrator.createTable(semesters);
        }
        if (from == 2) {
          allTables.map((e) async {
            await migrator.drop(e);
            await migrator.createTable(e);
          });
        }
      });
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
