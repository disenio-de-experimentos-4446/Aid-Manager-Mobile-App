class Comment {
  final int? id;
  final String comment;
  final int userId;
  final String? userName;
  final String? userEmail;
  final String? userImage;
  final int? postId;
  final DateTime? commentTime;

  Comment({
    this.id,
    required this.comment,
    required this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
    this.postId,
    this.commentTime
  });
}
