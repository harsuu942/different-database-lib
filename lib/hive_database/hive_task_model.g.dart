// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTaskDetailsAdapter extends TypeAdapter<HiveTaskDetails> {
  @override
  final int typeId = 0;

  @override
  HiveTaskDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTaskDetails(
      taskTitle: fields[0] as String?,
      taskDescription: fields[1] as String?,
      taskTypes: fields[2] as String?,
      subTaskCount: fields[3] as int?,
      subTaskTitle: fields[4] as String?,
      subTaskDescription: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTaskDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskTitle)
      ..writeByte(1)
      ..write(obj.taskDescription)
      ..writeByte(2)
      ..write(obj.taskTypes)
      ..writeByte(3)
      ..write(obj.subTaskCount)
      ..writeByte(4)
      ..write(obj.subTaskTitle)
      ..writeByte(5)
      ..write(obj.subTaskDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTaskDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
