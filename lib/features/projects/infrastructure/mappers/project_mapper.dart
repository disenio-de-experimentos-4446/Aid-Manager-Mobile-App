import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: "implementar";
class ProjectMapper {
  // Método para convertir JSON a un objeto Project
  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      audit: DateTime.parse(json['audit']),
      name: json['name'],
      description: json['description'],
      imageUrl: List<String>.from(json['imageUrl']),
      companyId: json['companyId'],
      projectDate: DateTime.parse(json['projectDate']),
      projectTime: TimeOfDay(
        hour: int.parse(json['projectTime'].split(':')[0]),
        minute: int.parse(json['projectTime'].split(':')[1]),
      ),
      projectLocation: json['projectLocation'],
      userList: List<dynamic>.from(json['userList']),
    );
  }

  // Método para convertir un objeto Project a JSON
  static Map<String, dynamic> toJson(Project project) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    return {
      'name': project.name,
      'description': project.description,
      'imageUrl': project.imageUrl,
      'companyId': project.companyId,
      'projectDate': dateFormat.format(project.projectDate),
      'projectTime': timeFormat.format(DateTime(
          0, 1, 1, project.projectTime.hour, project.projectTime.minute)),
      'projectLocation': project.projectLocation,
    };
  }
}
