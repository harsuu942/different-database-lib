
class TaskModel {
  String? taskTitle;
  String? taskDescription;
  String? taskTypes;
  int? subTaskCount;
  String? subTaskTitle;
  String? subTaskDescription;
  int? id;
  String? dataBaseType;

  TaskModel({this.id,this.taskTitle, this.taskDescription, this.taskTypes,
    this.subTaskCount,this.subTaskTitle,this.subTaskDescription,
  this.dataBaseType});
}

