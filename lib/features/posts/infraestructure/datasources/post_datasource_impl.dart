
import 'package:aidmanager_mobile/features/posts/infraestructure/mappers/post_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/datasources/post_datasource.dart';
import 'dart:io';


class PostDatasourceImpl extends HttpService implements PostsDatasource{
  @override
  Future<void> createPost(Post post) async {
    final requestBody = PostMapper.toJson(post);
    try
    {
      final response = await dio.post(
        '/posts',
        data: requestBody,
      );

      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to create a new Post: ${response.statusCode}');
      }

      if(response.data == null || response.data.isEmpty)
      {
        throw Exception('Failed to create a new Post: Response body is empty');
      }
    }
    catch(e)
    {
      throw Exception('Failed to create a new Post: $e');
    }

  }

  @override
  Future<void> deletePostById(int id) async{
     try {
      final postFounded = await dio.get('/posts/$id');

      if(postFounded.statusCode != HttpStatus.ok || postFounded.data == null || postFounded.data.isEmpty) {
        throw Exception('Post with id $id does not exist');
      }

      final deleteResponse = await dio.delete('/posts/$id');

      if(deleteResponse.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete post with id: $id ${deleteResponse.statusCode}');
      }

    } catch (e) {
      throw Exception('Failed to delete post with id: $id, $e');
    }
  }

  @override
  Future<Post> getPostById(int id) async{
    try{
        final response = await dio.get('/posts/$id');

        if(response.statusCode != HttpStatus.ok || response.data == null || response.data.isEmpty)
        {
          throw Exception('Failed to get post with id: $id');
        }

        return PostMapper.fromJson(response.data);
    }
    catch(e)
    {
      throw Exception('Failed to get post with id: $id, $e');
    }

  }

  @override
  Future<List<Post>> getPosts(int companyId) async{
    try{
      final response = await dio.get('/posts/$companyId');

      if(response.statusCode != HttpStatus.ok || response.data == null || response.data.isEmpty)
      {
        throw Exception('Failed to get posts');
      }
      final List<dynamic> postsJson = response.data;
      return postsJson.map((json) => PostMapper.fromJson(json)).toList();
    }
    catch(e)
    {
      throw Exception('Failed to get posts, $e');

    }
  }

  @override //This updates the rating of a post
  Future<void> updatePostById(int id) async{
    try
    {
      final response = await dio.patch('/posts/$id/rating');
      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to update posts');
      }
    }
    catch(e)
    {
      throw Exception('Failed to update posts, $e');

    }
  }
}