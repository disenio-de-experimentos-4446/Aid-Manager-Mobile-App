import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

abstract class PostsDatasource {
  Future<void> createPost(Post post);
  Future<List<Post>> getPosts(int companyId);
  Future<Post> getPostById(int id);
  Future<void> updatePostById(int id, Post post);
  Future<void> deletePostById(int id);
}