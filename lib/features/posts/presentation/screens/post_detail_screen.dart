import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/comment_card.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/new_comment_bottom_modal.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/no_comments_yet.dart';
import 'package:aidmanager_mobile/features/posts/shared/widgets/custom_error_posts_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  static const String name = "posts_detail_screen";

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadThreadInformation();
  }

  Future<void> _loadThreadInformation() async {
    final postId = int.parse(widget.postId);
    await context.read<PostProvider>().loadThreadByPost(postId);
  }

  Future<void> onSubmitnewComment() async {
    final comment = _commentController.text;

    if (comment.isEmpty) {
      showCustomizeDialog(context, IsEmptyDialog());
      return;
    }

    final postProvider = context.read<PostProvider>();

    try {
      await postProvider.createNewCommentInPost(
          int.parse(widget.postId), comment);
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getPostErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: true);
    final post = postProvider.selectedPost;

    String formattedDate = post?.postTime != null
        ? DateFormat('dd MMM yyyy').format(post!.postTime!)
        : 'Unknown date';

    return RefreshIndicator(
      onRefresh: _loadThreadInformation,
      child: postProvider.isLoading
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: CustomColors.darkGreen,
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 70.0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
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
                            Icons.bookmark_border_outlined,
                            size: 32.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Lógica para guardar
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            size: 32.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // lógica para agregar a favoritos
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CustomColors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 30.0, top: 0.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      child: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          width: double.infinity,
                                          placeholder:
                                              'assets/images/profile-placeholder.jpg',
                                          image: post?.userImage ??
                                              'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/profile-placeholder.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              post?.userName ?? 'No name',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 22.0,
                                                  color: CustomColors.darkGreen,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Autor',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          post?.email ?? '',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    post?.title ?? 'No title',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.65,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    post?.description ?? 'no desc',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.65,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    post!.images[0],
                                    width: double.infinity,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/placeholder-image.webp',
                                        width: double.infinity,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.comment,
                                                size: 22.0,
                                                color: const Color.fromARGB(
                                                    255, 114, 114, 114)),
                                            SizedBox(width: 5),
                                            Text(
                                              '${post?.commentsList?.length.toString() ?? ''} reviews',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: const Color.fromARGB(
                                                    255, 75, 75, 75),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.thumb_up_rounded,
                                                size: 22.0,
                                                color: const Color.fromARGB(
                                                    255, 114, 114, 114)),
                                            SizedBox(width: 5),
                                            Text(
                                              '${post?.rating.toString() ?? '0'} likes',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: const Color.fromARGB(
                                                    255, 75, 75, 75),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month,
                                            size: 20.0,
                                            color: const Color.fromARGB(
                                              255,
                                              114,
                                              114,
                                              114,
                                            )),
                                        SizedBox(width: 6),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: const Color.fromARGB(
                                                255, 75, 75, 75),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    post?.commentsList?.isEmpty ?? true
                        ? NoCommentsYet(
                            onAddComment: () => showBottomModalComment(context),
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Comentarios:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showBottomModalComment(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets
                                              .zero, // Quitar el padding por defecto
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.add_rounded,
                                                color: CustomColors.darkGreen),
                                            SizedBox(width: 5),
                                            Text(
                                              'Add new comment',
                                              style: TextStyle(
                                                color: CustomColors.darkGreen,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: post?.commentsList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final comment = post?.commentsList![index];
                                  return CommentCard(
                                    userImage: comment!.authorImage,
                                    userEmail: comment.authorEmail,
                                    userName: comment.authorName,
                                    comment: comment.comment,
                                    postId: comment.postId,
                                    timeOfComment: comment.timeOfComment,
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  void showBottomModalComment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return NewCommentBottomModal(
          onSubmitComment: onSubmitnewComment,
          commentController: _commentController,
        );
      },
    );
  }
}
