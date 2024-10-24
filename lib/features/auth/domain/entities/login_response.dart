class LoginResponse {
  final int id;
  final String token;

  LoginResponse({
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