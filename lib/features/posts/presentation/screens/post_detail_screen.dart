import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/post_card.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/comment_card.dart';
import 'package:aidmanager_mobile/shared/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/comment.dart';
import '../providers/comment_provider.dart';
import '../providers/post_provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  static const String name = "posts_detail_screen";

  const PostDetailScreen({super.key, required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isExpanded = false;
  int commentsToShow = 3; // Number of comments to show initially


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.go('/posts');
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 32.0,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 32.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Save logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/hotman-placeholder.jpg'),
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Titulo del Post', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('nombre usuario', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (String result) {
                          if (result == 'delete') {
                            // Acción de borrar
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete Post'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('SubjectDelPost', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200)),
                    ],
                  ),
                  Text(
                    'This is a long text that will be truncated if it exceeds the maximum number of lines aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa. This is a long text that will be truncated if it exceeds the maximum number of lines.',
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Color(0xFF008A66)),
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(isExpanded ? 'See Less' : 'See More'),
                  ),
                  SizedBox(
                    height: 225,
                    child: CarouselView(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      itemExtent: MediaQuery.sizeOf(context).width - 96,
                      padding: const EdgeInsets.only(right: 10),
                      itemSnapping: true,
                      elevation: 4.0,
                      children: List.generate(
                        10,
                            (int index) => Image.network(
                          'https://img.freepik.com/premium-photo/woman-with-backpack-stands-mountain-top-looking-beautiful-sunset_188544-54443.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              // Acción del botón
                            },
                          ),
                          Text('0'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('0'),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              GoRouter.of(context).go('/posts/1');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('2024/10/10 - 13:00'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: commentsToShow, // Number of comments to show
              itemBuilder: (context, index) {
                return CommentCard(
                  userName: 'User $index',
                  commentText: 'This is a comment from user $index.',
                  userImage: 'assets/images/hotman-placeholder.jpg',
                  commentTime: '2024/10/10 - 13:00',
                );
              },
            ),
            if (commentsToShow < 10) // Show button if there are more comments to load
              TextButton(
                onPressed: () {
                  setState(() {
                    commentsToShow += 3; // Load 3 more comments
                  });
                },
                child: Text('See More'),
              ),
          ],
        ),
      ),
    );
  }
}

void _showCreateCommentDialog(BuildContext context, int postId) {
  final TextEditingController _commentController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Comment'),
        content: TextField(
          controller: _commentController,
          decoration: InputDecoration(hintText: "Enter your comment"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              final comment = Comment(
                id: 0,
                userId: 0, // Replace with actual user ID
                userImage: 'string', // Replace with actual user image
                userEmail: 'string', // Replace with actual user email
                userName: 'string', // Replace with actual user name
                comment: _commentController.text,
                postId: postId,
                commentTime: DateTime.now().toIso8601String(),              );
              int userId = 3;
              Provider.of<CommentProvider>(context, listen: false).createNewComment(postId, "osi", userId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}