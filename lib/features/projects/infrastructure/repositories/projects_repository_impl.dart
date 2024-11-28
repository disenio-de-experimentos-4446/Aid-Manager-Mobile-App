import 'package:aidmanager_mobile/features/projects/domain/datasources/projects_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {

  final ProjectsDatasource datasource;

  ProjectsRepositoryImpl({required this.datasource});

  @override
  Future<void> createProject(Project project) {
    return datasource.createProject(project);
  }

  @override
  Future<void> deleteProjectById(int id) {
    return datasource.deleteProjectById(id);
  }

  @override
  Future<Project> getProjectById(int id) {
    return datasource.getProjectById(id);
  }

  @override
  Future<List<Project>> getProjectsByCompanyId(int companyId) {
    return datasource.getProjectsByCompanyId(companyId);
  }

  @override
  Future<void> updateProjectById(int id, Project project) {
    return datasource.updateProjectById(id, project);
  }
  
  @override
  Future<void> deleteProjectFromFavorites(int userId, int projectId) {
    return datasource.deleteProjectFromFavorites(userId, projectId);
  }
  
  @override
  Future<List<Project>> getFavoriteProjectsByUser(int userId) {
    return datasource.getFavoriteProjectsByUser(userId);
  }
  
  @override
  Future<List<Project>> getProjectsByUser(int userId) {
    return datasource.getProjectsByUser(userId);
  }
  
  @override
  Future<void> saveProjectAsFavorite(int userId, int projectId) {
    return datasource.saveProjectAsFavorite(userId, projectId);
  }
  
  @override
  Future<void> updateRatingByPost(int projectId, double rating) {
    return datasource.updateRatingByPost(projectId, rating);
  }
  
}