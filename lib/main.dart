import 'package:database_types/details.dart';
import 'package:database_types/drift_database/drift_task_model.dart';
import 'package:database_types/hive_database/hive_helper.dart';
import 'package:database_types/objectbox_database/helper.dart';
import 'package:database_types/objectbox_database/object_task_model.dart';
import 'package:database_types/sqlite_database/sqlite_helper.dart';
import 'package:database_types/sqlite_database/sqlite_task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drift/native.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'hive_database/hive_task_model.dart';


/// Provides access to the ObjectBox Store throughout the app.
late Helpers objectBox;
late Database db;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(HiveTaskDetailsAdapter());
  objectBox = await Helpers.create();
  db = Database();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Types',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Database Types'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var taskPriority = [
    "None",
    "High",
    "Medium",
    "Low",
  ];


  var dataBaseTypes = [
    "ObjectBox",
    "Hive",
    "Sqflite",
    "Drift",
  ];

  String? priority;
  String? databaseSelect;
  final taskTitle = TextEditingController();
  final taskDescription = TextEditingController();
  final subTaskTitle = TextEditingController();
  final subTaskDescription=TextEditingController();
  int? subTask = 0;
  final subTaskCount = TextEditingController();
  int taskId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskId>-1?"Edit task":"Create task"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: <Widget>[
              const SizedBox(height: 20,),
              TextField(
                controller: taskTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Task title',
                ),
              ),
              const SizedBox(height: 10,),
               TextField(
                controller: taskDescription,
                maxLines: 3,
                maxLength: 50,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Task description',
                ),
              ),
              const SizedBox(height: 10,),
              DropdownButtonFormField(
                items: taskPriority.map((String task) {
                  return DropdownMenuItem(
                      value: task,
                      child: Row(
                        children: <Widget>[
                           Icon(Icons.task_alt,color: task=="High"?Colors.red:
                           task=="Medium"?Colors.yellow:
                            task=="Low"?Colors.green:Colors.grey,),
                          const SizedBox(width: 10,),
                          Text(task),
                        ],
                      )
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => priority = newValue);
                },
                value: priority,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Task Priority",),
              ),
              const SizedBox(height: 10,),
                TextField(
                 keyboardType: const TextInputType.numberWithOptions(decimal: true,signed: false),
                  maxLength: 2,
                 controller: subTaskCount,
                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'No.Sub task',
                ),
                onChanged: (String? value){
                   subTask = value!.isEmpty?0:int.parse(value);
                   setState(() { });
                },
              ),
              const SizedBox(height: 10,),
              subTask!>0?TextField(
                controller: subTaskTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Sub task title',
                ),
              ):Container(),
              const SizedBox(height: 10,),
              subTask!>0?TextField(
                controller: subTaskDescription,
                maxLines: 2,
                maxLength: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Sub task description',
                ),
              ):Container(),
              const SizedBox(height: 10,),
              DropdownButtonFormField(
                items: dataBaseTypes.map((String database) {
                  return DropdownMenuItem(
                      value: database,
                      child: Row(
                        children: <Widget>[
                          Text(database),
                        ],
                      )
                  );
                }).toList(),
                onChanged: taskId>-1?null:(String? newValue) {
                  setState(() => databaseSelect = newValue);
                },
                value: databaseSelect,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Database Type",),
              ),

              const SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width-100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16, color: Colors.white))),
                    onPressed: () async {
                      if(taskTitle.text.isNotEmpty &&  taskDescription.text.isNotEmpty
                      && priority!=null && (subTask! <= 0 || (subTask! > 0 &&subTaskTitle.text.isNotEmpty &&  subTaskDescription.text.isNotEmpty))){
                        //Insert different databases
                        if(databaseSelect=="ObjectBox"){
                          taskId>-1?await updateObjectBox():await insertObjectBox();
                        }else if(databaseSelect=="Hive"){
                          taskId>-1?await updateHive():await insertHive();
                        }else if(databaseSelect=="Sqflite"){
                          taskId>-1?await updateSqlite():await insertSqlite();
                        }else{
                          taskId>-1?await updateDrift():await insertDrift();
                        }
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  DetailsPage(database: databaseSelect))).then((value){
                          clearData();
                          if(value!=null){
                            setData(value);
                          }
                        });

                      }else{
                        Fluttertoast.showToast(
                            msg: "Fill the task details",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Text(taskId>-1?'Update':'Submit')),
              ),

              const SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width-100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16, color: Colors.white))),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  DetailsPage(database: ''))).then((value){
                        clearData();
                        if(value!=null){
                          setData(value);
                        }
                      });
                    },
                    child: const Text('Next Page')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearData(){
    taskTitle.clear();
    taskDescription.clear();
    priority=null;
    subTask=0;
    subTaskCount.clear();
    subTaskTitle.clear();
    subTaskDescription.clear();
    databaseSelect=null;
    taskId=-1;
    setState((){});
  }
  void setData(value){
    taskTitle.text = value.taskTitle;
    taskDescription.text = value.taskDescription;
    priority = value.taskTypes;
    subTaskCount.text = value.subTaskCount.toString();
    subTaskTitle.text = value.subTaskTitle;
    subTaskDescription.text = value.subTaskDescription;
    databaseSelect = value.dataBaseType;
    taskId = value.id;
    setState((){});
  }
  insertObjectBox() async{
    var objectBoxData =
    TaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
    subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
    subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text);
    int id = await objectBox.insert(objectBoxData);
    print("inserted an objectBox with $id");
  }

  insertHive() async{
    var hiveData =
    HiveTaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
        subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text);
    int id = await HiveHelpers.insert(hiveData);
    print("inserted an hiveObject with $id");
  }

  insertSqlite() async{
    var sqliteData =
    SQLiteTaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
        subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text);
    SQLiteTaskDetails details = await HelperDatabase.instance.insert(sqliteData);
    print("inserted an sqliteObject with ${details.id}");
  }

  insertDrift() async{

    final driftID = await db.into(db.driftTaskDetails).insert(DriftTaskDetailsCompanion.insert(taskTitle: taskTitle.text,taskDescription: taskDescription.text,
        taskTypes: priority!,
        subTaskCount: subTask!,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text));
    print("inserted an driftObject with $driftID");
  }

  updateObjectBox() async{
    var objectBoxData =
    TaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
        subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text,id: taskId);
    int id = await objectBox.update(objectBoxData);
    print("inserted an objectBox with $id");
  }

  updateHive() async{
    var hiveData =
    HiveTaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
        subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text);
    await HiveHelpers.update(taskId,hiveData);
  }

  updateSqlite() async{
    var sqliteData =
    SQLiteTaskDetails(taskTitle: taskTitle.text,taskDescription: taskDescription.text,taskTypes: priority,
        subTaskCount: subTask,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text,id: taskId);
    SQLiteTaskDetails details = await HelperDatabase.instance.update(sqliteData);
    print("inserted an sqliteObject with ${details.id}");
  }

  updateDrift() async{

    final driftID = await db.update(db.driftTaskDetails)..where((tbl) => tbl.id.equals(taskId))..write(DriftTaskDetailsCompanion.insert(taskTitle: taskTitle.text,taskDescription: taskDescription.text,
        taskTypes: priority!,
        subTaskCount: subTask!,subTaskTitle: subTaskTitle.text.isEmpty?'':subTaskTitle.text,
        subTaskDescription: subTaskDescription.text.isEmpty?'':subTaskDescription.text));
    print("inserted an driftObject with $driftID");
  }
}
