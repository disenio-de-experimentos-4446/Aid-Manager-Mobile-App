import 'dart:convert';
import 'dart:io';
import 'package:aidmanager_mobile/features/auth/domain/datasources/auth_datasource.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/mappers/user_mapper.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/login_exceptions.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/register_exceptions.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';
import 'package:dio/dio.dart';

/// Implementación de [AuthDatasource] para manejar la autenticación
/// mediante peticiones HTTP.
class AuthDatasourceImpl extends HttpService implements AuthDatasource {
  /// Inicia sesión con el [email] y [password] proporcionados.
  ///
  /// Retorna un [LoginResponse] con el token de autenticación y el ID del usuario.
  /// Lanza [SignInFailedException] si ocurre algún error en el inicio de sesión.
  @override
  Future<LoginResponse> signIn(String email, String password) async {
    final requestBody = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await dio.post(
        '/authentication/sign-in',
        data: requestBody,
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to sign in: ${response.statusCode}');
      }

      final responseData = response.data;

      final token = responseData['token'];
      final id = responseData['id'];

      if (token == null) throw Exception('Invalid response data: token is null');
      if (id == null) throw Exception('Invalid response data: id is null');

      return LoginResponse(id: id, token: token);
    } catch (e) {
      throw SignInFailedException('Failed to sign in: $e');
    }
  }

  /// Registra un nuevo [user] en el sistema.
  ///
  /// Convierte los datos del usuario a JSON y los envía al servidor.
  /// Lanza [InvalidCodeAccessException] si el código de registro no es válido.
  /// Lanza [Exception] si ocurre cualquier otro error durante el registro.
  @override
  Future<void> signUp(User user) async {
    final requestBody = UserMapper.toJson(user);

    try {
      final response = await dio.post(
        '/users/sign-up',
        data: jsonEncode(requestBody),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to sign up: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        final responseBody = e.response?.data;

        if (responseBody == "Error: Not Valid Register Code") {
          throw InvalidCodeAccessException("Error: Not Valid Register Code");
        }
      }

      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}
