import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/home/shared/exceptions/home_exception.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final ProjectsRepository projectsRepository;
  final UserRepository userRepository;
  final TasksRepository tasksRepository;
  AuthProvider authProvider;

  HomeProvider({
    required this.authProvider,
    required this.projectsRepository,
    required this.userRepository,
    required this.tasksRepository,
  });

  List<User> users = [];
  List<Project> projects = [];
  List<Task> tasks = [];

  bool initialLoading = false;

  Future<void> loadInitialInformation() async {

    initialLoading = true;
    final companyId = authProvider.user!.companyId!;

    try {
      final newUsers = await userRepository.getAllUsersByCompanyId(companyId);
      final newProjects = await projectsRepository.getProjectsByCompanyId(companyId);
      final newTasks = await tasksRepository.getAllTasksByCompanyId(companyId);

      users = newUsers;
      projects = newProjects;  
      tasks = newTasks;   
    } catch (e) {
      throw HomeFetchException("Failed to fetch information for company with id: $companyId");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

}
