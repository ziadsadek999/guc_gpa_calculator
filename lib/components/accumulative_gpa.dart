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
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        children: [
          _buildAccGPACard("Accumulative GPA", Utils.getAllGrades()),
          _buildAccGPACard("GPA Excluding Languages", Utils.getNormalGrade()),
        ],
      ),
    );
  }

  Widget _buildAccGPACard(String msg, Stream<List<Grade>> stream) {
    double fontSize = const TextScaler.linear(1).scale(24);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.16,
      child: StreamBuilder(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
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
                      padding: const EdgeInsets.all(8),
                      child:
                          Text("$msg:", style: TextStyle(fontSize: fontSize)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          "${(total.grade).toStringAsFixed(2)} (${Utils.getGrade(total.grade)}), ${(total.hours)} hours",
                          style: TextStyle(fontSize: fontSize)),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
