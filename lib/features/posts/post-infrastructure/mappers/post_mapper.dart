
import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';

class PostMapper {
  static Post fromJson(Map<String, dynamic> json) {

    var image = json['userImage'];
    if (!Uri.tryParse(image)!.hasAbsolutePath){
      image = 'noImage';
    }

    return Post(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      description: json['description'],
      postTime: json['postTime'] != null ? DateTime.parse(json['postTime']) : null,
      companyId: json['companyId'],
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      userImage: image,
      rating: json['rating'],
      images: json['images'] != null ? List<dynamic>.from(json['images']) : [],
      commentsList: json['commentsList'] != null ? List<dynamic>.from(json['commentsList']) : [],

    );
  }

  static Map<String,dynamic> toJson(Post post){
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