class Comment {
  final int? id;
  final String comment;
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userImage;
  final int postId;
  final String? commentTime;

  Comment({
    this.id,
    required this.comment,
    required this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
    required this.postId,
    this.commentTime
  });
}
