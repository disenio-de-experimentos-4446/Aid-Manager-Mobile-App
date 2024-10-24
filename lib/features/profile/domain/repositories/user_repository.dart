import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<User> getUserById(int id);
  Future<List<User>> getAllUsersByCompanyId(int companyId);
  Future<List<User>> getMembersByCompanyName(String companyName);
  Future<User> getDirectorByCompanyName(String companyName);
}
