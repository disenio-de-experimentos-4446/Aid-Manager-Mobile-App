import 'dart:io';

import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/company.dart';
import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/profile/shared/exceptions/profile_exception.dart';
import 'package:aidmanager_mobile/shared/helpers/storage_helper.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final UserRepository userRepository;
  AuthProvider authProvider;

  List<User> users = [];
  bool isLoading = false;

  ProfileProvider({
    required this.authProvider,
    required this.userRepository,
  });

  Future<void> getMembersByCompany() async {
    isLoading = true;
    final companyId = authProvider.user!.companyId!;

    try {
      final usersList = await userRepository.getAllUsersByCompanyId(companyId);
      final teamMembers =
          usersList.where((user) => user.role == 'TeamMember').toList();

      users = teamMembers;
    } catch (e) {
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

      //print('Almacenados en el estado global: ${{userToUpdate.teamRegisterCode.toString()}}');
    } catch (e) {
      throw Exception("Error to update user");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCompanyInformation(
      String companyName, String companyCountry, String companyEmail) async {
    final currentCompanyId = authProvider.user!.companyId!;

    final companyToUpdate = Company(
        companyName: companyName, email: companyEmail, country: companyCountry);

    isLoading = true;
    notifyListeners();

    try {
      await userRepository.updateCompanyInformation(
          currentCompanyId, companyToUpdate);

      // creamos una copia de la instancia user actualizando los campos de la compañía
      // (mas explicado en User entity :p)
      final updatedUser = authProvider.user!.copyWith(
        companyName: companyName,
        companyEmail: companyEmail,
        companyCountry: companyCountry,
      );

      // actualizar el usuario en authProvider y en StorageHelper
      authProvider.setUser(updatedUser);
      await StorageHelper.saveUser(updatedUser);
    } catch (e) {
      throw Exception('Error to update company information');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileImageFromCurrentUser(File file) async {
    final loggedUserId = authProvider.user!.id!;

    isLoading = true;
    notifyListeners();

    try {
      final newProfileImgUrl = await userRepository.uploadImageToCloud(file);
      await userRepository.updateProfileImageByUser(
          loggedUserId, newProfileImgUrl);

      // creamos una copia de la instancia user act el campo profileImg
      // para no mandar toda la wea como en updatePersonalInfo :V (de ahi se refac lo del updateInfo)
      final updatedUser =
          authProvider.user!.copyWith(profileImg: newProfileImgUrl);
      authProvider.setUser(updatedUser);
      await StorageHelper.saveUser(updatedUser);
    } catch (e) {
      throw UserProfileUpdateFailedException(
          'Error to update profile image for user');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
