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
    return Column(
      children: [
        StreamBuilder(
            stream: Utils.getNormalGrade(),
            builder: (BuildContext context, AsyncSnapshot<Grade> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Total GPA Excluding Languages: ${(snapshot.data!.grade).toStringAsFixed(2)} (${Utils.getGrade(snapshot.data!.grade)})",
                          style: const TextStyle(fontSize: 24)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Total Hours Excluding Languages: ${(snapshot.data!.hours)}",
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        StreamBuilder(
            stream: Utils.getAllGrades(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                Grade total = Utils.aggregateGrades(snapshot.data!);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Total GPA Including Languages: ${(total.grade).toStringAsFixed(2)} (${Utils.getGrade(total.grade)})",
                          style: const TextStyle(fontSize: 24)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Total Hours Including Languages: ${(total.hours)}",
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}
