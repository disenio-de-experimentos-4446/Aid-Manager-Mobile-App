import 'package:aidmanager_mobile/features/posts/domain/entities/comment.dart';

class Post {
  int? id;
  String title;
  String subject;
  String description;
  DateTime? postTime;
  int companyId;
  int userId;
  String? userName;
  String? email;
  String? userImage;
  int? rating;
  List<String> images;
  List<Comment>? commentsList;
  bool isFavorite;
  bool hasLiked;

  Post({
    this.id,
    required this.title,
    required this.subject,
    required this.description,
    this.postTime,
    required this.companyId,
    required this.userId,
    this.userName,
    this.email,
    this.userImage,
    this.rating,
    required this.images,
    this.commentsList,
    bool? isFavorite,
    bool? hasLiked,
  })  : isFavorite = isFavorite ?? false,
        hasLiked = hasLiked ?? false;

  // copy to update only necessary fields (pa no mandar toda la wea pa updatear)
  Post copyWith({
    int? id,
    String? title,
    String? subject,
    String? description,
    DateTime? postTime,
    int? companyId,
    int? userId,
    String? userName,
    String? userImage,
    String? email,
    int? rating,
    List<String>? images,
    List<Comment>? commentsList,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      postTime: postTime ?? this.postTime,
      companyId: companyId ?? this.companyId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      email: email ?? this.email,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      commentsList: commentsList ?? this.commentsList,
    );
  }
}
