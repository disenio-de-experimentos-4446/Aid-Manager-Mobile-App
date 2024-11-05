import 'dart:convert';
import 'package:aidmanager_mobile/features/posts/infraestructure/mappers/post_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/datasources/post_datasource.dart';
import 'dart:io';


class PostDatasourceImpl extends HttpService implements PostsDatasource{
  @override
  Future<Post> createPost(Post post) async {
    final requestBody = PostMapper.toJson(post);
    try {
      final response = await dio.post(
        '/posts',
        data: jsonEncode(requestBody),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to create a new Post: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to create a new Post: Response body is empty');
      }

      final createdPost = PostMapper.fromJson(response.data);

      return createdPost;
    } catch (e) {
      throw Exception('Failed to create a new Post: $e');
    }
  }

  @override
  Future<void> deletePostById(int postId) async{
     try {
      final postFounded = await dio.get('/posts/$postId');

      if(postFounded.statusCode != HttpStatus.ok || postFounded.data == null || postFounded.data.isEmpty) {
        throw Exception('Post with id $postId does not exist');
      }

      final deleteResponse = await dio.delete('/posts/$postId');

      if(deleteResponse.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete post with id: $postId ${deleteResponse.statusCode}');
      }

    } catch (e) {
      throw Exception('Failed to delete post with id: $postId, $e');
    }
  }

  @override
  Future<Post> getPostById(int postId) async{
    try{
        final response = await dio.get('/posts/$postId');

        if(response.statusCode != HttpStatus.ok || response.data == null || response.data.isEmpty)
        {
          throw Exception('Failed to get post with id: $postId');
        }

        return PostMapper.fromJson(response.data);
    }
    catch(e)
    {
      throw Exception('Failed to get post with id: $postId, $e');
    }

  }

  @override
  Future<List<Post>> getPostsByCompanyId(int companyId) async{
    try{
      final response = await dio.get('/posts/company/$companyId');

      if(response.statusCode != HttpStatus.ok)
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
  Future<void> updateRatingForPost(int postId) async{
    try
    {
      final response = await dio.patch('/posts/$postId/rating');
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