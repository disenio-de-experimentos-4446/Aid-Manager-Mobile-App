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
    Future<void> updateRatingForPost(int postId) {
        return datasource.updateRatingForPost(postId);
    }
    

}