import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../shared/helpers/storage_helper.dart';
import '../../../profile/domain/entities/user.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../providers/comment_provider.dart';
import '../providers/post_provider.dart';
import '../widgets/comment_card.dart';

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
  Post? post;
  User? user;

  @override
  void initState() {
    super.initState();
    _loadPostData();
    _loadUserData();
    _loadCommentData();
  }

  Future<void> _loadPostData() async {
    var postId = int.parse(widget.postId);
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    post = await postProvider.getPostById(postId);
    setState(() {});
  }

  Future<void> _loadCommentData() async {
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    await commentProvider.loadCommentsByPostId(int.parse(widget.postId));
    setState(() {});
  }

  Future<void> _loadUserData() async {
    user = await StorageHelper.getUser();
    setState(() {});
  }

  Future<void> _createComment(String comment) async {
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    await commentProvider.createNewComment(int.parse(widget.postId), comment, user!.id!);
    _loadCommentData();
    _loadPostData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    final commentProvider = Provider.of<CommentProvider>(context);

    bool _isValidUrl(String url) {
      print("Is valid image? " + url);
      return Uri.tryParse(url)?.hasAbsolutePath ?? false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: post == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              color: Color(0xFFE6EEEC),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: _isValidUrl(post!.userImage)
                              ? NetworkImage(post!.userImage)
                              : AssetImage(
                              'assets/images/profile-placeholder.jpg'),
                          radius: 25,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post!.title, style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold)),
                              Text(post!.userName, style: TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (String result) {
                            if (result == 'delete') {
                              // Acción de borrar
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete Post'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      post!.subject,
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w200),
                    ),
                    Text(
                      post!.description,
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded ? TextOverflow.visible : TextOverflow
                          .ellipsis,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Color(
                            0xFF008A66)),
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
                        itemExtent: post!.images.length > 1
                            ? MediaQuery
                            .sizeOf(context)
                            .width - 96
                            : MediaQuery
                            .sizeOf(context)
                            .width,
                        padding: post!.images.length > 1
                            ? const EdgeInsets.only(right: 10)
                            : const EdgeInsets.only(right: 0),
                        itemSnapping: true,
                        elevation: 4.0,
                        children: post!.images.length > 1
                            ? post!.images.map((image) {
                          return _isValidUrl(image)
                              ? Image.network(image, fit: BoxFit.cover)
                              : Image.asset(
                              'assets/images/profile-placeholder.jpg',
                              fit: BoxFit.cover);
                        }).toList()
                            : [Image.asset(
                            'assets/images/profile-placeholder.jpg',
                            fit: BoxFit.cover)
                        ],
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
                            Text(post!.rating.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(post!.commentsList.length.toString()),
                            IconButton(
                              icon: Icon(Icons.comment),
                              onPressed: () {
                                GoRouter.of(context).go('/posts/${post!.id}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(post!.postTime.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/defaultavatar.jpg'),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _createComment(_commentController.text);
                      _commentController.clear();
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
            ),
            commentProvider.comments.isEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No comments yet'),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: commentsToShow < commentProvider.comments.length
                  ? commentsToShow
                  : commentProvider.comments.length,
              itemBuilder: (context, index) {
                var comment = commentProvider.comments.reversed.toList()[index];
                return CommentCard(
                  userName: comment.userName ?? 'Unknown',
                  commentText: comment.comment ?? '',
                  userImage: comment.userImage ?? 'assets/images/profile-placeholder.jpg',
                  commentTime: comment.commentTime ?? DateTime.now().toIso8601String(),
                );
              },
            ),
        if (commentsToShow < commentProvider.comments.length)
    TextButton(
      onPressed: () {
        setState(() {
          commentsToShow += 3; // Increment the number of comments to show
        });
      },
      child: Text('See More Comments'),
    ),
    ],
    ),
    ),
    );
  }
}
