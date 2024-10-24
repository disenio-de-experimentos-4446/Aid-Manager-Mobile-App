import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';
import 'package:intl/intl.dart';
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

class PostMapper {
  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      description: json['description'],
      postTime: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(json['postTime']),
      companyId: json['companyId'],
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      userImage: json['userImage'],
      rating: json['rating'],
      images: List<String>.from(json['images']),
      commentsList: List<dynamic>.from(json['userList'])
    );
  }

  static Map<String,dynamic> toJson(Post post){
    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    return{
      'title': post.title,
      'subject': post.subject,
      'description': post.description,
      'companyId': post.companyId,
      'userId': post.userId,
      'images': post.images,
    };
  }

}