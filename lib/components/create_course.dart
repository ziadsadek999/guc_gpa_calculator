import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guc_gpa_calculator/database.dart';
import 'package:guc_gpa_calculator/utils.dart';
import 'package:flutter/material.dart' as prefix;

class CreateCourse extends StatefulWidget {
  final Semester? semester;
  final Course? course;
  const CreateCourse({super.key, this.semester, this.course});
  @override
  State<StatefulWidget> createState() {
    return CreateCourseState();
  }
}

class CreateCourseState extends State<CreateCourse> {
  Map<String, double> gradesMap = {
    "N/A": 0,
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
  bool showNameError = false;
  TextEditingController name = TextEditingController();
  TextEditingController hours = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double grade = 0;
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.course?.name);
    hours = TextEditingController(text: widget.course?.hours.toString());
    grade = widget.course?.grade ?? 0;
    if (!isGerman()) {
      gradesMap.remove("N/A");
    }
  }

  bool isGerman() {
    return (widget.course == null &&
            widget.semester!.id == Utils.db.germanSemesterId) ||
        ((widget.course != null &&
            widget.course!.semester == Utils.db.germanSemesterId));
  }

  bool isEnglish() {
    return (widget.course == null &&
            widget.semester!.id == Utils.db.englishSemesterId) ||
        ((widget.course != null &&
            widget.course!.semester == Utils.db.englishSemesterId));
  }

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
              !isGerman()
                  ? prefix.Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Course Name'),
                            controller: name,
                            onChanged: (_) {
                              setState(() {
                                showNameError = false;
                              });
                            },
                            maxLength: 64,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Add Course Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        showNameError
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    "A course with this name already exists",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error)),
                              )
                            : Container(),
                      ],
                    )
                  : Container(),
              !isGerman()
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*'))
                        ],
                        maxLength: 2,
                        decoration: const InputDecoration(labelText: 'Hours'),
                        keyboardType: TextInputType.number,
                        controller: hours,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Add Course Hours';
                          }
                          if (int.parse(value) == 1) {
                            return 'Courses Cannot Be less than 2 Hour Long';
                          }
                          return null;
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: widget.course != null
                      ? gradesMap.keys.firstWhere(
                          (String key) =>
                              gradesMap[key] == widget.course!.grade,
                        )
                      : null,
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
                  onPressed: () async {
                    bool valid = true;
                    if (_formKey.currentState!.validate()) {
                      if (widget.semester != null) {
                        if (widget.semester!.id == Utils.db.englishSemesterId) {
                          valid =
                              await Utils.createEnglishCourse(CoursesCompanion(
                            name: Value(name.text),
                            hours: Value(int.parse(hours.text)),
                            grade: Value(grade),
                            semester: Value(widget.semester!.id),
                          ));
                        } else {
                          valid =
                              await Utils.createNormalCourse(CoursesCompanion(
                            name: Value(name.text),
                            hours: Value(int.parse(hours.text)),
                            grade: Value(grade),
                            semester: Value(widget.semester!.id),
                          ));
                        }
                      } else {
                        if (widget.course!.semester ==
                            Utils.db.englishSemesterId) {
                          valid = await Utils.updateEnglishCourse(
                            CoursesCompanion(
                                id: Value(widget.course!.id),
                                name: Value(name.text),
                                hours: Value(int.parse(hours.text)),
                                grade: Value(grade),
                                semester: Value(widget.course!.semester)),
                          );
                        } else {
                          if (widget.course!.semester ==
                              Utils.db.germanSemesterId) {
                            valid = await Utils.updateGermanCourse(
                              CoursesCompanion(
                                  id: Value(widget.course!.id),
                                  name: Value(name.text),
                                  hours: Value(int.parse(hours.text)),
                                  grade: Value(grade),
                                  semester: Value(widget.course!.semester)),
                            );
                          } else {
                            valid = await Utils.updateNormalCourse(
                              CoursesCompanion(
                                  id: Value(widget.course!.id),
                                  name: Value(name.text),
                                  hours: Value(int.parse(hours.text)),
                                  grade: Value(grade),
                                  semester: Value(widget.course!.semester)),
                            );
                          }
                        }
                      }
                      if (valid)
                        Navigator.of(context).pop();
                      else {
                        setState(() {
                          showNameError = true;
                        });
                      }
                    }
                  },
                  child: Text(
                    "submit",
                    style: TextStyle(
                        fontSize: const TextScaler.linear(1).scale(20)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
