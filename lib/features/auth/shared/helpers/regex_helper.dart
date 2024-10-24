class RegexHelper {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // Al menos 8 caracteres, una letra mayúscula, una letra minúscula y un número
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Formato de número de teléfono internacional
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  static bool isValidUsername(String username) {
    // Alfanumérico, entre 3 y 16 caracteres
    final usernameRegex = RegExp(r'^[a-zA-Z0-9]{3,16}$');
    return usernameRegex.hasMatch(username);
  }
}