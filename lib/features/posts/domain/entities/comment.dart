class Comment {
  final int? id;
  final int userId;
  final String? userImage;
  final String? userEmail;
  final String? userName;
  final String comment;
  final int? postId;
  final DateTime? commentTime;

  Comment({
    this.id,
    required this.userId,
    this.userImage,
    this.userEmail,
    this.userName,
    required this.comment,
    this.postId,
    this.commentTime,
  });
}