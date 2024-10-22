import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/project_exceptions.dart';
import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectsRepository projectsRepository;

  ProjectProvider({required this.projectsRepository});

  bool initialLoading = true;
  bool isLoading = false;
  List<Project> projects = [];
  Project? projectDetail;

  Future<void> loadInitialProjects(int companyId) async {
    initialLoading = true;

    try {
      final projectsList =
          await projectsRepository.getProjectsByCompanyId(companyId);

      projects = projectsList;
    } catch (e) {
      throw ProjectsFetchException(
          'Failed to fetch projects by company with id: $companyId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitNewProject(
    String name,
    String description,
    List<String> images,
    DateTime projectDate,
    TimeOfDay projectTime,
    String projectLocation,
  ) async {

    final newProject = Project(
      name: name,
      description: description,
      imageUrl: images,
      projectDate: projectDate,
      projectTime: '${projectTime.hour}:${projectTime.minute.toString().padLeft(2, '0')}',
      projectLocation: projectLocation,
    );

    isLoading = true;
    notifyListeners();

    try {
      await projectsRepository.createProject(newProject);
    } catch (e) {
      throw ProjectCreationException('Failed to create a new project: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProjectDetail(int projectId) async {
    isLoading = true;
    notifyListeners();

    try {
      projectDetail = await projectsRepository.getProjectById(projectId);
    } catch (e) {
      throw ProjectDetailFetchException('Failed to fetch project details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
}
