import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

class AccumulativeGpa extends StatefulWidget {
  const AccumulativeGpa({super.key});

  @override
  State<StatefulWidget> createState() => AccumulativeGpaState();
}

class AccumulativeGpaState extends State<AccumulativeGpa> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Utils.getAllCourses(),
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Total GPA: ${Utils.calculateGrade(snapshot.data!).toStringAsFixed(2)} (${Utils.getGrade(Utils.calculateGrade(snapshot.data!))})",
                        style: const TextStyle(fontSize: 24)),
                  ),
                ],
              );
            } else {
              return const Text(" - 0 hours", style: TextStyle(fontSize: 24));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
