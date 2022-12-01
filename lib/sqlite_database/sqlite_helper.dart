import 'package:database_types/sqlite_database/sqlite_task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HelperDatabase {
  static final HelperDatabase instance = HelperDatabase._init();

  static Database? _database;

  HelperDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Task (id INTEGER PRIMARY KEY AUTOINCREMENT, taskTitle TEXT, taskDescription TEXT, taskTypes TEXT, subTaskCount INTEGER, subTaskTitle TEXT, subTaskDescription TEXT)');
  }

  Future<SQLiteTaskDetails> insert(SQLiteTaskDetails taskDetails) async {
    final db = await instance.database;

    taskDetails.id = await db.insert('Task', taskDetails.toJson());
    return taskDetails;
  }


  Future<List<SQLiteTaskDetails>> readAllTasks() async {
    final db = await instance.database;

     final result =
         await db.rawQuery('SELECT * FROM Task');

    return result.isNotEmpty?result.map((json) => SQLiteTaskDetails.fromJson(json)).toList():[];
  }


  Future<int> delete(int taskId) async {
    final db = await instance.database;

    return await db.delete(
      'Task',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<SQLiteTaskDetails> update(SQLiteTaskDetails taskDetails) async {
    final db = await instance.database;

    taskDetails.id = await db.update('Task', taskDetails.toJson(),
        where: 'id = ?', whereArgs: [taskDetails.id]);
    return taskDetails;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}