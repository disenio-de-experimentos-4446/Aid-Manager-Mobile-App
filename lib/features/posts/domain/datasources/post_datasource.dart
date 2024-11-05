import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

abstract class PostsDatasource {
  Future<Post> createPost(Post post);
  Future<List<Post>> getPostsByCompanyId(int companyId);
  Future<Post> getPostById(int postId);
  Future<void> updateRatingForPost(int postId);
  Future<void> deletePostById(int postId);
}