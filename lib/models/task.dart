import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    required this.id,
    required this.task,
    required this.isCompleted,
    required this.dueDate,
    required this.userId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String task;
  bool isCompleted;
  DateTime dueDate;
  int userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        task: json["task"],
        isCompleted: json["is_completed"],
        dueDate: DateTime.parse(json["due_date"]),
        userId: json["user_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "is_completed": isCompleted,
        "due_date": dueDate.toIso8601String(),
        "user_id": userId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
