import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';

class CommentMapper {
  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      userImage: json['userImage'],
      userEmail: json['userEmail'],
      userName: json['userName'],
      comment: json['comment'],
      postId: json['postId'],
      commentTime: json['commentTime'] != null
          ? DateTime.parse(json['commentTime'])
          : null,
    );
  }

  static Map<String, dynamic> toJson(Comment commentPost) {
    return {
      'userId': commentPost.userId,
      'comment': commentPost.comment,
    };
  }
}
