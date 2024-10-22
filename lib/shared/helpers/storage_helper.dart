import 'dart:convert';
import 'package:aidmanager_mobile/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';

class StorageHelper {
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(UserMapper.toJson(user)));
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      return UserMapper.fromJson(jsonDecode(userString));
    }
    return null;
  }

  static Future<void> removeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}