import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';

import '../../../profile/domain/entities/user.dart';

class SocialProvider extends ChangeNotifier {
  UserRepository userRepository;
  AuthProvider authProvider;

  SocialProvider({
    required this.userRepository,
    required this.authProvider,
  });

  List<User> users = [];
  bool isLoading = false;

  Future<void> getMembersByCompany() async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      // Fetch the logged-in user
      final loggedInUser = await userRepository.getUserById(authProvider.user!.id!);
      print('Logged-in user: $loggedInUser');

      // Fetch all users by company ID
      final allUsers = await userRepository.getAllUsersByCompanyId(loggedInUser.companyId!);
      print('All users in company: $allUsers');

      // Filter out the logged-in user from the list
      users = allUsers.where((user) => user.id != loggedInUser.id).toList();
      print('Filtered users: $users');
    } catch (e) {
      print('Error fetching members: $e');
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> kickMemberFromCompany(int userId) async {
    try {
      await userRepository.deleteUserById(userId);
      users.removeWhere((user) => user.id == userId);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (e) {
      print('Error kicking member: $e');
    }
  }
}