import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/course.dart';
import 'package:guc_gpa_calculator/components/create_course.dart';
import 'package:guc_gpa_calculator/components/semester_header.dart';
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
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        title: SemesterHeader(semester: widget.semester),
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
              }),
          if (widget.semester.id != Utils.db.germanSemesterId)
            _buildAddCourse(),
        ],
      ),
    );
  }

  Widget _buildAddCourse() {
    return ElevatedButton(
      onPressed: () {
        showNewCourseBottomSheet(context);
      },
      child: const Text(
        "Add Course",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void showNewCourseBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (sheetContext) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
            child: CreateCourse(
              semester: widget.semester,
            ),
          );
        },
        isScrollControlled: true);
  }
}
