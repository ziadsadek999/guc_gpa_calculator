// stateless widget with course details

import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/models/course.dart';
import 'package:guc_gpa_calculator/utils.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({Key? key, required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // display course details
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(course.name, style: const TextStyle(fontSize: 16)),
          Text("${course.hours} hours", style: const TextStyle(fontSize: 16)),
          Text("${course.grade} (${Utils.getGrade(course.grade)})",
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
