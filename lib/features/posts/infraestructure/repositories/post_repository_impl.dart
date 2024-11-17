import 'package:aidmanager_mobile/features/posts/domain/datasources/post_datasource.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/post_repositories.dart';

class PostRepositoryImpl implements PostsRepository {
  final PostsDatasource datasource;

  PostRepositoryImpl({required this.datasource});

  @override
  Future<Post> createPost(Post post) {
    return datasource.createPost(post);
  }

  @override
  Future<void> deletePostById(int postId) {
    return datasource.deletePostById(postId);
  }

  @override
  Future<Post> getPostById(int postId) {
    return datasource.getPostById(postId);
  }

  @override
  Future<List<Post>> getPostsByCompanyId(int companyId) {
    return datasource.getPostsByCompanyId(companyId);
  }

  @override
  Future<void> updateRatingForPost(int postId, int userId, double rating) {
    return datasource.updateRatingForPost(postId, userId, rating);
  }

  @override
  Future<List<Post>> getAllPostsByUser(int userId) {
    return datasource.getAllPostsByUser(userId);
  }

  @override
  Future<List<Post>> getSavedPostsByUser(int userId) {
    return datasource.getSavedPostsByUser(userId);
  }

  @override
  Future<void> updatePost(int postId, int userId, int companyId, Post post) {
    return datasource.updatePost(postId, userId, companyId, post);
  }
  
  @override
  Future<void> addPostAsSave(int userId, int postId) {
    return datasource.addPostAsSave(userId, postId);
  }
  
  @override
  Future<void> deletePostFromSaves(int userId, int postId) {
    return datasource.deletePostFromSaves(userId, postId);
  }
  
  @override
  Future<void> getLikedPostsByUser(int userId) {
    return datasource.getLikedPostsByUser(userId);
  }
}
