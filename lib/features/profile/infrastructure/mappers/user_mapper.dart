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

    print("JSON: $json");

    print("Parsed values:");
    print("id: ${json['id']}");
    print("name: ${json['name']}");
    print("age: ${json['age']}");
    print("email: ${json['email']}");
    print("password: ${json['password']}");
    print("role: ${json['role']}");
    print("teamRegisterCode: ${json['teamRegisterCode']}");
    print("phone: ${json['phone']}");
    print("profileImg: $image");
    print("companyName: ${json['companyName']}");
    print("companyEmail: ${json['companyEmail']}");
    print("companyCountry: ${json['companyCountry']}");
    print("companyId: ${json['companyId']}");

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
  static User fromJsonPost(Map<String, dynamic> json) {

    var data = json['data'];
    if (data == null) {
      throw Exception('Invalid response data: data is null');
    }

    var image = data['profileImg'];
    if (image == null || !Uri.tryParse(image)!.hasAbsolutePath) {
      image = 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar.jpg';
    }

    return User(
        id: data['id'] ?? 0, // Provide a default value if 'id' is null
        name: data['name'] ?? '', // Provide a default value if 'name' is null
        age: data['age'] ?? 0, // Provide a default value if 'age' is null
        email: data['email'] ?? '', // Provide a default value if 'email' is null
        password: data['password'] ?? '', // Provide a default value if 'password' is null
        role: data['role'] ?? '', // Provide a default value if 'role' is null
        teamRegisterCode: data['teamRegisterCode'] ?? '', // Provide a default value if 'teamRegisterCode' is null
        phone: data['phone'] ?? '', // Provide a default value if 'phone' is null
        profileImg: image, // Use the validated or default image URL
        companyName: data['companyName'] ?? '', // Provide a default value if 'companyName' is null
        companyEmail: data['companyEmail'] ?? '', // Provide a default value if 'companyEmail' is null
        companyCountry: data['companyCountry'] ?? '', // Provide a default value if 'companyCountry' is null
        companyId: data['companyId'] ?? 0 // Provide a default value if 'companyId' is null
    );
  }

  static Map<String, dynamic> saveUserJSON(User user) {
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