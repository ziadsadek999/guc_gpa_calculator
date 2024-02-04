import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';
import 'package:flutter/widgets.dart' as prefix;
import 'package:flutter/material.dart';

class CreateSemester extends StatefulWidget {
  const CreateSemester({super.key});

  @override
  CreateSemesterState createState() {
    return CreateSemesterState();
  }
}

class CreateSemesterState extends State<CreateSemester> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: prefix.Column(children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Semester Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a name";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await Utils.createSemester(SemestersCompanion(
                    name: Value<String>(_nameController.text)));
                Navigator.pop(context);
              }
            },
            child: const Text("Create"),
          )
        ]));
  }
}
