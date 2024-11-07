import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

class PostMapper {
  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      description: json['description'],
      postTime:
          json['postTime'] != null ? DateTime.parse(json['postTime']) : null,
      companyId: json['companyId'],
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      userImage: json['userImage'],
      rating: json['rating'],
      images: List<String>.from(json['images']),
      commentsList: json['commentsList'] != null
          ? List<CommentPost>.from(
              json['commentsList']
                  .map((comment) => CommentPostMapper.fromJson(comment)),
            )
          : null,
    );
  }

  static Map<String, dynamic> toJson(Post post) {
    return {
      'title': post.title,
      'subject': post.subject,
      'description': post.description,
      'companyId': post.companyId,
      'userId': post.userId,
      'images': post.images,
    };
  }
}

class CommentPostMapper {
  static CommentPost fromJson(Map<String, dynamic> json) {
    return CommentPost(
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

  static Map<String, dynamic> toJson(CommentPost commentPost) {
    return {
      'id': commentPost.id,
      'userId': commentPost.userId,
      'authorImage': commentPost.authorImage,
      'authorEmail': commentPost.authorEmail,
      'authorName': commentPost.authorName,
      'comment': commentPost.comment,
      'postId': commentPost.postId,
      'timeOfComment': commentPost.timeOfComment.toIso8601String(),
    };
  }
}
