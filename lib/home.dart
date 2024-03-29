import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/components/accumulative_gpa.dart';
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text("GUC GPA Calculator"),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: AccumulativeGpa(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.567,
              child: StreamBuilder(
                  stream: Utils.getAllSemesters(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Semester>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SemesterWidget(
                              semester: snapshot.data![index]);
                        },
                      );
                    } else {
                      return Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              child: CircularProgressIndicator()));
                    }
                  }),
            )
          ],
        ));
  }
}
