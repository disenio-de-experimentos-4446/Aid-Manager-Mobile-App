import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';

abstract class ProjectsRepository {
  Future<void> createProject(Project project);
  Future<List<Project>> getProjectsByCompanyId(int companyId);
  Future<Project> getProjectById(int id);
  Future<void> deleteProjectById(int id);
  Future<void> updateProjectById(int id, Project project);
  Future<List<Project>> getProjectsByUser(int userId);
  Future<void> saveProjectAsFavorite(int userId, int projectId);
  Future<void> deleteProjectFromFavorites(int userId, int projectId);
  Future<List<Project>> getFavoriteProjectsByUser(int userId);
  Future<void> updateRatingByPost(int projectId, double rating);
}
