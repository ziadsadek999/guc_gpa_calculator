import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/accumulative_gpa.dart';
import 'package:guc_gpa_calculator/components/create_semester.dart';
import 'package:guc_gpa_calculator/components/semester.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';
import 'package:flutter/widgets.dart' as prefix;

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GUC GPA Calculator"),
      ),
      body: Center(
        child: prefix.Column(
          children: [
            const AccumulativeGpa(),
            StreamBuilder(
                stream: Utils.getAllSemesters(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Semester>> snapshot) {
                  if (snapshot.hasData) {
                    return prefix.Column(
                      children: snapshot.data!
                          .map((semester) => SemesterWidget(semester: semester))
                          .toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNewSemesterBottomSheet(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void showNewSemesterBottomSheet(BuildContext ctx) {
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
            child: CreateSemester(),
          );
        },
        isScrollControlled: true);
  }
}
