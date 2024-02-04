import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/create_course.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({Key? key, required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(course.name, style: const TextStyle(fontSize: 16)),
          Text("${course.hours} hours", style: const TextStyle(fontSize: 16)),
          Text("${course.grade} (${Utils.getGrade(course.grade)})",
              style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showEditCourseBottomSheet(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDeleteConfirmationDialog(context);
                },
              ),
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
        title: const Text("Are you sure?"),
        content: const Text("Do you want to delete this course?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Utils.deleteCourse(CoursesCompanion(id: Value(course.id)));
              Navigator.of(ctx).pop();
            },
            child: const Text("Yes"),
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
