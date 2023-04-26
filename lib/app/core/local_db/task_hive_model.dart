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
}
