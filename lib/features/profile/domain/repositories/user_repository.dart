import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(int id);
  Future<List<User>> getAllUsersByCompanyId(int companyId);
  Future<void> deleteUserById(int userId);
  Future<List<User>> getMembersByCompanyName(String companyName);
  Future<User> getDirectorByCompanyName(String companyName);
  Future<void> updateUserInformationById(int userId, Map<String, dynamic> user);
}