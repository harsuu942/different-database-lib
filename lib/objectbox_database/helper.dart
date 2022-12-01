import 'dart:io';

import 'package:database_types/objectbox_database/objectbox.g.dart';
import 'package:database_types/objectbox_database/object_task_model.dart';


class Helpers {

  late final Store _store;
  late final Box<TaskDetails> _box;

  // Helpers() : _store = Store(getObjectBoxModel()) {
  //   _box = _store.box<TaskDetails>();
  // }

  Helpers._create(this._store) {
    _box = _store.box<TaskDetails>();
  }

  static Future<Helpers> create() async {
    final store = await openStore();
    return Helpers._create(store);
  }

   Future<int> insert(TaskDetails taskDetails) async {
    return _box.put(taskDetails);
  }

   Future<bool> delete(int id) async {
    return _box.remove(id);
  }

   Future<List<TaskDetails>> getTaskDetails() async {
    return _box.getAll();
  }

  Future<int> update(TaskDetails taskDetails) async {
    return _box.put(taskDetails,mode: PutMode.update);
  }

}
