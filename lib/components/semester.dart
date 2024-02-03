import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/course.dart';
import 'package:guc_gpa_calculator/models/semester.dart';

class SemesterWidget extends StatefulWidget {
  final Semester semester;
  const SemesterWidget({super.key, required this.semester});
  @override
  State<SemesterWidget> createState() => _SemesterWidgetState();
}

class _SemesterWidgetState extends State<SemesterWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.semester.name, style: const TextStyle(fontSize: 24)),
      children: [
        for (var course in widget.semester.courses) CourseWidget(course: course)
      ],
    );
  }
}