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

  static Map<String, dynamic> toJson(Comment comment) {
    return {
      'id': comment.id,
      'postId': comment.postId, // Ensure this is an int
      'userId': comment.userId,
      'comment': comment.comment,
      'userName': comment.userName,
      'userEmail': comment.userEmail,
      'userImage': comment.userImage,
      'commentTime': comment.commentTime,
    };
  }
}