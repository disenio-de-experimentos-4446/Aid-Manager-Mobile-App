class LoginResponse {
  final int id;
  final String token;

  /// Crea una instancia de [LoginResponse] con el [id] y [token] dados.
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

  /// Crea una instancia de [DirectorData] con [firstName], [lastName], [email], y [password].
  DirectorData(this.firstName, this.lastName, this.email, this.password);
}
