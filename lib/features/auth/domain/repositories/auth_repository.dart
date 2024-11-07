import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<LoginResponse> signIn(String email, String password);
  Future<void> signUp(User user);
}