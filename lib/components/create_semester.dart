import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';

class CreateSemester extends StatefulWidget {
  const CreateSemester({super.key});
  @override
  State<StatefulWidget> createState() {
    return CreateSemesterState();
  }
}

class CreateSemesterState extends State<CreateSemester> {
  final name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                  decoration: const InputDecoration(labelText: 'Semester Name'),
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Add Semester Name';
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
                      Utils.createSemester(SemestersCompanion(
                        name: Value(name.text),
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
