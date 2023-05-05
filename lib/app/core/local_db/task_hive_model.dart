// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'task_hive_model.g.dart'; // Used for generating TypeAdapter

@HiveType(typeId: 0) // So that generator gets an idea that it is a TypeAdapter
class TaskModel extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  String taskName;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime dueDate;
  @HiveField(4)
  String startTime;
  @HiveField(5)
  String endTime;
  @HiveField(6)
  bool isCompleted;
  @HiveField(7)
  bool isPending;
  @HiveField(8)
  bool isMissed;
  @HiveField(9)
  String category;


  TaskModel({
    required this.uuid,
    required this.taskName,
    required this.description,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.isPending,
    required this.isMissed,
    required this.category
  });

   @override
  String toString() {
    return 'TaskModel(uuid: $uuid, taskName: $taskName, description: $description, dueDate: $dueDate, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, isPending: $isPending, isMissed: $isMissed, category: $category)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'taskName': taskName,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'startTime': startTime,
      'endTime': endTime,
      'isCompleted': isCompleted,
      'isPending': isPending,
      'isMissed': isMissed,
      'category': category,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      isCompleted: map['isCompleted'] as bool,
      isPending: map['isPending'] as bool,
      isMissed: map['isMissed'] as bool,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
