import 'package:aidmanager_mobile/features/posts/domain/entities/post/post.dart';

abstract class PostsRepository {
  Future<void> createPost(Post post);
  Future<List<Post>> getPosts();
  Future<Post> getPostById(int id);
  Future<void> updatePostById(int id, Post post);
  Future<void> deletePostById(int id);
}