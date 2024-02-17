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
    final fontSize = const TextScaler.linear(1).scale(16);
    final bigFontSize = const TextScaler.linear(1).scale(20);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.semester.name,
          style: TextStyle(fontSize: bigFontSize, fontWeight: FontWeight.bold)),
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
                return Text("0 hours", style: TextStyle(fontSize: fontSize));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ]);
  }

  Widget _buildGermanHeader(AsyncSnapshot<List<Course>> snapshot) {
    final fontSize = const TextScaler.linear(1).scale(16);
    return Row(children: [
      Text(
          "${Utils.calculateGermanGrade(snapshot.data!).toStringAsFixed(2)} (${Utils.getGrade(Utils.calculateGrade(snapshot.data!))}) - ${Utils.getGermanLevel(snapshot.data!)}",
          style: TextStyle(fontSize: fontSize)),
    ]);
  }

  Widget _buildNormalHeader(AsyncSnapshot<List<Course>> snapshot) {
    final fontSize = const TextScaler.linear(1).scale(16);
    return Row(children: [
      Text(
          "${snapshot.data!.map((e) => e.hours).reduce((a, b) => a + b)} hours",
          style: TextStyle(fontSize: fontSize)),
      Text(
          " - ${Utils.calculateGrade(snapshot.data!).toStringAsFixed(2)} (${Utils.getGrade(Utils.calculateGrade(snapshot.data!))})",
          style: TextStyle(fontSize: fontSize)),
    ]);
  }
}
