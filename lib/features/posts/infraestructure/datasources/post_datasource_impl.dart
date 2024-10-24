import 'dart:convert';
import 'dart:io';

import 'package:aidmanager_mobile/shared/service/http_service.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post/post.dart';
import 'package:aidmanager_mobile/features/posts/domain/datasources/post_datasource.dart';

class PostDatasourceImpl extends HttpService implements PostsDatasource{
  @override
  Future<void> createPost(Post post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePostById(int id) {
    // TODO: implement deletePostById
    throw UnimplementedError();
  }

  @override
  Future<Post> getPostById(int id) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<void> updatePostById(int id, Post post) {
    // TODO: implement updatePostById
    throw UnimplementedError();
  }
}