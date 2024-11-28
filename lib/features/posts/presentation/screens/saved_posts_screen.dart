import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/saved_post_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SavedPostsScreen extends StatefulWidget {
  static const String name = "favorite_posts_screen";
  final String userId;
  final String userName;

  const SavedPostsScreen(
      {super.key, required this.userId, required this.userName});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  @override
  void initState() {
    super.initState();
    _loadSavedPostsByCurrentUser();
  }

  Future<void> _loadSavedPostsByCurrentUser() async {
    final projectProvider = context.read<PostProvider>();

    await projectProvider.loadSavedPosts(int.parse(widget.userId));
  }

  Future<void> onDeleteProjectFromFavorite(int projectId) async {
    final postProvider = context.read<PostProvider>();

    await postProvider.deletePostFromSaved(projectId);
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
              context.go('/posts');
            }
          },
        ),
        title: Text(
          'Saved Posts',
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
                            text: ', check your favorite posts!',
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
                  child: postsProvider.savedPosts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.comments_disabled_outlined,
                                  size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'No favorite posts available',
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
                          itemCount: postsProvider.savedPosts.length,
                          itemBuilder: (context, index) {
                            final post = postsProvider.savedPosts[index];
                            return SavedPostCard(
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
                              onPressedTab: () {
                                context.go(
                                    '/posts/${post.id}?isFavorite=${post.isFavorite}');
                              },
                              onDeleteFavorite: () =>
                                  onDeleteProjectFromFavorite(post.id!),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
