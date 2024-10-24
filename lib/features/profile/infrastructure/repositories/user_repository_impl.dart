import 'package:aidmanager_mobile/features/profile/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource datasource;

  UserRepositoryImpl({required this.datasource});
  
  @override
  Future<List<User>> getAllUsers() {
    return datasource.getAllUsers();
  }
  
  @override
  Future<List<User>> getAllUsersByCompanyId(int companyId) {
    return datasource.getAllUsersByCompanyId(companyId  );
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
