import 'package:aidmanager_mobile/features/posts/domain/datasources/comment_datasource.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/commen_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentDatasource datasource;

  CommentRepositoryImpl({required this.datasource});

  @override
  Future<void> createCommentByPostId(int postId, Comment comment) {
    return datasource.createCommentByPostId(postId, comment);
  }
}