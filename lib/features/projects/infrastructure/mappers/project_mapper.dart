import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';

class ProjectMapper {
  
  // Método para convertir JSON a un objeto Project
  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: List<String>.from(json['imageUrl']),
      companyId: json['companyId'],
      projectDate: DateTime.parse(json['projectDate']),
      projectTime: json['projectTime'],
      projectLocation: json['projectLocation'],
      userList: List<dynamic>.from(json['userList']),
    );
  }

  // Método para convertir un objeto Project a JSON
  static Map<String, dynamic> toJson(Project project) {
    return {
      'name': project.name,
      'description': project.description,
      'imageUrl': project.imageUrl,
      'companyId': project.companyId,
      'projectDate': project.projectDate.toIso8601String(),
      'projectTime': project.projectTime,
      'projectLocation': project.projectLocation,
    };
  }

}