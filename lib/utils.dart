import 'package:guc_gpa_calculator/models/course.dart';
import 'package:guc_gpa_calculator/models/semester.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Utils {
  final database = initDB();

  static Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE semesters(id INTEGER PRIMARY KEY, name TEXT);CREATE TABLE courses(id INTEGER PRIMARY KEY, name TEXT, hours INTEGER, grade NUMERIC);',
        );
      },
      version: 1,
    );
  }

  static String getGrade(double score) {
    if (score < 1) {
      return "A+";
    }
    if (score < 1.3) {
      return "A";
    }
    if (score < 1.7) {
      return "A-";
    }
    if (score < 2) {
      return "B+";
    }
    if (score < 2.3) {
      return "B";
    }
    if (score < 2.7) {
      return "B-";
    }
    if (score < 3) {
      return "C+";
    }
    if (score < 3.3) {
      return "C";
    }
    if (score < 3.7) {
      return "C-";
    }
    if (score < 4) {
      return "D+";
    }
    if (score < 5) {
      return "D";
    }
    return "F";
  }

  Future<void> createSemester(Semester semester) async {
    final db = await database;
    await db.insert(
      'semesters',
      semester.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<List<Semester>> getSemesters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('semesters');
    return List.generate(maps.length, (i) {
      return Semester.fromMap(maps[i]);
    });
  }

  Future<List<Course>> getSemesterCourses(int semesterId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('courses', where: 'semesterId = $semesterId');
    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
  }
}
