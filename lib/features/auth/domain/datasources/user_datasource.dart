import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';

abstract class UserDatasource {
  Future<List<User>> getAllUsers();
  Future<User> getUserById(int id);
  Future<List<User>> getAllUsersByCompanyName(String companyName);
  Future<List<User>> getMembersByCompanyName(String companyName);
  Future<User> getDirectorByCompanyName(String companyName);
}
