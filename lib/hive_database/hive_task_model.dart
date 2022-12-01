import 'package:hive/hive.dart';

part 'hive_task_model.g.dart';

@HiveType(typeId: 0)
class HiveTaskDetails extends HiveObject {
  @HiveField(0)
  String? taskTitle;
  @HiveField(1)
  String? taskDescription;
  @HiveField(2)
  String? taskTypes;
  @HiveField(3)
  int? subTaskCount;
  @HiveField(4)
  String? subTaskTitle;
  @HiveField(5)
  String? subTaskDescription;

  HiveTaskDetails({this.taskTitle, this.taskDescription, this.taskTypes,
    this.subTaskCount,this.subTaskTitle,this.subTaskDescription});
}
