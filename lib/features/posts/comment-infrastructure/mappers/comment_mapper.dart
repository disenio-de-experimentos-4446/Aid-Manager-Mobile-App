import '../../domain/entities/comment.dart';

class CommentMapper {
  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userImage: json['userImage'],
      postId: json['postId'],
      commentTime: json['commentTime'],);
  }

  static Map<String, dynamic> toJson(Comment comment) {
    return {
      'userId': comment.userId,
      'comment': comment.comment,

    };
  }
}