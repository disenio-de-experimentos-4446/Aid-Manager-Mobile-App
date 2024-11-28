import 'dart:convert';
import 'dart:io';
import 'package:aidmanager_mobile/features/projects/domain/datasources/tasks_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/task_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

class TasksDatasourceImpl extends HttpService implements TasksDatasource {
  @override
  Future<void> createTaskByProjectId(int projectId, Task task) async {
    final requestBody = TaskMapper.toJson(task);

    try {
      final response = await dio.post(
        '/projects/$projectId/task-items',
        data: jsonEncode(requestBody),
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to create a new task: ${response.statusCode}');
      }


      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to create a new task: Response body is empty');
      }


    } catch (e) {
      throw Exception('Failed to create a new task by project id: $projectId');
    }
  }

  @override
  Future<void> updateStatusFieldByTask(int projectId, int taskId, String newStatus) async {

    final requestBody = jsonEncode({
      'status': newStatus
    });

    try {
      final response = await dio.patch(
        '/projects/$projectId/task-items/$taskId',
        data: requestBody,
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update task status: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to update task status: Response body is empty');
      }
      
    } catch (e) {
      throw Exception('Failed to update task status for task id: $taskId in project id: $projectId. Original error: $e');
    }
  }

  @override
  Future<void> deleteTaskById(int projectId, int taskId) async {
    try {
      final deleteResponse = await dio.delete('/projects/$projectId/task-items/$taskId');

      if(deleteResponse.statusCode != HttpStatus.ok || deleteResponse.data.isEmpty) {
        throw Exception('Failed to delete task with id: $taskId ${deleteResponse.statusCode}');
      }

    } catch (e) {
      throw Exception('Failed to delete task with id: $taskId, $e');
    }
  }

  @override
  Future<Task> getTaskById(int id) async {
    try {
      final response = await dio.get('/task-items/$id');

      if(response.statusCode == HttpStatus.ok) {
        final dynamic taskJson = response.data;
        return TaskMapper.fromJson(taskJson);
      }
      else{ 
        throw Exception('Failed to fetch project with id: $id');
      }

    } catch (e) {
      throw Exception('Failed to find project with id: $id, $e');
    }
  }

  @override
  Future<List<Task>> getTasksByProjectId(int projectId) async {
    try {
      final response = await dio.get('/projects/$projectId/task-items/all');

      if(response.statusCode == HttpStatus.ok) {
        final List<dynamic> tasksJson = response.data;
        return tasksJson.map((json) => TaskMapper.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to get Tasks by project id: $projectId');
      }

    } catch (e) {
      throw Exception('Failed to get Tasks by Project with id $projectId: $projectId');
    }
  }
  
  @override
  Future<List<Task>> getAllTasksByCompanyId(int companyId) async {

    try {
      final response = await dio.get('/company-tasks/$companyId');

      if(response.statusCode == HttpStatus.ok) {
        final List<dynamic> tasksJson = response.data;
        return tasksJson.map((json) => TaskMapper.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to get Tasks by company id: $companyId');
      }

    } catch (e) {
      throw Exception('Failed to get Tasks by Project with id: $companyId');
    }

  }

  @override
  Future<void> updateTaskById(int id, int projectId, Task task) async {
    final requestBody = TaskMapper.toJson(task);

    try {
      final response = await dio.put(
        '/task-items/$id',
        data: jsonEncode(requestBody),
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update task with id: $id');
      }

    } catch (e) {
      throw Exception('Failed to update task with id $id for project, $e');
    }
  }
  
  @override
  Future<List<Task>> getAllTasksAssignedToUser(int companyId, int userId) async {
    
    try {
      final response = await dio.get(
        '/company-tasks/$companyId/user/$userId',
      );

      if(response.statusCode == HttpStatus.ok) {
        final List<dynamic> tasksJson = response.data;
        return tasksJson.map((json) => TaskMapper.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to get Tasks for user assignned with id: $userId');
      }

    } catch (e) {
      throw Exception('Failed to get Tasks for user assignned with id: $userId, $e');
    }

  }
  
}