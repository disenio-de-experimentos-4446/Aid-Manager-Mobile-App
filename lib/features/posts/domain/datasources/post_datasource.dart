import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

abstract class PostsDatasource {
  Future<Post> createPost(Post post);
  Future<List<Post>> getPostsByCompanyId(int companyId);
  Future<Post> getPostById(int postId);
  Future<void> updateRatingForPost(int postId, int userId);
  Future<void> updatePost(int postId, int userId, int companyId, Post post);
  Future<void> deletePostById(int postId);
  Future<void> getLikedPostsByUser(int userId);
  Future<List<Post>> getAllPostsByUser(int userId);
  Future<void> addPostAsSave(int userId, int postId);
  Future<void> deletePostFromSaves(int userId, int postId);
  Future<List<Post>> getSavedPostsByUser(int userId);
}