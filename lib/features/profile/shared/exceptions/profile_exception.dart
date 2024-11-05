class UserProfileUpdateFailedException implements Exception {
  final String message;
  UserProfileUpdateFailedException(this.message);

  @override
  String toString() => message;
}

class ImageUploadFailedException implements Exception {
  final String message;
  ImageUploadFailedException(this.message);

  @override
  String toString() => message;
}