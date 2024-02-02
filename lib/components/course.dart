// stateless widget with course details

import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/models/course.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({Key? key, required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.name),
      subtitle: Text(course.grade.toString()),
    );
  }
}
