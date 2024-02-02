import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/models/grade.dart';

class AccumulativeGpa extends StatelessWidget {
  final Grade total;
  final Grade languages;
  const AccumulativeGpa(
      {super.key, required this.total, required this.languages});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Total GPA: ${total.grade * total.hours}"),
        Text("Languages GPA: ${languages.grade * languages.hours}"),
      ],
    );
  }
}
