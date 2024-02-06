// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SemestersTable extends Semesters
    with TableInfo<$SemestersTable, Semester> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemestersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semesters';
  @override
  VerificationContext validateIntegrity(Insertable<Semester> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Semester map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Semester(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SemestersTable createAlias(String alias) {
    return $SemestersTable(attachedDatabase, alias);
  }
}

class Semester extends DataClass implements Insertable<Semester> {
  final int id;
  final String name;
  const Semester({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SemestersCompanion toCompanion(bool nullToAbsent) {
    return SemestersCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Semester.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Semester(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Semester copyWith({int? id, String? name}) => Semester(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Semester(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Semester && other.id == this.id && other.name == this.name);
}

class SemestersCompanion extends UpdateCompanion<Semester> {
  final Value<int> id;
  final Value<String> name;
  const SemestersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SemestersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Semester> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SemestersCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return SemestersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemestersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<int> hours = GeneratedColumn<int>(
      'hours', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<double> grade = GeneratedColumn<double>(
      'grade', aliasedName, false,
      check: () =>
          grade.isIn([0, 0.7, 1, 1.3, 1.7, 2, 2.3, 2.7, 3, 3.3, 3.7, 4, 5]),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _semesterMeta =
      const VerificationMeta('semester');
  @override
  late final GeneratedColumn<int> semester = GeneratedColumn<int>(
      'semester', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES semesters (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, hours, grade, semester];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hours')) {
      context.handle(
          _hoursMeta, hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta));
    } else if (isInserting) {
      context.missing(_hoursMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('semester')) {
      context.handle(_semesterMeta,
          semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta));
    } else if (isInserting) {
      context.missing(_semesterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name, semester},
      ];
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      hours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hours'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grade'])!,
      semester: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}semester'])!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String name;
  final int hours;
  final double grade;
  final int semester;
  const Course(
      {required this.id,
      required this.name,
      required this.hours,
      required this.grade,
      required this.semester});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['hours'] = Variable<int>(hours);
    map['grade'] = Variable<double>(grade);
    map['semester'] = Variable<int>(semester);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      name: Value(name),
      hours: Value(hours),
      grade: Value(grade),
      semester: Value(semester),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      hours: serializer.fromJson<int>(json['hours']),
      grade: serializer.fromJson<double>(json['grade']),
      semester: serializer.fromJson<int>(json['semester']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'hours': serializer.toJson<int>(hours),
      'grade': serializer.toJson<double>(grade),
      'semester': serializer.toJson<int>(semester),
    };
  }

  Course copyWith(
          {int? id, String? name, int? hours, double? grade, int? semester}) =>
      Course(
        id: id ?? this.id,
        name: name ?? this.name,
        hours: hours ?? this.hours,
        grade: grade ?? this.grade,
        semester: semester ?? this.semester,
      );
  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('hours: $hours, ')
          ..write('grade: $grade, ')
          ..write('semester: $semester')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, hours, grade, semester);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.name == this.name &&
          other.hours == this.hours &&
          other.grade == this.grade &&
          other.semester == this.semester);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> hours;
  final Value<double> grade;
  final Value<int> semester;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.hours = const Value.absent(),
    this.grade = const Value.absent(),
    this.semester = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int hours,
    required double grade,
    required int semester,
  })  : name = Value(name),
        hours = Value(hours),
        grade = Value(grade),
        semester = Value(semester);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? hours,
    Expression<double>? grade,
    Expression<int>? semester,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (hours != null) 'hours': hours,
      if (grade != null) 'grade': grade,
      if (semester != null) 'semester': semester,
    });
  }

  CoursesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? hours,
      Value<double>? grade,
      Value<int>? semester}) {
    return CoursesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      hours: hours ?? this.hours,
      grade: grade ?? this.grade,
      semester: semester ?? this.semester,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hours.present) {
      map['hours'] = Variable<int>(hours.value);
    }
    if (grade.present) {
      map['grade'] = Variable<double>(grade.value);
    }
    if (semester.present) {
      map['semester'] = Variable<int>(semester.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('hours: $hours, ')
          ..write('grade: $grade, ')
          ..write('semester: $semester')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SemestersTable semesters = $SemestersTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [semesters, courses];
}
