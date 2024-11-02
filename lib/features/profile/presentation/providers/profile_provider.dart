import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/shared/helpers/storage_helper.dart';
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
      final teamMembers =
          usersList.where((user) => user.role == 'TeamMember').toList();

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

  Future<void> updatePersonalInformation(String firstName, String lastName,
      String phone, String email, int age) async {

    final loggedCompanyName = authProvider.user!.companyName;
    final loggedCompanyEmail = authProvider.user!.companyEmail;
    final loggedCompanyCountry = authProvider.user!.companyCountry;
    final loggedCompanyId = authProvider.user!.companyId;
    final loggedProfileImg = authProvider.user!.profileImg;
    final loggedPassword = authProvider.user!.password;
    final loggedUserId = authProvider.user!.id;
    final loggedRole = authProvider.user!.role;
    final currentTeamCode = authProvider.user!.teamRegisterCode;

    print(loggedUserId);

    // map to requestBody for update user
    final Map<String, dynamic> updatedUser = {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'phone': phone,
      'profileImg': loggedProfileImg,
      'email': email,
      'password': loggedPassword,
    };

    isLoading = true;
    notifyListeners();

    try {
      // user info to update info in global state and shprefs
      final userToUpdate = User(
        id: loggedUserId,
        name: "$firstName $lastName",
        email: email,
        password: loggedPassword,
        role: loggedRole,
        teamRegisterCode: currentTeamCode,
        profileImg: loggedProfileImg,
        phone: phone,
        age: age,
        companyName: loggedCompanyName,
        companyCountry: loggedCompanyCountry,
        companyEmail: loggedCompanyEmail,
        companyId: loggedCompanyId,
      );

      await userRepository.updateUserInformationById(
        loggedUserId!,
        updatedUser,
      );

      authProvider.setUser(userToUpdate);
      await StorageHelper.saveUser(userToUpdate);

      print('Almacenados en el estado global: ${{userToUpdate.teamRegisterCode.toString()}}');
    } catch (e) {
      throw Exception("Error to update user");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
