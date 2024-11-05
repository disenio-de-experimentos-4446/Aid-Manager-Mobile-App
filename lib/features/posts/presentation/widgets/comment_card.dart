import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String userName;
  final String commentTime;
  final String commentText;
  final String userImage;

  const CommentCard({
    super.key,
    required this.userName,
    required this.commentText,
    required this.userImage,
    required this.commentTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: _isValidUrl(userImage) == true ?
        NetworkImage(userImage) : AssetImage('assets/images/defaultavatar.jpg'),
      ),
      title: Text(userName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(commentText),
          Text(commentTime),
        ],
      ),
      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),

    );
  }

  _isValidUrl(String userImage) {
    return Uri.tryParse(userImage)?.hasAbsolutePath ?? false;
  }
}