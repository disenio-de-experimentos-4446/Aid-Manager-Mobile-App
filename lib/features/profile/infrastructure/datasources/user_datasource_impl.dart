import 'dart:convert';
import 'dart:io';
import 'package:aidmanager_mobile/features/profile/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/company.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/mappers/user_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';
import 'package:dio/dio.dart';

class UserDatasourceImpl extends HttpService implements UserDatasource {
  @override
  Future<List<User>> getAllUsersByCompanyId(int companyId) async {
    try {
      final response = await dio.get('/users/$companyId');

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> usersJson = response.data;
        return usersJson.map((json) => UserMapper.fromJson(json)).toList();
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

  @override
  Future<void> deleteUserById(int userId) async {
    try {
      final response = await dio.delete('/users/kick-member/$userId');
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<void> updateUserInformationById(
      int userId, Map<String, dynamic> userData) async {
    print(userData);

    try {
      final response = await dio.put(
        '/users/$userId',
        data: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        throw Exception(
            'Failed to update user: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update user by id: $userId, $e');
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
      throw Exception(
          'Failed to fetch members by company name $companyName: $e');
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
      throw Exception(
          'Failed to fetch director by company name $companyName: $e');
    }
  }

  @override
  Future<String> uploadImageToCloud(File file) async {
    // nueva instancia de dio para no mandar el token y evitar el interceptor
    final Dio dio = Dio();

    final String cloudName = "dhf6g6xkf";
    final String uploadPreset = "ml_default";
    final cloudinaryUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'upload_preset': uploadPreset,
      });

      final response = await dio.post(cloudinaryUrl, data: formData);
      
      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        throw Exception("Error al subir la imagen a Cloudinary: ${response.statusCode}, ${response.statusMessage}");
      }
    } finally {
      // se elimina una vez subido a la nube para lib espacio en el almacenamiento
      file.delete();
    }
  }

  @override
  Future<void> updateCompanyInformation(int companyId, Company company) async {
    
    final requestBody = jsonEncode({
      'companyName': company.companyName,
      'country': company.country,
      'email': company.email
    });

    try {
      final response = await dio.put(
        '/company/$companyId',
        data: requestBody,
      );  

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update company information with id: $companyId: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to update company information for company with id: $companyId: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception("Failed to update current company with id: $companyId, $e");
    }

  }

  @override
  Future<void> updateProfileImageByUser(int userId, String imageUrl) async {
    
    final requestBody = jsonEncode({
      'image': imageUrl
    });

    try {
      final response = await dio.patch(
        '/users/update-image/$userId',
        data: requestBody
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update profile image for user with id: $userId: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to update user image with id $userId: Response body is empty');
      }

    } catch (e) {
      throw Exception('Failed to update profile image in user with id: $userId. Original error: $e');
    }

  }  

}