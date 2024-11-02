class User {
  final int? id;
  final String name;
  final int? age;
  final String email;
  final String password;
  final String? role;
  final String? teamRegisterCode;
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