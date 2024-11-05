import 'dart:convert';
import 'dart:io';

import 'package:aidmanager_mobile/features/posts/domain/datasources/comment_datasource.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:aidmanager_mobile/features/posts/infraestructure/mappers/comment_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

class CommentDatasourceImpl extends HttpService implements CommentDatasource {

  @override
  Future<Comment> createCommentByPostId(int postId, Comment comment) async {
    
    final requestBody = CommentMapper.toJson(comment);

    try {
      
      final response = await dio.post(
        '/posts/$postId/comments',
        data: jsonEncode(requestBody),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to create a new Post: ${response.statusCode}');
      }

      final createdComment = CommentMapper.fromJson(response.data);

      return createdComment;
    } catch (e) {
      throw Exception('Failed to create a new comment: $e');
    }

  }

  @override
  Future<void> deleteCommentByPostIdAndCommentId(int postId, int commentId) {
    // TODO: implement deleteCommentByPostIdAndCommentId
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> getAllCommentsFromPost(int postId) {
    // TODO: implement getAllCommentsFromPost
    throw UnimplementedError();
  }
  
}