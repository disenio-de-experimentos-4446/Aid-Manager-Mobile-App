import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';

abstract class CommentDatasource {
  Future<List<Comment>> getAllCommentsFromPost(int postId);
  Future<void> createCommentByPostId(int postId, Comment comment);
  Future<void> deleteCommentByPostIdAndCommentId(int postId, int commentId);
}
