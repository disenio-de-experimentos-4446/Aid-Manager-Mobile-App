class Comment {
  int id;
  int userId;
  String authorImage;
  String authorEmail;
  String authorName;
  String comment;
  int postId;
  DateTime timeOfComment;

  Comment({
    required this.id,
    required this.userId,
    required this.authorImage,
    required this.authorEmail,
    required this.authorName,
    required this.comment,
    required this.postId,
    required this.timeOfComment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      authorImage: json['authorImage'],
      authorEmail: json['authorEmail'],
      authorName: json['authorName'],
      comment: json['comment'],
      postId: json['postId'],
      timeOfComment: DateTime.parse(json['timeOfComment']),
    );
  }
}