class PostCreationException implements Exception {
  final String message;
  PostCreationException(this.message);

  @override
  String toString() => 'PostCreationException: $message';
}

class InitialPostsLoadException implements Exception {
  final String message;
  InitialPostsLoadException(this.message);

  @override
  String toString() => 'InitialPostsLoadException: $message';
}

class NewPostCreationException implements Exception {
  final String message;
  NewPostCreationException(this.message);

  @override
  String toString() => 'NewPostCreationException: $message';
}

class PostRatingException implements Exception {
  final String message;
  PostRatingException(this.message);

  @override
  String toString() => 'PostRatingException: $message';
}

class PostCommentException implements Exception {
  final String message;
  PostCommentException(this.message);

  @override
  String toString() => 'PostCommentException: $message';
}

class CommentsLoadException implements Exception {
  final String message;
  CommentsLoadException(this.message);

  @override
  String toString() => 'CommentsLoadException: $message';
}


class ThreadLoadException implements Exception {
  final String message;
  ThreadLoadException(this.message);

  @override
  String toString() => 'CommentsLoadException: $message';
}