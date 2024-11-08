bool validateFields(
    String firstName, String lastName, String email, String password) {
  if (firstName.isEmpty ||
      lastName.isEmpty ||
      email.isEmpty ||
      password.isEmpty) {
    return false;
  }
  return true;
}