
class SQLiteTaskDetails {
  String? taskTitle;
  String? taskDescription;
  String? taskTypes;
  int? subTaskCount;
  String? subTaskTitle;
  String? subTaskDescription;
  int? id;

  SQLiteTaskDetails({this.id=0,this.taskTitle, this.taskDescription, this.taskTypes,
    this.subTaskCount,this.subTaskTitle,this.subTaskDescription});

  SQLiteTaskDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['taskTitle'];
    taskDescription = json['taskDescription'];
    taskTypes = json['taskTypes'];
    subTaskCount = json['subTaskCount'];
    subTaskTitle = json['subTaskTitle'];
    subTaskDescription = json['subTaskDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   // data['id'] = id;
    data['taskTitle'] = taskTitle;
    data['taskDescription'] = taskDescription;
    data['taskTypes'] = taskTypes;
    data['subTaskCount'] = subTaskCount;
    data['subTaskTitle'] = subTaskTitle;
    data['subTaskDescription'] = subTaskDescription;
    return data;
  }
}
