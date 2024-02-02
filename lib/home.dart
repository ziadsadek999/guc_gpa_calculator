import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/accumulative_gpa.dart';
import 'package:guc_gpa_calculator/components/semester.dart';
import 'package:guc_gpa_calculator/models/course.dart';
import 'package:guc_gpa_calculator/models/grade.dart';
import 'package:guc_gpa_calculator/models/semester.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  final List<Semester> semesters = [
    Semester(name: "First Semester", courses: [
      for (var i = 0; i < 30; i++)
        Course(name: "Course $i", grade: 0.7, hours: 4)
    ]),
    Semester(name: "Second Semester", courses: []),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GUC GPA Calculator"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: semesters.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return AccumulativeGpa(
                    total: Grade(hours: 4, grade: 0.7),
                    languages: Grade(hours: 4, grade: 0.7));
              }
              return SemesterWidget(semester: semesters[index - 1]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
