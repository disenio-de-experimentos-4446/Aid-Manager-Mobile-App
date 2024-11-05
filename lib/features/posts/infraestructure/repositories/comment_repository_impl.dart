import 'package:aidmanager_mobile/features/posts/domain/datasources/comment_datasource.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/commen_repository.dart';

class CommentRepositoryImpl implements CommentRepository {

  final CommentDatasource datasource;

  CommentRepositoryImpl({required this.datasource});

  @override
  Future<Comment> createCommentByPostId(int postId, Comment comment) {
    return datasource.createCommentByPostId(postId, comment);
  }

  @override
  Future<void> deleteCommentByPostIdAndCommentId(int postId, int commentId) {
    return datasource.deleteCommentByPostIdAndCommentId(postId, commentId);
  }

  @override
  Future<List<Comment>> getAllCommentsFromPost(int postId) {
    return datasource.getAllCommentsFromPost(postId);
  }
  
}