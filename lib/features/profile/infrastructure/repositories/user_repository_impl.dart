// lib/features/profile/infrastructure/repositories/user_repository_impl.dart
import 'dart:io';

import 'package:aidmanager_mobile/features/profile/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl({required this.datasource});

  @override
  Future<List<User>> getAllUsersByCompanyId(int companyId) {
    return datasource.getAllUsersByCompanyId(companyId);
  }

  @override
  Future<User> getUserById(int id) {
    return datasource.getUserById(id);
  }

  @override
  Future<void> deleteUserById(int userId) {
    return datasource.deleteUserById(userId);
  }

  @override
  Future<void> updateUserInformationById(int userId, Map<String, dynamic> user) async {
    return datasource.updateUserInformationById(userId, user);
  }

  @override
  Future<List<User>> getMembersByCompanyName(String companyName) {
    return datasource.getMembersByCompanyName(companyName);
  }

  @override
  Future<User> getDirectorByCompanyName(String companyName) {
    return datasource.getDirectorByCompanyName(companyName);
  }

  @override
  Future<void> updateProfileImageByUser(int userId, String imageUrl) {
    return datasource.updateProfileImageByUser(userId, imageUrl);
  }

  @override
  Future<String> uploadImageToCloud(File file) {
    return datasource.uploadImageToCloud(file);
  }
}