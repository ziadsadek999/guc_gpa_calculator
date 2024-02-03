class Utils {
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
}
