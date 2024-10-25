import 'package:aidmanager_mobile/features/posts/domain/datasources/post_datasource.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/repositories/post_repositories.dart';

class PostRepositoryImpl implements PostsRepository {
    final PostsDatasource datasource;

    PostRepositoryImpl({required this.datasource});

    @override
    Future<void> createPost(Post post) {
        return datasource.createPost(post);
    }

    @override
    Future<void> deletePostById(int id) {
        return datasource.deletePostById(id);
    }

    @override
    Future<Post> getPostById(int id) {
        return datasource.getPostById(id);
    }

    @override
    Future<List<Post>> getPosts(int companyId) {
        return datasource.getPosts(companyId);
    }

    @override
    Future<void> updatePostById(int id) {
        return datasource.updatePostById(id);
    }
    

}