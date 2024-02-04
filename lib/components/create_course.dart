import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

class CreateCourse extends StatefulWidget {
  final Semester semester;
  const CreateCourse({super.key, required this.semester});
  @override
  State<StatefulWidget> createState() {
    return CreateCourseState();
  }
}

class CreateCourseState extends State<CreateCourse> {
  Map<String, double> gradesMap = {
    "A+": 0.7,
    "A": 1,
    "A-": 1.3,
    "B+": 1.7,
    "B": 2,
    "B-": 2.3,
    "C+": 2.7,
    "C": 3,
    "C-": 3.3,
    "D+": 3.7,
    "D": 4,
    "F": 5
  };
  final name = TextEditingController();
  final hours = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double grade = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom +
              (MediaQuery.of(context).orientation == Orientation.portrait
                  ? 20
                  : 0),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Course Name'),
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Add Course Name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Hours'),
                  keyboardType: TextInputType.number,
                  controller: hours,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Add Course Hours';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: MediaQuery.of(context).size.height / 4,
                  decoration: const InputDecoration(labelText: 'Grade'),
                  items: gradesMap.keys
                      .map((String grade) => DropdownMenuItem<String>(
                            value: grade,
                            child: Text(grade),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      grade = gradesMap[value!]!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Add Course Grade';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Utils.createCourse(CoursesCompanion(
                        name: Value(name.text),
                        hours: Value(int.parse(hours.text)),
                        grade: Value(grade),
                        semester: Value(widget.semester.id),
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "submit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
