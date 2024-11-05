import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/SuccessfullyCreatePost.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/helpers/show_customize_dialog.dart';
import '../../../../shared/helpers/storage_helper.dart';
import '../../../profile/domain/entities/user.dart';

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
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostsContent> {

  User? user;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _loadUserData();
  }

  Future<void>  _loadUserData() async {
    user = await StorageHelper.getUser();
    setState(() {});
  }

  Future<void>  _loadPosts() async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    await postProvider.loadInitialPostsByCompanyId();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    
    bool _isValidUrl(String url) {
      print("Is valid image? " + url);
      return Uri.tryParse(url)?.hasAbsolutePath ?? false;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                padding: const EdgeInsets.only(
                    top: 25.0, left: 20.0, right: 20.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                        user?.profileImg?.isNotEmpty == true
                            ? NetworkImage(user!.profileImg!)
                            : AssetImage('assets/images/defaultavatar.jpg'),
                      ),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(10),
                            shadowColor: WidgetStateProperty.all(
                                Colors.black.withOpacity(0.5)),
                            backgroundColor: WidgetStateProperty.all(
                                Color(0xFFE6EEEC)),
                          ),
                          onPressed: () async {
                            _showCreateDialog(context);

                          }, child: Text("Create something new +", style: TextStyle(color: Color(
                            0xFF02513D), fontSize: 18),),
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
                        onPressed: () {
                          // Acción del botón
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: postProvider.initialLoading
                  ? Center(child: CircularProgressIndicator())
                  : postProvider.posts.isEmpty
                  ? Center(child: Text("It seems there's no posts for now!"))
                  : ListView.builder(
                itemCount: postProvider.posts.length,
                itemBuilder: (context, index) {
                  final post = postProvider.posts[index];
                  return PostCard(post: post, userImage: user?.profileImg ?? '');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void _showCreateDialog(BuildContext context) {
  final postProvider = Provider.of<PostProvider>(context, listen: false);

  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final contentController = TextEditingController();
  final imageController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create New Post'),
        backgroundColor: Color(0xFFE6EEEC),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(hintText: "Subject"),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(hintText: "Content"),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(hintText: "Add an image"),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Color(0xFF008A66)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Create'),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Color(0xFF008A66)),
            ),
            onPressed: () async {
              // Add your create logic here

              final title = titleController.text;
              final subject = subjectController.text;
              final content = contentController.text;
              final image = imageController.text;

              try {
                await postProvider.createNewPost(title, subject, content, [image]);
                Navigator.of(context).pop();
                showCustomizeDialog(context, const SuccessfullyCreatePost());
                postProvider.loadInitialPostsByCompanyId();

              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error creating post: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}


