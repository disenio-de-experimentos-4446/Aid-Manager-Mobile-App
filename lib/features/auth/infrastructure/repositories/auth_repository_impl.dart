import 'package:aidmanager_mobile/features/auth/domain/datasources/auth_datasource.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/auth_repository.dart';

/// Repositorio de autenticación que se conecta con la fuente de datos para tareas de autenticación.
class AuthRepositoryImpl implements AuthRepository {
  /// Fuente de datos para manejar las solicitudes de autenticación.
  final AuthDatasource datasource;

  /// Crea una instancia de [AuthRepositoryImpl] con el [datasource] dado.
  AuthRepositoryImpl({required this.datasource});

  /// Inicia sesión de un usuario con el [email] y [password].
  /// Devuelve un [LoginResponse] con los detalles de autenticación.
  @override
  Future<LoginResponse> signIn(String email, String password) {
    return datasource.signIn(email, password);
  }

  /// Registra un nuevo [user].
  @override
  Future<void> signUp(User user) {
    return datasource.signUp(user);
  }
}
