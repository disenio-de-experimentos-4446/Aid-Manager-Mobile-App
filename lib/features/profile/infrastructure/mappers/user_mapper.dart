import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';

// para el casteo de role a int y vicebersa
const Map<String, int> roleToInt = {
  'Manager': 0,
  'TeamMember': 1,
};

const Map<int, String> intToRole = {
  0: 'Manager',
  1: 'TeamMember',
};

class UserMapper {
  // convertir la respuest json a un objeto User
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      password: json['password'], 
      role: json['role'],
      teamRegisterCode: json['teamRegisterCode'] ?? '',
      phone: json['phone'],
      profileImg: json['profileImg'] ?? 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
      companyName: json['companyName'],
      companyEmail: json['companyEmail'],
      companyCountry: json['companyCountry'],
      companyId: json['companyId']
    );
  }

  // convertir objeto User a un json
  static Map<String, dynamic> toJson(User user) {
    final nameParts = user.name.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': user.age ?? 0,
      'email': user.email,
      'password': user.password,
      'role': roleToInt[user.role] ?? -1, // convertir rol a entero (request body)
      'teamRegisterCode': user.teamRegisterCode,
      'phone': user.phone ?? '',
      'profileImg': user.profileImg ?? '',
      'companyName': user.companyName ?? '',
      'companyEmail': user.companyEmail ?? '',
      'companyCountry': user.companyCountry ?? '',
    };
  }
}
