import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final UserRepository userRepository;
  AuthProvider authProvider;

  List<User> users = [];
  bool isLoading = false;

  ProfileProvider({required this.authProvider, required this.userRepository});

  Future<void> getMembersByCompany() async {
    isLoading = true;
    final companyId = authProvider.user!.companyId!;

    try {
      final usersList = await userRepository.getAllUsersByCompanyId(companyId);
      final teamMembers = usersList.where((user) => user.role == 'TeamMember').toList();

      users = teamMembers;
    } catch (e) {
      // Manejar el error de manera adecuada
      //print('Error fetching users: $e');
      throw Exception('Failed to fetch users');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
