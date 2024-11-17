import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';


abstract class TasksDatasource {
  Future<void> createTaskByProjectId(int projectId, Task task);
  Future<List<Task>> getTasksByProjectId(int projectId);
  Future<Task> getTaskById(int id);
  Future<List<Task>> getAllTasksByCompanyId(int companyId);
  Future<void> updateTaskById(int taskId, int projectId, Task task);
  Future<void> deleteTaskById(int projectId, int taskId);
  Future<void> updateStatusFieldByTask(int projectId, int taskId, String newStatus);
  Future<List<Task>> getAllTasksAssignedToUser(int companyId, int userId);
}