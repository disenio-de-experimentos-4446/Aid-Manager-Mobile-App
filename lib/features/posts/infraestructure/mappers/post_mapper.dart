import 'package:intl/intl.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post/post.dart';

class PostMapper {
  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      Id: json['id'],
      Title: json['title'],
      Description: json['Description'],
      createdAt: DateFormat('yyyy-MM-dd').parse(json['createdAt']),
      updatedAt: DateFormat('yyyy-MM-dd').parse(json['updatedAt']),
    );
  }
}
