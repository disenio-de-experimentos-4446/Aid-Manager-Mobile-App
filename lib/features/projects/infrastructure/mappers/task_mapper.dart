import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';

class TaskMapper {
  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: DateTime.parse(json['dueDate']),
      state: json['state'],
      assigneeId: json['assigneeId'],
      assigneeName: json['assigneeName'],
      assignImage: json['assignImage'],
      projectId: json['projectId'],
    );
  }

  static Map<String, dynamic> toJson(Task task) {
    return {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'createdAt': task.createdAt.toIso8601String(),
      'dueDate': task.dueDate.toIso8601String(),
      'state': task.state,
      'assigneeId': task.assigneeId,
      'assigneeName': task.assigneeName,
      'assignImage': task.assignImage,
      'projectId': task.projectId,
    };
  }
}