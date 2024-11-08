import 'package:aidmanager_mobile/features/projects/domain/datasources/tasks_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {

  final TasksDatasource datasource;

  TasksRepositoryImpl({required this.datasource});

  @override
  Future<void> createTaskByProjectId(int projectId, Task task) {
    return datasource.createTaskByProjectId(projectId, task);
  }

  @override
  Future<void> deleteTaskById(int projectId, int taskId) {
    return datasource.deleteTaskById(projectId, taskId);
  }

  @override
  Future<Task> getTaskById(int id) {
    return datasource.getTaskById(id);
  }

  @override
  Future<List<Task>> getTasksByProjectId(int projectId) {
    return datasource.getTasksByProjectId(projectId);
  }

  @override
  Future<List<Task>> getAllTasksByCompanyId(int companyId) {
    return datasource.getAllTasksByCompanyId(companyId);
  }

  @override
  Future<void> updateTaskById(int id, Task task) {
    return datasource.updateTaskById(id, task);
  }

  @override
  Future<void> updateStatusFieldByTask(int projectId, int taskId, String newStatus) {
    return datasource.updateStatusFieldByTask(projectId, taskId, newStatus);
  }
  
}