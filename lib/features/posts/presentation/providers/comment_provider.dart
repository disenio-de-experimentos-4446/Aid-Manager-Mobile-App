

import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/commen_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class CommentProvider extends ChangeNotifier {
  final CommentRepository commentRepository;
  AuthProvider authProvider;

  CommentProvider({required this.authProvider, required this.commentRepository});

  bool initialLoading = false;
  bool isLoading = false;
  bool updateLoading = false;
  List<Comment> _Comment = [];
  Comment? _selectedComment;

  Future<void> loadInitialCommentsByPostId(int postId) async {
    initialLoading = true;
    try {
      _Comment = await commentRepository.getAllCommentsFromPost(postId);
    } catch (e) {
      throw Exception('Failed to fetch comments by post with id: $postId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteComment(int postId,int commentId) async{
    isLoading = true;
    try {
      await commentRepository.deleteCommentByPostIdAndCommentId(postId,commentId);
    } catch (e) {
      throw Exception('Failed to fetch comment with id: $commentId');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewComment(
    int postId,
    String content,
    int userId,
  ) async {
    final newComment = Comment(
      postId: postId,
      userId: userId,
      comment: content,
    );

    try {
      await commentRepository.createCommentByPostId(postId, newComment);
    } catch (e) {
      throw Exception('Failed to create a new comment');
    }
  }

}