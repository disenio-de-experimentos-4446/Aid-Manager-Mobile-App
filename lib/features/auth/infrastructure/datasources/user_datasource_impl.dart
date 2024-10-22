import 'dart:io';
import 'package:aidmanager_mobile/features/auth/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

class UserDatasourceImpl extends HttpService implements UserDatasource {
  @override
  Future<List<User>> getAllUsers() async {
    try {
      final response = await dio.get('/users');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> usersJson = response.data;
        return usersJson.map((json) => UserMapper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch all users: $e');
    }
  }

  @override
  Future<List<User>> getAllUsersByCompanyName(String companyName) async {
    try {
      final response = await dio.get('/users/company/$companyName');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> usersJson = response.data;
        return usersJson.map((json) => UserMapper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user by company $companyName: $e');
    }
  }

  @override
  Future<User> getDirectorByCompanyName(String companyName) async {
    try {
      final response = await dio.get('/users/company/$companyName/director');

      if (response.statusCode == HttpStatus.ok) {
        final dynamic userJson = response.data;
        return UserMapper.fromJson(userJson);
      } else {
        throw Exception('Failed to fetch director: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch director by company $companyName: $e');
    }
  }

  @override
  Future<List<User>> getMembersByCompanyName(String companyName) async {
    try {
      final response = await dio.get('/users/company/$companyName/members');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> usersJson = response.data;
        return usersJson.map((json) => UserMapper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch members: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch members by $companyName: $e');
    }
  }

  @override
  Future<User> getUserById(int id) async {
    try {
      final response = await dio.get('/users/user/$id');


      if (response.statusCode == HttpStatus.ok) {
        final dynamic userJson = response.data;
        return UserMapper.fromJson(userJson);
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user by $id ID: $e');
    }
  }
}
