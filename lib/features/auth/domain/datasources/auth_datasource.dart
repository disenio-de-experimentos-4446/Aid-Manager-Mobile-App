import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<AuthResponse> signIn(String email, String password);
  Future<void> signUp(User user);
}
