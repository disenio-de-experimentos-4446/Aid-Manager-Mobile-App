import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/project_exceptions.dart';
import 'package:aidmanager_mobile/features/projects/shared/helpers/generate_images_project.dart';
import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectsRepository projectsRepository;
  AuthProvider authProvider;

  ProjectProvider({
    required this.authProvider,
    required this.projectsRepository,
  });

  bool initialLoading = true;
  bool isLoading = false;
  List<Project> projects = [];
  List<Project> favProjects = [];
  List<Project> projectsUser = [];
  Project? projectDetail;
  bool detailLoading = false;

  // la logica para los favorites es bien ratona(basc un load de los proyectos q estan como favoritos
  // en base a ello se setean en el campo "isFavorite" para cada project)
  Future<void> loadInitialProjects() async {
    initialLoading = true;
    final userIdLogged = authProvider.user!.id!;
    final companyId = authProvider.user!.companyId!;

    try {
      final projectsList = await projectsRepository.getProjectsByCompanyId(companyId);
      final favProjects =
          await projectsRepository.getFavoriteProjectsByUser(userIdLogged);

      // cremaos un set de IDs de proyectos favoritos
      final favProjectIds = favProjects.map((project) => project.id).toSet();

      // actualizamos el campo isFavorite en projectsList
      for (var project in projectsList) {
        project.isFavorite = favProjectIds.contains(project.id);
      }

      projects = projectsList;
    } catch (e) {
      throw ProjectsFetchException('Failed to fetch projects by company with id: $companyId');
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

    try {
      await projectsRepository.createProject(newProject);
    } catch (e) {
      throw ProjectCreationException('Failed to create a new project: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProject(
      int projectId,
      String title,
      String description,
      List<String> imageUrl,
      DateTime projectDate,
      TimeOfDay projectTime,
      String projectLocation) async {
    final loggedCompanyId = authProvider.user!.companyId!;

    if (description.length > 150) {
      throw InvalidDescriptionLengthException(
          'The project description must be less than 150 characters');
    }

    final postToUpdate = Project(
        name: title,
        description: description,
        imageUrl: imageUrl,
        companyId: loggedCompanyId,
        projectDate: projectDate,
        projectTime: projectTime,
        projectLocation: projectLocation);

    initialLoading = true;

    try {
      await projectsRepository.updateProjectById(projectId, postToUpdate);
    } catch (e) {
      throw ProjectUpdateException(
          "Error to update current project with id: $projectId, $e");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProjectById(int projectId) async {
    initialLoading = true;

    try {
      await projectsRepository.deleteProjectById(projectId);
      projects.removeWhere((project) => project.id == projectId);
    } catch (e) {
      throw Exception('Failed to delete a project with id $projectId: $e');
    } finally {
      initialLoading = false;
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

  Future<void> loadProjectsByUser(int userId) async {
    initialLoading = true;

    try {
      final projectsList = await projectsRepository.getProjectsByUser(userId);

      projectsUser = projectsList;
    } catch (e) {
      throw ProjectsFetchException(
          'Failed to fetch projects by user with id: $userId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProjectAsFavorite(int projectId) async {
    final userIdLogged = authProvider.user!.id!;
    initialLoading = true;

    try {
      await projectsRepository.saveProjectAsFavorite(userIdLogged, projectId);
    } catch (e) {
      throw ProjectCreationException('Failed to create a new project: $e');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProjectFromFavorites(int projectId) async {
    final userIdLogged = authProvider.user!.id!;
    initialLoading = true;

    try {
      await projectsRepository.deleteProjectFromFavorites(
          userIdLogged, projectId);
      // manejamos aqui el array para projects favoritos
      favProjects.removeWhere((project) => project.id == projectId);
    } catch (e) {
      throw ProjectCreationException('Failed to create a new project: $e');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavoritesProjects(int userId) async {
    initialLoading = true;
    //final userIdLogged = authProvider.user!.id!;
    try {
      final projectsList =
          await projectsRepository.getFavoriteProjectsByUser(userId);

      favProjects = projectsList;
    } catch (e) {
      throw ProjectCreationException('Failed to create a new project: $e');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProjectRating(int projectId, double rating) async {
    detailLoading = true;

    try {
      await projectsRepository.updateRatingByPost(projectId, rating);

      if (projectDetail != null && projectDetail!.id == projectId) {
        projectDetail!.rating = rating;
      }
    } catch (e) {
      throw Exception('Failed to update project rating');
    } finally {
      detailLoading = false;
      notifyListeners();
    }
  }

}
