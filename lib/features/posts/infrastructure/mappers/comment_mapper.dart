import '../../domain/entities/comment.dart';

class CommentMapper {
  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'], // Ensure this is an int
      userId: json['userId'],
      comment: json['comment'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userImage: json['userImage'],
      commentTime: json['commentTime'],
    );
  }
}