import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/successfull_post_create_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/new_post_bottom_modal.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/post_card.dart';
import 'package:aidmanager_mobile/features/posts/shared/widgets/custom_error_posts_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatelessWidget {
  static const String name = "posts_screen";

  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const PostsContent(),
        );
      },
    );
  }
}

class PostsContent extends StatefulWidget {
  const PostsContent({super.key});

  @override
  State<PostsContent> createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPostsFromCompany();
  }

  Future<void> _loadPostsFromCompany() async {
    final postsProvider = Provider.of<PostProvider>(context, listen: false);

    postsProvider.loadInitialPostsByCompanyId();
  }

  Future<void> onSubmitNewPost() async {
    final title = _titleController.text;
    final subject = _subjectController.text;
    final description = _descriptionController.text;

    final postProvider = context.read<PostProvider>();

    try {
      await postProvider.createNewPost(title, subject, description);
      if (!mounted) return;

      showCustomizeDialog(context, const SuccessfullPostCreateDialog());
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getPostErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostProvider>(context, listen: true);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(255, 172, 169, 169),
                    width: 1.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/profile-placeholder.jpg',
                          width: double.infinity,
                          image: postsProvider.authProvider.user?.profileImg ??
                              'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/profile-placeholder.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showBottomModalPost(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.fieldGrey,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IgnorePointer(
                            child: TextField(
                              readOnly: true,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: 'Write something incredible...',
                                suffixIcon: Icon(Icons.add, size: 28.0),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5.0)
                                        .copyWith(left: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.lightGreen,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.black87,
                          size: 28.0,
                        ),
                        onPressed: () {},
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
                    child: postsProvider.posts.isEmpty
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
                                    // Navegar a la pantalla de creación de publicaciones
                                    showBottomModalPost(context);
                                  },
                                  child: Text(
                                    'Be the first to create a post!',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: postsProvider.posts.length,
                            itemBuilder: (context, index) {
                              final post = postsProvider.posts[index];
                              return PostCard(
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
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  void showBottomModalPost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return NewPostBottomModal(
          onSubmitPost: onSubmitNewPost,
          titleController: _titleController,
          subjectController: _subjectController,
          descriptionController: _descriptionController,
        );
      },
    );
  }
}
