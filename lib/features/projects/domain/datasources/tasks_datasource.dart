import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';

abstract class TasksDatasource {
  Future<void> createTaskByProjectId(int projectId, Task task);
  Future<List<Task>> getTasksByProjectId(int projectId);
  Future<Task> getTaskById(int id);
  Future<void> updateTaskById(int id, Task task);
  Future<void> deleteTaskById(int id);
}