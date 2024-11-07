import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';

class Post {
  int? id;
  String title;
  String subject;
  String description;
  DateTime? postTime;
  int companyId;
  int userId;
  String? userName;
  String? email;
  String? userImage;
  int? rating;
  List<String> images;
  List<CommentPost>? commentsList;

  Post({
    this.id,
    required this.title,
    required this.subject,
    required this.description,
    this.postTime,
    required this.companyId,
    required this.userId,
    this.userName,
    this.email,
    this.userImage,
    this.rating,
    required this.images,
    this.commentsList,
  });

}

class CommentPost {
  final int id;
  final int userId;
  final String authorImage;
  final String authorEmail;
  final String authorName;
  final String comment;
  final int postId;
  final DateTime timeOfComment;

  CommentPost({
    required this.id,
    required this.userId,
    required this.authorImage,
    required this.authorEmail,
    required this.authorName,
    required this.comment,
    required this.postId,
    required this.timeOfComment,
  });

  // metodo de conversion para commnet to CommentPost
  factory CommentPost.fromComment(Comment comment) {
    return CommentPost(
      id: comment.id ?? 0,
      userId: comment.userId,
      authorImage: comment.userImage ?? '',
      authorEmail: comment.userEmail ?? '',
      authorName: comment.userName ?? '',
      comment: comment.comment,
      postId: comment.postId ?? 0,
      timeOfComment: comment.commentTime ?? DateTime.now(),
    );
  }
}