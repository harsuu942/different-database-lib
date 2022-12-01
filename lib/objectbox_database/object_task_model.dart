import 'package:objectbox/objectbox.dart';


@Entity()
class TaskDetails {
  String? taskTitle;
  String? taskDescription;
  String? taskTypes;
  int? subTaskCount;
  String? subTaskTitle;
  String? subTaskDescription;
  int id;

  TaskDetails({this.id=0,this.taskTitle, this.taskDescription, this.taskTypes,
  this.subTaskCount,this.subTaskTitle,this.subTaskDescription});
}


