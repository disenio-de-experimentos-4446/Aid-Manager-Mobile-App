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
    this.companyId,
  });

  // este metodo propio de mi entidad User es para crear una copia de la instancia
  // para actualizar campos especificos, en este caso para el profileImage
  // (revisar profile_provider para mayor claridad osisi)
  User copyWith({
    int? id,
    String? name,
    int? age,
    String? email,
    String? password,
    String? role,
    String? teamRegisterCode,
    String? phone,
    String? profileImg,
    String? companyName,
    String? companyEmail,
    String? companyCountry,
    int? companyId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      teamRegisterCode: teamRegisterCode ?? this.teamRegisterCode,
      phone: phone ?? this.phone,
      profileImg: profileImg ?? this.profileImg,
      companyName: companyName ?? this.companyName,
      companyEmail: companyEmail ?? this.companyEmail,
      companyCountry: companyCountry ?? this.companyCountry,
      companyId: companyId ?? this.companyId,
    );
  }
}
