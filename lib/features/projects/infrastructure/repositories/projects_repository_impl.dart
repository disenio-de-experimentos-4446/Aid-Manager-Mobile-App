import 'package:aidmanager_mobile/features/projects/domain/datasources/projects_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';

// TODO: "implementar";
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
  
}