import 'dart:convert';
import 'dart:io';

import 'package:aidmanager_mobile/features/projects/domain/datasources/projects_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/project_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

// TODO: "implementar";
class ProjectsDatasourceImpl extends HttpService implements ProjectsDatasource {
  @override
  Future<void> createProject(Project project) async {
    final requestBody = ProjectMapper.toJson(project);
    print(requestBody);

    try {
      final response = await dio.post(
        '/projects',
        data  : jsonEncode(requestBody),  
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to create a new project: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to create a new project: Response body is empty');
      }

    } catch (e) {
      throw Exception('Failed to create a new project: $e');
    }
  }

  @override
  Future<void> deleteProjectById(int id) async {
    try {
      // validamos en primeras si existe un project con ese id
      final projectFounded = await dio.get('/projects/$id');

      if (projectFounded.statusCode != HttpStatus.ok || projectFounded.data == null || projectFounded.data.isEmpty) {
        throw Exception('Project with id $id does not exist');
      }

      // eliminacion del proyecto en base al ir
      final deleteResponse = await dio.delete('/projects/$id');

      if (deleteResponse.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete project: ${deleteResponse.statusCode}');
      }

    } catch (e) {
      //print('Error: $e');
      throw Exception('Failed to delete project: $e');
    }
  }

  @override
  Future<Project> getProjectById(int id) async {
    try {
      final response = await dio.get('/projects/get/$id');

      if(response.statusCode == HttpStatus.ok) {
        final dynamic projectJson = response.data;
        return ProjectMapper.fromJson(projectJson);
      }
      else{ 
        throw Exception('Failed to fetch project with id: $id');
      }

    } catch (e) {
      throw Exception('Failed to fetch project by $id ID: $e');
    }
  }

  @override
  Future<List<Project>> getProjectsByCompanyId(int companyId) async {
    try {
      final response = await dio.get('/projects/$companyId');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> projectsJson = response.data;
        return projectsJson.map((json) => ProjectMapper.fromJson(json)).toList();
      } 
      else {
        throw Exception('Failed to fetch projects by company with id: $companyId');
      }

    } catch (e) {
      throw Exception('Failed to fetch projects by company by $companyId id: $e');
    }
  }

  @override
  Future<void> updateProjectById(int id, Project project) async {
    final requestBody = ProjectMapper.toJson(project);

    try {
      final response = await dio.put(
        '/projects/$id',
        data: jsonEncode(requestBody),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update project with id $id: ${response.statusCode}');
      }

    } catch (e) {
      //print('Error: $e');
      throw Exception('Failed to update project witt id $id: $e');
    }
  }
  
}