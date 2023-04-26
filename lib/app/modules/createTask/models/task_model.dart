// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String? uuid;
  String taskName;
  String description;
  String category;
  DateTime dueDate;
  String startTime;
  String endTime;
  bool isCompleted;
  bool isPending;
  bool isMissed;
  TaskModel({
    this.uuid,
    required this.taskName,
    required this.description,
    required this.category,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.isPending,
    required this.isMissed,
  });



  TaskModel copyWith({
    String? uuid,
    String? taskName,
    String? description,
    String? category,
    DateTime? dueDate,
    String? startTime,
    String? endTime,
    bool? isCompleted,
    bool? isPending,
    bool? isMissed,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isPending: isPending ?? this.isPending,
      isMissed: isMissed ?? this.isMissed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'taskName': taskName,
      'description': description,
      'category': category,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'startTime': startTime,
      'endTime': endTime,
      'isCompleted': isCompleted,
      'isPending': isPending,
      'isMissed': isMissed,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      isCompleted: map['isCompleted'] as bool,
      isPending: map['isPending'] as bool,
      isMissed: map['isMissed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(uuid: $uuid, taskName: $taskName, description: $description, category: $category, dueDate: $dueDate, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, isPending: $isPending, isMissed: $isMissed)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return
      other.uuid == uuid &&
      other.taskName == taskName &&
      other.description == description &&
      other.category == category &&
      other.dueDate == dueDate &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.isCompleted == isCompleted &&
      other.isPending == isPending &&
      other.isMissed == isMissed;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      taskName.hashCode ^
      description.hashCode ^
      category.hashCode ^
      dueDate.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      isCompleted.hashCode ^
      isPending.hashCode ^
      isMissed.hashCode;
  }
}
