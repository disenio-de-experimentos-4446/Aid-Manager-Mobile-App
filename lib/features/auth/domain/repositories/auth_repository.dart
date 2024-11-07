import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

abstract class AuthRepository {

  /// Inicia sesión con el [email] y [password] dados.
  ///
  /// Retorna un [LoginResponse] con el token de autenticación y el ID del usuario.
  Future<LoginResponse> signIn(String email, String password);

  /// Registra un nuevo usuario con los datos de [user].
  Future<void> signUp(User user);
}
