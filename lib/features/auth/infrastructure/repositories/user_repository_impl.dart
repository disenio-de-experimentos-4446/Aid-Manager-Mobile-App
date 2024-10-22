import 'package:aidmanager_mobile/features/auth/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource datasource;

  UserRepositoryImpl({required this.datasource});
  
  @override
  Future<List<User>> getAllUsers() {
    return datasource.getAllUsers();
  }
  
  @override
  Future<List<User>> getAllUsersByCompanyName(String companyName) {
    return datasource.getAllUsersByCompanyName(companyName);
  }
  
  @override
  Future<User> getDirectorByCompanyName(String companyName) {
    return datasource.getDirectorByCompanyName(companyName);
  }
  
  @override
  Future<List<User>> getMembersByCompanyName(String companyName) {
    return datasource.getMembersByCompanyName(companyName);
  }
  
  @override
  Future<User> getUserById(int id) {
    return datasource.getUserById(id);
  }

  
}
