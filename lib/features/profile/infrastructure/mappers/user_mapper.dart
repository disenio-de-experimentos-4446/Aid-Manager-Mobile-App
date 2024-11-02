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
  // Convert JSON response to a User object for getting all users
  static User fromJsonGetAll(Map<String, dynamic> json) {
    var image = json['profileImg'];
    if (image == null || !Uri.tryParse(image)!.hasAbsolutePath) {
      image = 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar.jpg';
    }

    return User(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        teamRegisterCode: json['teamRegisterCode'] ?? '',
        phone: json['phone'],
        profileImg: image,
        companyName: json['companyName'],
        companyEmail: json['companyEmail'] ?? '',
        companyCountry: json['companyCountry'] ?? '',
        companyId: json['companyId']
    );
  }

  // Convert JSON response to a User object for getting a single user
  static User fromJsonGetOne(Map<String, dynamic> json) {
    var image = json['profileImg'];
    if (image == null || !Uri.tryParse(image)!.hasAbsolutePath) {
      image = 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar.jpg';
    }

    return User(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        teamRegisterCode: json['teamRegisterCode'] ?? '',
        phone: json['phone'],
        profileImg: image,
        companyName: json['companyName'],
        companyEmail: json['companyEmail'],
        companyCountry: json['companyCountry'],
        companyId: json['companyId']
    );
  }

  // Convert JSON response to a User object for posting a user
  static Map<String, dynamic> fromJsonPost(User user) {

    return {
      'id': user.id,
      'name': user.name,
      'age': user.age ?? 0,
      'email': user.email,
      'password': user.password,
      'role': user.role, // Convert role to integer (request body)
      'teamRegisterCode': user.teamRegisterCode,
      'phone': user.phone ?? '',
      'profileImg': user.profileImg ?? '',
      'companyName': user.companyName ?? '',
      'companyEmail': user.companyEmail ?? '',
      'companyCountry': user.companyCountry ?? '',
      'companyId': user.companyId
    };

  }

  // Convert User object to JSON for posting a user
  static Map<String, dynamic> toJsonPost(User user) {
    final nameParts = user.name.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': user.age ?? 0,
      'email': user.email,
      'password': user.password,
      'role': roleToInt[user.role] ?? -1, // Convert role to integer (request body)
      'teamRegisterCode': user.teamRegisterCode,
      'phone': user.phone ?? '',
      'profileImg': user.profileImg ?? '',
      'companyName': user.companyName ?? '',
      'companyEmail': user.companyEmail ?? '',
      'companyCountry': user.companyCountry ?? '',
    };
  }
}