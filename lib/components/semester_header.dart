import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

class SemesterHeader extends StatefulWidget {
  final Semester semester;
  const SemesterHeader({super.key, required this.semester});

  @override
  State<SemesterHeader> createState() => SemesterHeaderState();
}

class SemesterHeaderState extends State<SemesterHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widget.semester.name, style: const TextStyle(fontSize: 24)),
      StreamBuilder(
          stream: Utils.getSemesterCourses(widget.semester),
          builder:
              (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                if (widget.semester.name == "German") {
                  return _buildGermanHeader(snapshot);
                }
                return _buildNormalHeader(snapshot);
              } else {
                return const Text(" - 0 hours", style: TextStyle(fontSize: 14));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ]);
  }

  Widget _buildGermanHeader(AsyncSnapshot<List<Course>> snapshot) {
    return Row(children: [
      Text(
          " - ${Utils.calculateGrade(snapshot.data!).toStringAsFixed(2)} (${Utils.getGrade(Utils.calculateGrade(snapshot.data!))})",
          style: const TextStyle(fontSize: 14)),
    ]);
  }

  Widget _buildNormalHeader(AsyncSnapshot<List<Course>> snapshot) {
    return Row(children: [
      Text(
          " - ${snapshot.data!.map((e) => e.hours).reduce((a, b) => a + b)} hours",
          style: const TextStyle(fontSize: 14)),
      Text(
          " - ${Utils.calculateGrade(snapshot.data!).toStringAsFixed(2)} (${Utils.getGrade(Utils.calculateGrade(snapshot.data!))})",
          style: const TextStyle(fontSize: 14)),
    ]);
  }
}
