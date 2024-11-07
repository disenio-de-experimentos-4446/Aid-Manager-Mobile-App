import 'package:flutter/cupertino.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/commen_repository.dart';

class CommentProvider extends ChangeNotifier {
  final CommentRepository commentRepository;
  AuthProvider authProvider;

  CommentProvider(
      {required this.authProvider, required this.commentRepository});

  bool isLoading = false;
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> loadCommentsByPostId(int postId) async {
    isLoading = true;
    notifyListeners();
    try {
      _comments = await commentRepository.getAllCommentsFromPost(postId);
    } catch (e) {
      throw Exception('Failed to fetch comments by post with id: $postId');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewComment(int postId, String content, int userId) async {
    isLoading = true;
    notifyListeners();

    final newComment = Comment(
      id: 0,
      postId: postId,
      comment: content,
      userId: userId,

    );

    try {
      await commentRepository.createCommentByPostId(postId, newComment);
      _comments.add(newComment);
    } catch (e) {
      throw Exception('Failed to create a new comment');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}