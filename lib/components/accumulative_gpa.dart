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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          StreamBuilder(
              stream: Utils.getNormalGrade(),
              builder: (BuildContext context, AsyncSnapshot<Grade> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "GPA Excluding Languages: ${(snapshot.data!.grade).toStringAsFixed(2)} (${Utils.getGrade(snapshot.data!.grade)})",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          24)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${(snapshot.data!.hours)} hours",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          24)),
                        ),
                      ],
                    ),
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
                  return Container(
                    margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "GPA Including Languages: ${(total.grade).toStringAsFixed(2)} (${Utils.getGrade(total.grade)})",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          24)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${(total.hours)} hours",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          24)),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
