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
    notifyListeners();

    try {
      users = await userRepository.getMembersByCompanyName(authProvider.user!.companyName!);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> kickMemberFromCompany(int userId) async {
    try {
      await userRepository.deleteUserById(userId);
      users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}