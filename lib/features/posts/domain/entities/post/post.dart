class Post {
  int? Id;
  String Title;
  String Description;
  DateTime PostTime;
  int CompanyId;
  int UserId;
  String UserName;
  String Email;
  String UserImage;
  int Rating;
  List<String> Images;
  List<dynamic> Comments;

  Post({
    this.Id,
    required this.Title,
    required this.Description,
    required this.PostTime,
    required this.CompanyId,
    required this.UserId,
    required this.UserName,
    required this.Email,
    required this.UserImage,
    required this.Rating,
    required this.Images,
    required this.Comments
  });
  

}