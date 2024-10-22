class User {
  final int? id;
  final String name;
  final int? age;
  final String email;
  final String password;
  final String role;
  final String teamRegisterCode;
  final String? phone;
  final String? profileImg;
  final String? companyName;
  final String? companyEmail;
  final String? companyCountry;
  final int? companyId;

  User({
    this.id,
    required this.name,
    this.age,
    required this.email,
    required this.password,
    required this.role,
    required this.teamRegisterCode,
    this.phone,
    this.profileImg,
    this.companyName,
    this.companyEmail,
    this.companyCountry,
    this.companyId
  });

}

class AuthResponse {
  final int id;
  final String token;

  AuthResponse({
    required this.id,
    required this.token,
  });
}

class DirectorData {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  DirectorData(this.firstName, this.lastName, this.email, this.password);
}