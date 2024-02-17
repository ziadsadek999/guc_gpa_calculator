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
        color: const Color.fromARGB(255, 200, 200, 200),
      ),
      child: ExpansionTile(
        collapsedShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        title: SemesterHeader(semester: widget.semester),
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              color: Color.fromARGB(255, 240, 240, 240),
            ),
            child: Column(
              children: [
                StreamBuilder(
                    stream: Utils.getSemesterCourses(widget.semester),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Course>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!
                              .map((course) => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddCourse() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: ElevatedButton(
        onPressed: () {
          showNewCourseBottomSheet(context);
        },
        child: Text(
          "Add Course",
          style: TextStyle(fontSize: const TextScaler.linear(1).scale(20)),
        ),
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
