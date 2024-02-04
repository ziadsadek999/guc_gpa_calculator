import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/course.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

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
        StreamBuilder(
            stream: Utils.getSemesterCourses(widget.semester),
            builder:
                (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!
                      .map((course) => Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: CourseWidget(course: course),
                          ))
                      .toList(),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}
