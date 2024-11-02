import 'dart:io';
import 'package:aidmanager_mobile/features/profile/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/mappers/user_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

import '../../../../shared/helpers/storage_helper.dart';

class UserDatasourceImpl extends HttpService implements UserDatasource {

  @override
  Future<List<User>> getAllUsersByCompanyId(int companyId) async {
    try {
      final response = await dio.get('/users/$companyId');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> usersJson = response.data;
        return usersJson.map((json) => UserMapper.fromJsonGetAll(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user by company $companyId: $e');
    }
  }

  @override
  Future<User> getUserById(int id) async {
    try {

      final response = await dio.get('/users/user/$id');
      print("JSON RESPONSE: ${response.data}");

      if (response.statusCode == HttpStatus.ok) {
        final dynamic userJson = response.data;
        var data = UserMapper.fromJsonGetOne(userJson);
        StorageHelper.saveUser(data);
        return data;
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user by $id ID: $e');
    }
  }
}
