// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_task_model.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DriftTaskDetail extends DataClass implements Insertable<DriftTaskDetail> {
  final int id;
  final String taskTitle;
  final String taskDescription;
  final String taskTypes;
  final int subTaskCount;
  final String subTaskTitle;
  final String subTaskDescription;
  DriftTaskDetail(
      {required this.id,
      required this.taskTitle,
      required this.taskDescription,
      required this.taskTypes,
      required this.subTaskCount,
      required this.subTaskTitle,
      required this.subTaskDescription});
  factory DriftTaskDetail.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DriftTaskDetail(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      taskTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_title'])!,
      taskDescription: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_description'])!,
      taskTypes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_types'])!,
      subTaskCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_task_count'])!,
      subTaskTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_task_title'])!,
      subTaskDescription: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sub_task_description'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_title'] = Variable<String>(taskTitle);
    map['task_description'] = Variable<String>(taskDescription);
    map['task_types'] = Variable<String>(taskTypes);
    map['sub_task_count'] = Variable<int>(subTaskCount);
    map['sub_task_title'] = Variable<String>(subTaskTitle);
    map['sub_task_description'] = Variable<String>(subTaskDescription);
    return map;
  }

  DriftTaskDetailsCompanion toCompanion(bool nullToAbsent) {
    return DriftTaskDetailsCompanion(
      id: Value(id),
      taskTitle: Value(taskTitle),
      taskDescription: Value(taskDescription),
      taskTypes: Value(taskTypes),
      subTaskCount: Value(subTaskCount),
      subTaskTitle: Value(subTaskTitle),
      subTaskDescription: Value(subTaskDescription),
    );
  }

  factory DriftTaskDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftTaskDetail(
      id: serializer.fromJson<int>(json['id']),
      taskTitle: serializer.fromJson<String>(json['taskTitle']),
      taskDescription: serializer.fromJson<String>(json['taskDescription']),
      taskTypes: serializer.fromJson<String>(json['taskTypes']),
      subTaskCount: serializer.fromJson<int>(json['subTaskCount']),
      subTaskTitle: serializer.fromJson<String>(json['subTaskTitle']),
      subTaskDescription:
          serializer.fromJson<String>(json['subTaskDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskTitle': serializer.toJson<String>(taskTitle),
      'taskDescription': serializer.toJson<String>(taskDescription),
      'taskTypes': serializer.toJson<String>(taskTypes),
      'subTaskCount': serializer.toJson<int>(subTaskCount),
      'subTaskTitle': serializer.toJson<String>(subTaskTitle),
      'subTaskDescription': serializer.toJson<String>(subTaskDescription),
    };
  }

  DriftTaskDetail copyWith(
          {int? id,
          String? taskTitle,
          String? taskDescription,
          String? taskTypes,
          int? subTaskCount,
          String? subTaskTitle,
          String? subTaskDescription}) =>
      DriftTaskDetail(
        id: id ?? this.id,
        taskTitle: taskTitle ?? this.taskTitle,
        taskDescription: taskDescription ?? this.taskDescription,
        taskTypes: taskTypes ?? this.taskTypes,
        subTaskCount: subTaskCount ?? this.subTaskCount,
        subTaskTitle: subTaskTitle ?? this.subTaskTitle,
        subTaskDescription: subTaskDescription ?? this.subTaskDescription,
      );
  @override
  String toString() {
    return (StringBuffer('DriftTaskDetail(')
          ..write('id: $id, ')
          ..write('taskTitle: $taskTitle, ')
          ..write('taskDescription: $taskDescription, ')
          ..write('taskTypes: $taskTypes, ')
          ..write('subTaskCount: $subTaskCount, ')
          ..write('subTaskTitle: $subTaskTitle, ')
          ..write('subTaskDescription: $subTaskDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskTitle, taskDescription, taskTypes,
      subTaskCount, subTaskTitle, subTaskDescription);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftTaskDetail &&
          other.id == this.id &&
          other.taskTitle == this.taskTitle &&
          other.taskDescription == this.taskDescription &&
          other.taskTypes == this.taskTypes &&
          other.subTaskCount == this.subTaskCount &&
          other.subTaskTitle == this.subTaskTitle &&
          other.subTaskDescription == this.subTaskDescription);
}

class DriftTaskDetailsCompanion extends UpdateCompanion<DriftTaskDetail> {
  final Value<int> id;
  final Value<String> taskTitle;
  final Value<String> taskDescription;
  final Value<String> taskTypes;
  final Value<int> subTaskCount;
  final Value<String> subTaskTitle;
  final Value<String> subTaskDescription;
  const DriftTaskDetailsCompanion({
    this.id = const Value.absent(),
    this.taskTitle = const Value.absent(),
    this.taskDescription = const Value.absent(),
    this.taskTypes = const Value.absent(),
    this.subTaskCount = const Value.absent(),
    this.subTaskTitle = const Value.absent(),
    this.subTaskDescription = const Value.absent(),
  });
  DriftTaskDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String taskTitle,
    required String taskDescription,
    required String taskTypes,
    required int subTaskCount,
    required String subTaskTitle,
    required String subTaskDescription,
  })  : taskTitle = Value(taskTitle),
        taskDescription = Value(taskDescription),
        taskTypes = Value(taskTypes),
        subTaskCount = Value(subTaskCount),
        subTaskTitle = Value(subTaskTitle),
        subTaskDescription = Value(subTaskDescription);
  static Insertable<DriftTaskDetail> custom({
    Expression<int>? id,
    Expression<String>? taskTitle,
    Expression<String>? taskDescription,
    Expression<String>? taskTypes,
    Expression<int>? subTaskCount,
    Expression<String>? subTaskTitle,
    Expression<String>? subTaskDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskTitle != null) 'task_title': taskTitle,
      if (taskDescription != null) 'task_description': taskDescription,
      if (taskTypes != null) 'task_types': taskTypes,
      if (subTaskCount != null) 'sub_task_count': subTaskCount,
      if (subTaskTitle != null) 'sub_task_title': subTaskTitle,
      if (subTaskDescription != null)
        'sub_task_description': subTaskDescription,
    });
  }

  DriftTaskDetailsCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskTitle,
      Value<String>? taskDescription,
      Value<String>? taskTypes,
      Value<int>? subTaskCount,
      Value<String>? subTaskTitle,
      Value<String>? subTaskDescription}) {
    return DriftTaskDetailsCompanion(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      taskTypes: taskTypes ?? this.taskTypes,
      subTaskCount: subTaskCount ?? this.subTaskCount,
      subTaskTitle: subTaskTitle ?? this.subTaskTitle,
      subTaskDescription: subTaskDescription ?? this.subTaskDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskTitle.present) {
      map['task_title'] = Variable<String>(taskTitle.value);
    }
    if (taskDescription.present) {
      map['task_description'] = Variable<String>(taskDescription.value);
    }
    if (taskTypes.present) {
      map['task_types'] = Variable<String>(taskTypes.value);
    }
    if (subTaskCount.present) {
      map['sub_task_count'] = Variable<int>(subTaskCount.value);
    }
    if (subTaskTitle.present) {
      map['sub_task_title'] = Variable<String>(subTaskTitle.value);
    }
    if (subTaskDescription.present) {
      map['sub_task_description'] = Variable<String>(subTaskDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftTaskDetailsCompanion(')
          ..write('id: $id, ')
          ..write('taskTitle: $taskTitle, ')
          ..write('taskDescription: $taskDescription, ')
          ..write('taskTypes: $taskTypes, ')
          ..write('subTaskCount: $subTaskCount, ')
          ..write('subTaskTitle: $subTaskTitle, ')
          ..write('subTaskDescription: $subTaskDescription')
          ..write(')'))
        .toString();
  }
}

class $DriftTaskDetailsTable extends DriftTaskDetails
    with TableInfo<$DriftTaskDetailsTable, DriftTaskDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftTaskDetailsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _taskTitleMeta = const VerificationMeta('taskTitle');
  @override
  late final GeneratedColumn<String?> taskTitle = GeneratedColumn<String?>(
      'task_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _taskDescriptionMeta =
      const VerificationMeta('taskDescription');
  @override
  late final GeneratedColumn<String?> taskDescription =
      GeneratedColumn<String?>('task_description', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _taskTypesMeta = const VerificationMeta('taskTypes');
  @override
  late final GeneratedColumn<String?> taskTypes = GeneratedColumn<String?>(
      'task_types', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _subTaskCountMeta =
      const VerificationMeta('subTaskCount');
  @override
  late final GeneratedColumn<int?> subTaskCount = GeneratedColumn<int?>(
      'sub_task_count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _subTaskTitleMeta =
      const VerificationMeta('subTaskTitle');
  @override
  late final GeneratedColumn<String?> subTaskTitle = GeneratedColumn<String?>(
      'sub_task_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _subTaskDescriptionMeta =
      const VerificationMeta('subTaskDescription');
  @override
  late final GeneratedColumn<String?> subTaskDescription =
      GeneratedColumn<String?>('sub_task_description', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskTitle,
        taskDescription,
        taskTypes,
        subTaskCount,
        subTaskTitle,
        subTaskDescription
      ];
  @override
  String get aliasedName => _alias ?? 'drift_task_details';
  @override
  String get actualTableName => 'drift_task_details';
  @override
  VerificationContext validateIntegrity(Insertable<DriftTaskDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_title')) {
      context.handle(_taskTitleMeta,
          taskTitle.isAcceptableOrUnknown(data['task_title']!, _taskTitleMeta));
    } else if (isInserting) {
      context.missing(_taskTitleMeta);
    }
    if (data.containsKey('task_description')) {
      context.handle(
          _taskDescriptionMeta,
          taskDescription.isAcceptableOrUnknown(
              data['task_description']!, _taskDescriptionMeta));
    } else if (isInserting) {
      context.missing(_taskDescriptionMeta);
    }
    if (data.containsKey('task_types')) {
      context.handle(_taskTypesMeta,
          taskTypes.isAcceptableOrUnknown(data['task_types']!, _taskTypesMeta));
    } else if (isInserting) {
      context.missing(_taskTypesMeta);
    }
    if (data.containsKey('sub_task_count')) {
      context.handle(
          _subTaskCountMeta,
          subTaskCount.isAcceptableOrUnknown(
              data['sub_task_count']!, _subTaskCountMeta));
    } else if (isInserting) {
      context.missing(_subTaskCountMeta);
    }
    if (data.containsKey('sub_task_title')) {
      context.handle(
          _subTaskTitleMeta,
          subTaskTitle.isAcceptableOrUnknown(
              data['sub_task_title']!, _subTaskTitleMeta));
    } else if (isInserting) {
      context.missing(_subTaskTitleMeta);
    }
    if (data.containsKey('sub_task_description')) {
      context.handle(
          _subTaskDescriptionMeta,
          subTaskDescription.isAcceptableOrUnknown(
              data['sub_task_description']!, _subTaskDescriptionMeta));
    } else if (isInserting) {
      context.missing(_subTaskDescriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftTaskDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DriftTaskDetail.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DriftTaskDetailsTable createAlias(String alias) {
    return $DriftTaskDetailsTable(attachedDatabase, alias);
  }
}

class DriftTaskViewData extends DataClass {
  final int id;
  DriftTaskViewData({required this.id});
  factory DriftTaskViewData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DriftTaskViewData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  factory DriftTaskViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftTaskViewData(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  DriftTaskViewData copyWith({int? id}) => DriftTaskViewData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('DriftTaskViewData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftTaskViewData && other.id == this.id);
}

class $DriftTaskViewView extends ViewInfo<$DriftTaskViewView, DriftTaskViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $DriftTaskViewView(this.attachedDatabase, [this._alias]);
  $DriftTaskDetailsTable get taskDetails =>
      attachedDatabase.driftTaskDetails.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [taskDetails.id];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'drift_task_view';
  @override
  String? get createViewStmt => null;
  @override
  $DriftTaskViewView get asDslTable => this;
  @override
  DriftTaskViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DriftTaskViewData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  late final GeneratedColumn<int?> id =
      GeneratedColumn<int?>('id', aliasedName, false, type: const IntType());
  @override
  $DriftTaskViewView createAlias(String alias) {
    return $DriftTaskViewView(attachedDatabase, alias);
  }

  @override
  Query? get query => (attachedDatabase.selectOnly(taskDetails,
      includeJoinedTableColumns: false)
    ..addColumns($columns));
  @override
  Set<String> get readTables => const {'drift_task_details'};
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DriftTaskDetailsTable driftTaskDetails =
      $DriftTaskDetailsTable(this);
  late final $DriftTaskViewView driftTaskView = $DriftTaskViewView(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [driftTaskDetails, driftTaskView];
}
