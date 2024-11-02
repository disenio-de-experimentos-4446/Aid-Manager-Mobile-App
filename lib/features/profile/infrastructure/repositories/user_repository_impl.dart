import 'package:aidmanager_mobile/features/profile/domain/datasources/user_datasource.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource datasource;

  UserRepositoryImpl({required this.datasource});

  
  @override
  Future<List<User>> getAllUsersByCompanyId(int companyId) {
    return datasource.getAllUsersByCompanyId(companyId  );
  }
  
  @override
  Future<User> getUserById(int id) {
    return datasource.getUserById(id);
  }

  
}
