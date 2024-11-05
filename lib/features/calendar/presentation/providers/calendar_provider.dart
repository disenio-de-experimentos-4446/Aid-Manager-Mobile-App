import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/calendar/shared/exceptions/calendar_exception.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';
import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  final TasksRepository tasksRepository;
  AuthProvider authProvider;

  CalendarProvider({required this.authProvider, required this.tasksRepository});

  List<Task> tasks = [];

  bool initialLoading = false;

  Future<void> loadAllTasks() async {
    initialLoading = true;
    final companyId = authProvider.user!.companyId!;

    try {
      final allTasks = await tasksRepository.getAllTasksByCompanyId(3);

      if (allTasks.isEmpty) {
        throw NoTasksInCompanyException("");
      }

      tasks = allTasks;
    } on NoTasksInCompanyException {
      rethrow;
    } catch (e) {
      throw TasksFetchException(
          'Tasks not found for company with id: $companyId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }
}
