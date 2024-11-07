import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/commen_repository.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/post_repositories.dart';
import 'package:aidmanager_mobile/features/posts/shared/exceptions/posts_exception.dart';
import 'package:aidmanager_mobile/features/projects/shared/helpers/generate_images_project.dart';
import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier {
  final PostsRepository postsRepository;
  final CommentRepository commentRepository;
  AuthProvider authProvider;

  PostProvider({
    required this.authProvider,
    required this.postsRepository,
    required this.commentRepository,
  });

  bool initialLoading = false;
  bool isLoading = false;
  bool updateLoading = false;
  List<Post> posts = [];
  Post? selectedPost;

  Future<void> loadInitialPostsByCompanyId() async {
    initialLoading = true;
    final companyId = authProvider.user!.companyId!;
    try {
      posts = await postsRepository.getPostsByCompanyId(companyId);
    } catch (e) {
      throw InitialPostsLoadException(
          "Error to fetch dialogs by company with id: $companyId");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadThreadByPost(int postId) async {
    isLoading = true;

    try {
      selectedPost = await postsRepository.getPostById(postId);
    } catch (e) {
      throw ThreadLoadException(
          "Error to display information for post with id: $postId");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewPost(
    String title,
    String subject,
    String description,
  ) async {
    final companyId = authProvider.user!.companyId!;
    final loggedUserId = authProvider.user!.id!;

    final newPost = Post(
      title: title,
      description: description,
      subject: subject,
      companyId: companyId,
      userId: loggedUserId,
      images: generateRandomImages(3),
    );

    isLoading = true;
    notifyListeners();

    try {
      final Post createdPost = await postsRepository.createPost(newPost);
      posts.insert(0, createdPost);
      notifyListeners();
    } catch (e) {
      throw PostCreationException("Error to create project");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewCommentInPost(int postId, String comment) async {
    final loggedUserId = authProvider.user!.id!;

    final newComment = Comment(
      userId: loggedUserId,
      comment: comment,
    );

    isLoading = true;
    notifyListeners();

    try {
      final Comment actualComment =
          await commentRepository.createCommentByPostId(postId, newComment);
      // convertimos la data y la convertimos para a la entidad correspondiente a un objeto de "commentsList"
      final CommentPost commentPost = CommentPost.fromComment(actualComment);

      selectedPost!.commentsList?.add(commentPost);
    } catch (e) {
      throw PostCommentException(
          "Error to create a new comment in post with id: $postId");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePostById(int id) async {
    try {
      // await postsRepository.deletePostById(id);
    } catch (e) {
      throw Exception('Failed to delete post with id: $id');
    }
  }

  Future<void> updateRating(int id) async {
    updateLoading = true;

    try {
      await postsRepository.updateRatingForPost(id);
    } catch (e) {
      throw Exception('Failed to update post with id: $id');
    } finally {
      updateLoading = false;
      notifyListeners();
    }
  }
}
