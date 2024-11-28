import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/commen_repository.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/post_repositories.dart';
import 'package:aidmanager_mobile/features/posts/shared/exceptions/posts_exception.dart';
import 'package:aidmanager_mobile/features/projects/shared/helpers/generate_images_project.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Post> userPosts = [];
  List<Post> savedPosts = [];
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
    final userIdLogged = authProvider.user!.id!;
    isLoading = true;

    try {
      selectedPost = await postsRepository.getPostById(postId);
      final savedPosts =
          await postsRepository.getSavedPostsByUser(userIdLogged);

      // creamos un set de IDs de posts guardados para una búsqueda rápida
      final savedPostIds = savedPosts.map((post) => post.id).toSet();

      // actualizar el campo isFavorite en selectedPost
      if (savedPostIds.contains(selectedPost!.id)) {
        selectedPost!.isFavorite = true;
      } else {
        selectedPost!.isFavorite = false; // sino no se setea
      }

      // obtenemols likedPosts(array de Id's) de SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      List<String> likedPosts = prefs.getStringList('likedPosts') ?? [];

      // actualizar el campo hasLiked en selectedPost
      selectedPost!.hasLiked = likedPosts.contains(selectedPost!.id.toString());
    } catch (e) {
      throw ThreadLoadException(
          "Error to display information for post with id: $postId");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPostsCreatedByCurrentUser(int userId) async {
    initialLoading = true;

    try {
      userPosts = await postsRepository.getAllPostsByUser(userId);
    } catch (e) {
      throw InitialPostsLoadException(
          "Error to fetch dialogs by user with id: $userId");
    } finally {
      initialLoading = false;
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
      final Comment actualComment = await commentRepository.createCommentByPostId(postId, newComment);

      selectedPost!.commentsList?.add(actualComment);
    } catch (e) {
      throw PostCommentException(
          "Error to create a new comment in post with id: $postId");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePostById(int postId) async {
    initialLoading = true;

    try {
      await postsRepository.deletePostById(postId);
      userPosts.removeWhere((post) => post.id == postId);
    } catch (e) {
      throw Exception('Failed to delete post with id: $postId');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRating(int postId) async {
    final loggedUserId = authProvider.user!.id!;
    isLoading= true;

    try {
      await postsRepository.updateRatingForPost(postId, loggedUserId);

      // almacenamos los ids de los post likeados en shpres para la persistencia
      // (no estoy seguro de esto kick)
      final prefs = await SharedPreferences.getInstance();
      List<String> likedPosts = prefs.getStringList('likedPosts') ?? [];

      // vericamos si el postId ya está en la lista
      if (likedPosts.contains(postId.toString())) {
        likedPosts.remove(postId.toString());
      } else {
        likedPosts.add(postId.toString());
      }

      // guardamos lista actualizada en SharedPreferences
      await prefs.setStringList('likedPosts', likedPosts);
    } catch (e) {
      throw Exception('Failed to update post with id: $postId');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePost(
    int postId,
    String title,
    String subject,
    String description,
    List<String> images,
  ) async {
    final loggedUserId = authProvider.user!.id!;
    final loggetCompanyId = authProvider.user!.companyId!;

    final postToUpdate = Post(
      title: title,
      subject: subject,
      description: description,
      companyId: loggetCompanyId,
      userId: loggedUserId,
      images: images,
    );

    initialLoading = true;
    notifyListeners();

    try {
      await postsRepository.updatePost(
        postId,
        loggedUserId,
        loggetCompanyId,
        postToUpdate,
      );

      final userPostIndex = userPosts.indexWhere((post) => post.id == postId);
      // actualizamos apra userPosts para que se muestre en la pantalla actual
      if (userPostIndex != -1) {
        userPosts[userPostIndex] = userPosts[userPostIndex].copyWith(
          title: title,
          subject: subject,
          description: description,
          images: images,
        );
      }

      // actualizamos apra "posts" para que se muestre en la pantalla "/posts"
      final postIndex = posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        posts[postIndex] = posts[postIndex].copyWith(
          title: title,
          subject: subject,
          description: description,
          images: images,
        );
      }
    } catch (e) {
      throw Exception("Error to update current post with id: $postId, $e");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSavedPosts(int userId) async {
    initialLoading = true;
    //final loggedUserId = authProvider.user!.id!;

    try {
      final postsList = await postsRepository.getSavedPostsByUser(userId);

      savedPosts = postsList;
    } catch (e) {
      throw PostCreationException("Error to get saved posts");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPostAsSaved(int postId) async {
    final userIdLogged = authProvider.user!.id!;

    initialLoading = true;

    try {
      await postsRepository.addPostAsSave(userIdLogged, postId);
    } catch (e) {
      throw Exception('Save project as favorite');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePostFromSaved(int postId) async {
    final userIdLogged = authProvider.user!.id!;

    initialLoading = true;
    notifyListeners();

    try {
      await postsRepository.deletePostFromSaves(userIdLogged, postId);

      savedPosts.removeWhere((post) => post.id == postId);
    } catch (e) {
      throw Exception('Error to delete post from saved');
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }
}
