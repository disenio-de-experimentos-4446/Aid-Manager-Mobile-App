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
  Future<void> updateRatingForPost(int postId, int userId) async{
    try
    {
      final response = await dio.patch('/posts/$postId/rating/$userId');
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

  @override
  Future<List<Post>> getAllPostsByUser(int userId) async {
    try {    
      final response = await dio.get('/posts/user/$userId');

      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to get posts by user');
      }

      final List<dynamic> postsJson = response.data;
      return postsJson.map((json) => PostMapper.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Failed to get all posts created by user with id: $userId, $e');
    }
  }

  @override
  Future<List<Post>> getLikedPostsByUser(int userId) async {
    try {    
      final response = await dio.get('/posts/liked/$userId');

      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to get liked posts');
      }

      final List<dynamic> postsJson = response.data;
      return postsJson.map((json) => PostMapper.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Failed to get liked posts by user with id: $userId, $e');
    }
  }

  @override
  Future<void> updatePost(int postId, int userId, int companyId, Post post) async {
    
    final requestBody = PostMapper.toJson(post);

    try {
      final response = await dio.put(
        '/posts/$postId/update/$userId/company/$companyId',
        data: jsonEncode(requestBody)
      );

      if(response.statusCode != HttpStatus.ok) 
      {
        throw Exception('Failed to update post with id: $postId');
      }
    } catch (e) {
      throw Exception('Failed to update post by id: $userId, $e');
    }
    
  }
  
  @override
  Future<void> addPostAsSave(int userId, int postId) async {
    final requestBody = jsonEncode({
      'postId': postId,
      'userId': userId,
    });

    try {
      final response = await dio.post(
        '/posts/post-interaction',
        data: requestBody
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to save post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add post to saved with id: $postId');
    }
  }
  
  @override
  Future<void> deletePostFromSaves(int userId, int postId) async {

    final requestBody = jsonEncode({
      'postId': postId,
      'userId': userId,
    });

    try {
      final response = await dio.delete(
        '/posts/post-interaction',
        data: requestBody,
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete a post from saves: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete a post from saves: $e');
    }
  }

  @override
  Future<List<Post>> getSavedPostsByUser(int userId) async {
    try {    
      final response = await dio.get('/posts/post-interaction/user/$userId');

      if(response.statusCode != HttpStatus.ok)
      {
        throw Exception('Failed to get saved posts');
      }

      final List<dynamic> postsJson = response.data;
      return postsJson.map((json) => PostMapper.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Failed to get saved posts by user with id: $userId, $e');
    }
  }
  
  
}