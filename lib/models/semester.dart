import 'package:guc_gpa_calculator/models/course.dart';

class Semester {
  final String name;
  final int id;
  Semester({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'id': id};
  }

  factory Semester.fromMap(Map<String, dynamic> map) {
    return Semester(name: map['name'], id: map['id']);
  }
  @override
  String toString() {
    return 'Semester{name: $name, courses: $id}';
  }
}
