import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

/// Definición de las operaciones de autenticación.
abstract class AuthDatasource {
  /// Inicia sesión de usuario con el [email] y [password] dados.
  ///
  /// Retorna un [LoginResponse] que contiene la información de autenticación.
  Future<LoginResponse> signIn(String email, String password);

  /// Registra un nuevo usuario con los datos de [user].
  Future<void> signUp(User user);
}
