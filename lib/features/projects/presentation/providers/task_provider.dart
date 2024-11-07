import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/task_exceptions.dart';
import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  final TasksRepository tasksRepository;
  final UserRepository userRepository;
  AuthProvider authProvider;

  TaskProvider(
      {required this.authProvider,
      required this.userRepository,
      required this.tasksRepository});

  bool initialLoading = false;
  bool isLoading = false;
  bool updateLoading = false;
  List<Task> tasks = [];

  Future<void> loadInitialTasksByProjectId(int projectId) async {
    initialLoading = true;

    try {
      final tasksList = await tasksRepository.getTasksByProjectId(projectId);

      tasks = tasksList;
    } catch (e) {
      throw TasksFetchByProjectException(
          'Failed to fetch projects by project with id: $projectId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewTask(
    String title,
    String description,
    DateTime dueDate,
    String state,
    int assigneeId,
    int projectId,
  ) async {
    final newTask = Task(
      title: title,
      description: description,
      dueDate: dueDate,
      state: state,
      assigneeId: assigneeId,
    );

    isLoading = true;
    notifyListeners();

    try {
      await tasksRepository.createTaskByProjectId(projectId, newTask);
    } catch (e) {
      throw TaskCreationException('Failed to create a new project: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateStatusFieldByTask(int projectId, int taskId, String newStatus) async {

    updateLoading = true;

    try {
      await tasksRepository.updateStatusFieldByTask(projectId, taskId, newStatus);

      final taskIndex = tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        tasks[taskIndex].state = newStatus;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update task status');
    }
    finally {
      updateLoading = false;
      notifyListeners();
    }
  }
}
