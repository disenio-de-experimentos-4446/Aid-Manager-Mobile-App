
class Post {
  int? id;
  String title;
  String subject;
  String description;
  DateTime? postTime;
  int companyId;
  int userId;
  String userName;
  String email;
  String userImage;
  int rating;
  List<dynamic> images;
  List<dynamic> commentsList;

  Post({
    this.id,
    required this.title,
    required this.subject,
    required this.description,
    this.postTime,
    required this.companyId,
    required this.userId,
    required this.userName,
    required this.email,
    required this.userImage,
    required this.rating,
    required this.images,
    required this.commentsList,
  });

}