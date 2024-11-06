class Company {
  final int? id;
  final String companyName;
  final String country;
  final String email;
  final int? managerId;
  final String? teamRegisterCode;

  Company({
    this.id,
    required this.companyName,
    required this.country,
    required this.email,
    this.managerId,
    this.teamRegisterCode,
  });

  // método para crear una instancia de Company desde un JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['companyName'],
      country: json['country'],
      email: json['email'],
      managerId: json['managerId'],
      teamRegisterCode: json['teamRegisterCode'],
    );
  }
}