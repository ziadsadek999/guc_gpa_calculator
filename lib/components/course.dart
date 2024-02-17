import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/create_course.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';
import 'package:flutter/material.dart' as prefix;

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({Key? key, required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fontSize = const TextScaler.linear(1).scale(16);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: prefix.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                    "${course.hours} hours - ${course.grade} (${Utils.getGrade(course.grade)})",
                    style: TextStyle(fontSize: fontSize)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showEditCourseBottomSheet(context);
                },
              ),
              !course.name.contains("German")
                  ? IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        showDeleteConfirmationDialog(context);
                      },
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Are you sure?",
          style: TextStyle(fontSize: const TextScaler.linear(1).scale(24)),
        ),
        content: Text("Do you want to delete this course?",
            style: TextStyle(fontSize: const TextScaler.linear(1).scale(16))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              "No",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: const TextScaler.linear(1).scale(16)),
            ),
          ),
          TextButton(
            onPressed: () {
              if (course.semester == Utils.db.englishSemesterId) {
                Utils.deleteEnglishCourse(
                    CoursesCompanion(id: Value(course.id)));
              } else {
                Utils.deleteNormalCourse(
                    CoursesCompanion(id: Value(course.id)));
              }
              Navigator.of(ctx).pop();
            },
            child: Text(
              "Yes",
              style: TextStyle(fontSize: const TextScaler.linear(1).scale(16)),
            ),
          ),
        ],
      ),
    );
  }

  void showEditCourseBottomSheet(BuildContext ctx) {
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
              course: course,
            ),
          );
        },
        isScrollControlled: true);
  }
}
