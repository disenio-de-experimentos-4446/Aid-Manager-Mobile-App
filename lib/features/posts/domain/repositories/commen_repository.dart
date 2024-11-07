import '../entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getAllCommentsFromPost(int postId);
  Future<Comment> createCommentByPostId(int postId, Comment comment);
  Future<void> deleteCommentByPostIdAndCommentId(int postId, int commentId);
}
