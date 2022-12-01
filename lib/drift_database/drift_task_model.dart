import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'drift_task_model.g.dart';


@DataClassName('Tasks')
class DriftTaskDetails extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskTitle => text()();
  TextColumn get taskDescription => text()();
  TextColumn get taskTypes => text()();
  IntColumn get subTaskCount => integer()();
  TextColumn get subTaskTitle => text()();
  TextColumn get subTaskDescription => text()();
  }

  abstract class DriftTaskView extends View{
    DriftTaskDetails get taskDetails;

  @override
  Query as() => select([
    taskDetails.id
  ]).from(taskDetails);
  }

  @DriftDatabase(tables:[
    DriftTaskDetails
  ], views:[
    DriftTaskView
  ])

  class Database extends _$Database {
    Database() : super(_openConnection());


    @override
    int get schemaVersion => 1;
  }

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'task.db'));
    return NativeDatabase(file);
  });
}


