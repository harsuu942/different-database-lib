
import 'package:hive/hive.dart';

import 'hive_task_model.dart';

class HiveHelpers {

  static Future<int> insert(HiveTaskDetails taskDetails) async {
    var hiveBox = await Hive.openBox('task');
    return hiveBox.add(taskDetails);
  }

  static Future<void> delete(int index) async {
    var hiveBox = await Hive.openBox('task');
    return hiveBox.deleteAt(index);
  }

  static Future<List<dynamic>> getTaskDetails() async {
    var hiveBox = await Hive.openBox('task');
    return hiveBox.values.toList();
  }

  static Future<void> update(int index,HiveTaskDetails taskDetails) async {
    var hiveBox = await Hive.openBox('task');
    return hiveBox.putAt(index, taskDetails);
  }
}
