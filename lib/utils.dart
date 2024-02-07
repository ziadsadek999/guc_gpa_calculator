import 'package:guc_gpa_calculator/database.dart';

class Utils {
  static final db = AppDatabase();
  static String getGrade(double score) {
    if (score == 0) return "N/A";
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

  static Future<int> createNormalCourse(CoursesCompanion entry) {
    return db.createNormalCourse(entry);
  }

  static Future<bool> updateNormalCourse(CoursesCompanion entry) {
    return db.updateNormalCourse(entry);
  }

  static Future<int> createEnglishCourse(CoursesCompanion entry) {
    return db.createEnglishCourse(entry);
  }

  static Future<bool> updateEnglishCourse(CoursesCompanion entry) {
    return db.updateEnglishCourse(entry);
  }

  static Future<bool> updateGermanCourse(CoursesCompanion entry) {
    return db.updateGermanCourse(entry);
  }

  static Stream<List<Semester>> getAllSemesters() {
    return db.getAllSemesters();
  }

  static Future<int> deleteNormalCourse(CoursesCompanion course) {
    return db.deleteNormalCourse(course);
  }

  static Future<int> deleteEnglishCourse(CoursesCompanion course) {
    return db.deleteEnglishCourse(course);
  }

  static Stream<List<Course>> getAllCourses() {
    return db.getAllCourses();
  }

  static Stream<Grade> getNormalGrade() {
    return db.getNormalGrade();
  }

  static Stream<Grade> getEnglishGrade() {
    return db.getEnglishGrade();
  }

  static Stream<Grade> getGermanGrade() {
    return db.getGermanGrade();
  }

  static Stream<List<Grade>> getAllGrades() {
    return db.getAllGrades();
  }

  static double calculateGrade(List<Course> courses) {
    double totalGrade = 0;
    double totalHours = 0;
    for (var course in courses) {
      if (course.grade != 0) {
        totalGrade += course.grade * course.hours;
        totalHours += course.hours;
      }
    }
    if (totalHours == 0) {
      return 0;
    }
    return totalGrade / totalHours;
  }

  static Grade aggregateGrades(List<Grade> grades) {
    double totalGrade = 0;
    double totalHours = 0;
    for (var grade in grades) {
      if (grade.grade != 0) {
        totalGrade += grade.grade * grade.hours;
        totalHours += grade.hours;
      }
    }
    if (totalHours == 0) {
      return const Grade(grade: 0, hours: 0, name: "total");
    }
    return Grade(
        grade: totalGrade / totalHours,
        hours: totalHours.round(),
        name: "total");
  }
}
