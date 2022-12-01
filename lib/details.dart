
import 'package:database_types/hive_database/hive_helper.dart';
import 'package:database_types/hive_database/hive_task_model.dart';
import 'package:database_types/sqlite_database/sqlite_helper.dart';
import 'package:database_types/sqlite_database/sqlite_task_model.dart';
import 'package:database_types/task_detail.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drift_database/drift_task_model.dart';
import 'main.dart';
import 'objectbox_database/helper.dart';
import 'objectbox_database/object_task_model.dart';

class DetailsPage extends StatefulWidget {
  String? database;

  DetailsPage({this.database});


  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  List<TaskDetails> objectBoxDetails=[];
  List<SQLiteTaskDetails> sqliteDetails=[];
  List<HiveTaskDetails> hiveDetails=[];
  List<DriftTaskDetail> driftDetails=[];
  bool isFromObject= false;
  bool isFromSqlite=false;
  bool isFromDrift=false;
  bool isFromHive=false;


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(widget.database!.isEmpty){
        resetMenu(true,false,false,false);
      }else {
        resetMenu(widget.database == "ObjectBox" ? true : false,
            widget.database == "Hive" ? true : false,
            widget.database == "Sqflite" ? true : false,
            widget.database == "Drift" ? true : false);
      }
      widget.database == "Drift"?gettingDriftData():
      widget.database == "Hive"?gettingHiveData():
      widget.database == "Sqflite"?gettingSqliteData():gettingBoxData();
    });
  }

  gettingHiveData() async{
    hiveDetails = [];
    resetMenu(false,true,false,false);
    final dynamic = await HiveHelpers.getTaskDetails();
    dynamic.forEach((element) {
      hiveDetails.add(element);
    });
   // hiveDetails.addAll();
    setState((){});
  }

  gettingSqliteData() async{
    resetMenu(false,false,true,false);
    sqliteDetails = await HelperDatabase.instance.readAllTasks();
    setState((){});
  }

  gettingDriftData() async{
    resetMenu(false,false,false,true);
    driftDetails = await db.select(db.driftTaskDetails).get();
    setState((){});
  }

  gettingBoxData() async{
    resetMenu(true,false,false,false);
    objectBoxDetails = await objectBox.getTaskDetails();
    setState((){});
  }

  resetMenu(bool isObjectBox,bool isHive,bool isSqlite,bool isDrift){
    isFromObject = isObjectBox;
    isFromHive = isHive;
    isFromSqlite = isSqlite;
    isFromDrift = isDrift;
  }

  deleteObjectBox(int index) async{
    bool delete = await objectBox.delete(objectBoxDetails[index].id);
    if(delete){
      objectBoxDetails.removeAt(index);
      setState((){});
    }
  }
  deleteHive(int index) async{
    await HiveHelpers.delete(index);
    hiveDetails.removeAt(index);
    setState((){});
  }
  deleteSqlite(int index) async{
    int id = await HelperDatabase.instance.delete(sqliteDetails[index].id!);
    if(id>0){
      sqliteDetails.removeAt(index);
      setState((){});
    }
  }
  Future<int> deleteDrift(int index) async{
    int id = await (db.delete(db.driftTaskDetails)..where((tbl) =>  tbl.id.equals(driftDetails[index].id))).go();
    if(id>0){
      driftDetails.removeAt(index);
      setState((){});
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Tasks"),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).pop();
        },),
        actions: [
          PopupMenuButton(
              itemBuilder: (context){
                return [
                   PopupMenuItem<int>(
                    value: 0,
                    child: Text("ObjectBox",style: TextStyle(color: isFromObject?Colors.redAccent:Colors.black),),
                  ),

                   PopupMenuItem<int>(
                    value: 1,
                    child: Text("Hive",style: TextStyle(color: isFromHive?Colors.redAccent:Colors.black),),
                  ),

                   PopupMenuItem<int>(
                    value: 2,
                    child: Text("Sqflite",style: TextStyle(color: isFromSqlite?Colors.redAccent:Colors.black),),
                  ),
                   PopupMenuItem<int>(
                    value: 3,
                    child: Text("Drift",style: TextStyle(color: isFromDrift?Colors.redAccent:Colors.black),),
                  ),

                ];
              },
              onSelected:(value){
                if(value == 0){
                  gettingBoxData();
                }else if(value == 1){
                  gettingHiveData();
                }else if(value == 2){
                  gettingSqliteData();
                }else{
                  gettingDriftData();
                }
              }
          ),
        ],),
      body: checkingData()?ListView.builder(
        itemBuilder: (BuildContext context,int index){
          return Card(
            color: setCardColor(index),
            child: ListTile(
              onTap: (){

                Navigator.pop(context,passData(index));
              },
              trailing: IconButton(icon: const Icon(Icons.delete),onPressed: () async {
                if(isFromObject){
                  await deleteObjectBox(index);
                }
                if(isFromHive){
                  await deleteHive(index);
                }
                if(isFromSqlite){
                  await deleteSqlite(index);
                }
                if(isFromDrift){
                  await deleteDrift(index);
                }
              },),
              title: Text(
                  isFromObject?objectBoxDetails[index].taskTitle!:
                  isFromHive?hiveDetails[index].taskTitle!:
                  isFromSqlite?sqliteDetails[index].taskTitle!:
                      driftDetails[index].taskTitle,style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  isFromObject?objectBoxDetails[index].taskDescription!:
                  isFromHive?hiveDetails[index].taskDescription!:
                  isFromSqlite?sqliteDetails[index].taskDescription!:
                  driftDetails[index].taskDescription
              ),
            ),);
        },
        itemCount: isFromObject?
        objectBoxDetails.length:isFromHive?hiveDetails.length:
        isFromSqlite?sqliteDetails.length:driftDetails.length,
      ):Center(
        child: Text("No tasks save in ${isFromObject?"ObjectBox":isFromHive?"Hive":isFromSqlite?"Sqlite":"Drift"} database"),
      ),
    );
  }

  Color setCardColor(int index){
    if(isFromObject){
      if(objectBoxDetails[index].taskTypes=="High"){
        return Colors.red;
      }else if(objectBoxDetails[index].taskTypes=="Medium"){
        return Colors.yellow;
      }else if(objectBoxDetails[index].taskTypes=="Low"){
        return Colors.green;
      }else{
        return Colors.grey;
      }
    }else if(isFromHive){
      if(hiveDetails[index].taskTypes=="High"){
        return Colors.red;
      }else if(hiveDetails[index].taskTypes=="Medium"){
        return Colors.yellow;
      }else if(hiveDetails[index].taskTypes=="Low"){
        return Colors.green;
      }else{
        return Colors.grey;
      }
    }else if(isFromSqlite){
      if(sqliteDetails[index].taskTypes=="High"){
        return Colors.red;
      }else if(sqliteDetails[index].taskTypes=="Medium"){
        return Colors.yellow;
      }else if(sqliteDetails[index].taskTypes=="Low"){
        return Colors.green;
      }else{
        return Colors.grey;
      }
    }else{
      if(driftDetails[index].taskTypes=="High"){
        return Colors.red;
      }else if(driftDetails[index].taskTypes=="Medium"){
        return Colors.yellow;
      }else if(driftDetails[index].taskTypes=="Low"){
        return Colors.green;
      }else{
        return Colors.grey;
      }
    }
  }

 bool checkingData(){
    if(isFromObject){
     return objectBoxDetails.isNotEmpty?true:false;
    }
    if(isFromHive){
      return hiveDetails.isNotEmpty?true:false;
    }
    if(isFromSqlite){
      return sqliteDetails.isNotEmpty?true:false;
    }
    if(isFromDrift){
      return driftDetails.isNotEmpty?true:false;
    }
    return false;
  }

  TaskModel passData(int index){
    TaskModel model= TaskModel();
    model.id =  isFromObject?objectBoxDetails[index].id:
    isFromHive?index:
    isFromSqlite?sqliteDetails[index].id:
    driftDetails[index].id;

    model.taskTitle =  isFromObject?objectBoxDetails[index].taskTitle:
    isFromHive?hiveDetails[index].taskTitle:
    isFromSqlite?sqliteDetails[index].taskTitle:
    driftDetails[index].taskTitle;

    model.taskDescription =  isFromObject?objectBoxDetails[index].taskDescription:
    isFromHive?hiveDetails[index].taskDescription:
    isFromSqlite?sqliteDetails[index].taskDescription:
    driftDetails[index].taskDescription;

    model.taskTypes =  isFromObject?objectBoxDetails[index].taskTypes:
    isFromHive?hiveDetails[index].taskTypes:
    isFromSqlite?sqliteDetails[index].taskTypes:
    driftDetails[index].taskTypes;

    model.subTaskCount =  isFromObject?objectBoxDetails[index].subTaskCount:
    isFromHive?hiveDetails[index].subTaskCount:
    isFromSqlite?sqliteDetails[index].subTaskCount:
    driftDetails[index].subTaskCount;

    model.subTaskTitle =  isFromObject?objectBoxDetails[index].subTaskTitle:
    isFromHive?hiveDetails[index].subTaskTitle:
    isFromSqlite?sqliteDetails[index].subTaskTitle:
    driftDetails[index].subTaskTitle;

    model.subTaskDescription =  isFromObject?objectBoxDetails[index].subTaskDescription:
    isFromHive?hiveDetails[index].subTaskDescription:
    isFromSqlite?sqliteDetails[index].subTaskDescription:
    driftDetails[index].subTaskDescription;

    model.dataBaseType =  isFromObject?"ObjectBox":
    isFromHive?"Hive":
    isFromSqlite?"Sqflite":
    "Drift";

    return model;
  }
}