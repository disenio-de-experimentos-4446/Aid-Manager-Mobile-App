import 'dart:io';
import 'package:aidmanager_mobile/features/profile/domain/entities/company.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

abstract class UserDatasource {
  Future<User> getUserById(int id);
  Future<List<User>> getAllUsersByCompanyId(int companyId);
  Future<void> deleteUserById(int userId);
  Future<List<User>> getMembersByCompanyName(String companyName);
  Future<User> getDirectorByCompanyName(String companyName);
  Future<void> updateUserInformationById(int userId, Map<String, dynamic> user);
  Future<void> updateProfileImageByUser(int userId, String imageUrl);
  Future<void> updateCompanyInformation(int companyId, Company company);
  Future<List<User>> getMembersDeletedByCompany(int companyId);
  Future<String> uploadImageToCloud(File file);
}