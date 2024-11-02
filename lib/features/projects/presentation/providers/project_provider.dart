import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/project_exceptions.dart';
import 'package:aidmanager_mobile/features/projects/shared/helpers/generate_images_project.dart';
import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectsRepository projectsRepository;
  AuthProvider authProvider;

  ProjectProvider({required this.authProvider, required this.projectsRepository});

  bool initialLoading = true;
  bool isLoading = false;
  List<Project> projects = [];
  Project? projectDetail;
  bool detailLoading = false;

  Future<void> loadInitialProjects() async {
    initialLoading = true;
    final companyId = authProvider.user!.companyId!;

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
    int numberImages,
    DateTime projectDate,
    TimeOfDay projectTime,
    String projectLocation,
  ) async {

    if (numberImages <= 0 || numberImages > 5) {
      throw InvalidNumberOfImagesException(
          'Number of images must be greater than 0 and less than or equal to 5');
    }

    if (description.length > 150) {
      throw InvalidDescriptionLengthException(
          'The project description must be less than 150 characters');
    }

    final newProject = Project(
      name: name,
      description: description,
      imageUrl: generateRandomImages(numberImages),
      projectDate: projectDate,
      companyId: authProvider.user?.companyId!,
      projectTime: projectTime,
      projectLocation: projectLocation,
    );

    isLoading = true;
    notifyListeners();
    //print({projectTime});

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
    detailLoading = true;

    try {
      projectDetail = await projectsRepository.getProjectById(projectId);
    } catch (e) {
      throw ProjectDetailFetchException('Failed to fetch project details: $e');
    } finally {
      detailLoading = false;
      notifyListeners();
    }
  }
}
