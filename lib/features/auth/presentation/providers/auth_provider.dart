import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/login_exceptions.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/register_exceptions.dart';
import 'package:aidmanager_mobile/features/auth/shared/helpers/regex_helper.dart';
import 'package:aidmanager_mobile/shared/helpers/storage_helper.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/mappers/user_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  //DI de los repositories a utilizar
  final AuthRepository authRepository;
  final UserRepository userRepository;

  String? token = "";
  User? user;

  bool isLoading = false;

  AuthProvider({required this.authRepository, required this.userRepository});

  void setToken(String? currentToken) {
    token = currentToken;
    notifyListeners();
  }

  void setUser(User? currentUser) {
    user = currentUser;
    notifyListeners();
  }

  Future<void> submitLoginUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw EmptyFieldsException('Email and password cannot be empty');
    }

    if (!RegexHelper.isValidEmail(email)) {
      throw InvalidEmailFormatException('Invalid email format');
    }

    // establecer carga inicial y act la ui
    isLoading = true;
    notifyListeners();

    try {
      // recibimos el token y id de signIn
      final authResponse = await authRepository.signIn(email, password);
      final token = authResponse.token;
      final id = authResponse.id;
      // guardar el token en el estado global y en SharedPreferences
      setToken(token);
      await StorageHelper.saveToken(token);

      // es importante guardar el token en shrprefs antes de esta llamada porque
      // el token se utilizará para autenticar las peticiones en el interceptor HTTP de Dio !!
      final user = await userRepository.getUserById(id);

      // guardamos el usuario en el estado global y en SharedPreferences
      setUser(user);
      await StorageHelper.saveUser(user);

      //print('Almacenados en el estado global: ${{token, user.id}}');
    } catch (e) {
      throw SignInFailedException('Sign in failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitRegisterUser(
    String firstName,
    String lastName,
    String email,
    String password,
    int role,
    String teamRegisterCode, {
    String? companyName = "",
    String? companyEmail = "",
    String? companyCountry = "",
  }) async {
    // casteamos el role pasado como entero a "Manager"-[0] o "TeamMember-[1]"
    final roleString = intToRole[role] ?? 'TeamMember';

    final newUser = User(
      name: "$firstName $lastName",
      email: email,
      password: password,
      role: roleString,
      teamRegisterCode: teamRegisterCode,
      companyName: companyName,
      companyEmail: companyEmail,
      companyCountry: companyCountry,
    );

    isLoading = true;
    notifyListeners();

    try {
      // llamamos al método signUp para registrar al usuario
      await authRepository.signUp(newUser);
    } catch (e) {
      String errorMessage = e.toString();

      if (e is DioException && e.response != null) {
        final responseBody = e.response?.data;
        errorMessage = responseBody?.toString() ?? errorMessage;
      }

      if (errorMessage.contains("Error: Not Valid Register Code")) {
        throw InvalidCodeAccessException("Error: Not Valid Register Code");
      }

      throw SignUpFailedException('Failed to sign up: $errorMessage');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // cargamos las credenciales desde shrprefs (para mantener sesion activa :p)
  Future<bool> loadCredentials() async {
    final token = await StorageHelper.getToken();
    final user = await StorageHelper.getUser();
    setToken(token);
    setUser(user);
    return token != null && user != null;
  }

  // eliminamos el token y user logeado de shrprefs y actualizamos los cambios (al hacer logout en sidebar D:)
  Future<void> signOut() async {
    // removemos el token y user almacenado en shprefs
    await StorageHelper.removeCredentials();
    token = null;
    user = null;
    notifyListeners();
  }
}
