import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:intl/intl.dart';

// TODO: "implementar";
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
      assignImage: json['assigneeImage'],
      projectId: json['projectId'],
    );
  }

  static Map<String, dynamic> toJson(Task task) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'title': task.title,
      'description': task.description,
      'dueDate': dateFormat.format(task.dueDate),
      'state': task.state,
      'assigneeId': task.assigneeId,
    };
  }
}