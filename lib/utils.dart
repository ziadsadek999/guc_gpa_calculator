import 'package:guc_gpa_calculator/database.dart';

class Utils {
  static final db = AppDatabase();
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

  static Stream<List<Course>> getSemesterCourses(Semester semester) {
    return db.getSemesterCourses(semester);
  }

  static Future<int> createSemester(SemestersCompanion entry) {
    return db.createSemester(entry);
  }

  static Future<int> createCourse(CoursesCompanion entry) {
    return db.createCourse(entry);
  }

  static Future<bool> updateCourse(CoursesCompanion entry) {
    return db.updateCourse(entry);
  }

  static Stream<List<Semester>> getAllSemesters() {
    return db.getAllSemesters();
  }

  static Future<int> deleteCourse(CoursesCompanion course) {
    return db.deleteCourse(course);
  }

  static Stream<List<Course>> getAllCourses() {
    return db.getAllCourses();
  }

  static double calculateGrade(List<Course> courses) {
    double totalGrade = 0;
    double totalHours = 0;
    for (var course in courses) {
      totalGrade += course.grade * course.hours;
      totalHours += course.hours;
    }
    return totalGrade / totalHours;
  }
}
