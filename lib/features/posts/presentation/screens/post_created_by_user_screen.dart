import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/post_user_card.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/update_post_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PostCreatedByUserScreen extends StatefulWidget {
  static const String name = "post_created_by_user_screen";
  final String userId;
  final String userName;

  const PostCreatedByUserScreen(
      {super.key, required this.userId, required this.userName});

  @override
  State<PostCreatedByUserScreen> createState() =>
      _PostCreatedByUserScreenState();
}

class _PostCreatedByUserScreenState extends State<PostCreatedByUserScreen> {
  // los textController se manejan en el modal buttom :p
  @override
  void initState() {
    super.initState();
    _loadPostsByCurrentUser();
  }

  Future<void> _loadPostsByCurrentUser() async {
    final postsProvider = Provider.of<PostProvider>(context, listen: false);

    postsProvider.loadPostsCreatedByCurrentUser(int.parse(widget.userId));
  }

  Future<void> onDeletePost(int postId) async {
    final postProvider = context.read<PostProvider>();

    await postProvider.deletePostById(postId);
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkGreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32.0,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go(
                  '/'); // Redirige a una ruta específica si no hay páginas en la pila
            }
          },
        ),
        title: Text(
          'Your Posts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        toolbarHeight: 70.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () {
              // Acción al presionar el botón de filtro
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(22, 72, 255, 21),
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 172, 169, 169),
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
                right: 20.0,
                bottom: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.userName,
                            style: TextStyle(
                              color: CustomColors.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ', check your last posts!',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          postsProvider.initialLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: postsProvider.userPosts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.comments_disabled_outlined,
                                  size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'No posts available',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.go('/posts');
                                },
                                child: Text(
                                  'Go to posts',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: postsProvider.userPosts.length,
                          itemBuilder: (context, index) {
                            final post = postsProvider.userPosts[index];
                            return PostUserCard(
                              username: post.userName!,
                              email: post.email!,
                              profileImg: post.userImage!,
                              images: post.images,
                              rating: post.rating!,
                              numComments: post.commentsList!.length,
                              postTime: post.postTime!,
                              postId: post.id!,
                              title: post.title,
                              description: post.description,
                              onDelete: () => onDeletePost(post.id!),
                              onEdit: () => showBottomModalUpdatePost(
                                context,
                                post.id!,
                                post.title,
                                post.subject,
                                post.description,
                                post.images,
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }

  void showBottomModalUpdatePost(BuildContext context, int postId, String title,
      String subject, String description, List<String> images) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return UpdatePostBottomModal(
          postId: postId,
          title: title,
          subject: subject,
          description: description,
          imagesList: images,
        );
      },
    );
  }
}
