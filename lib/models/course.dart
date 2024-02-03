class Course {
  final int id;
  final String name;
  final int hours;
  final double grade;
  final int semesterId;
  Course(
      {required this.name,
      required this.hours,
      required this.grade,
      required this.semesterId,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hours': hours,
      'grade': grade,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'],
      hours: map['hours'],
      grade: map['grade'],
      semesterId: map['semesterId'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return 'Course{name: $name, hours: $hours, grade: $grade}';
  }
}
