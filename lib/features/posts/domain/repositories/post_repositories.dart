import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<void> createPost(Post post);
  Future<List<Post>> getPosts(int companyId);
  Future<Post> getPostById(int id);
  Future<void> updatePostById(int id);
  Future<void> deletePostById(int id);
}