import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/project_favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoriteProjectsScreen extends StatefulWidget {
  static const String name = "favorite_projects_screen";
  final String userId;

  const FavoriteProjectsScreen({super.key, required this.userId});

  @override
  State<FavoriteProjectsScreen> createState() => _FavoriteProjectsScreenState();
}

class _FavoriteProjectsScreenState extends State<FavoriteProjectsScreen> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteProjectsByCurrentUser();
  }

  Future<void> _loadFavoriteProjectsByCurrentUser() async {
    final projectProvider = context.read<ProjectProvider>();

    await projectProvider.loadFavoritesProjects(int.parse(widget.userId));
  }

  Future<void> onDeleteProjectFromFavorite(int projectId) async {
    final postProvider = context.read<ProjectProvider>();

    await postProvider.deleteProjectFromFavorites(projectId);
  }

  @override
  Widget build(BuildContext context) {
    final projectsProvider =
        Provider.of<ProjectProvider>(context, listen: true);

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
              context.go('/home');
            }
          },
        ),
        title: Text(
          'Favorite Projects',
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
                            text: 'Nicolas',
                            style: TextStyle(
                              color: CustomColors.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ', check your favorite projects!',
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
          projectsProvider.initialLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: projectsProvider.favProjects.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.comments_disabled_outlined,
                                  size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'No projects available',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.go('/projects');
                                },
                                child: Text(
                                  'Go to projects',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: ListView.builder(
                            itemCount: projectsProvider.favProjects.length,
                            itemBuilder: (context, index) {
                              final project = projectsProvider.favProjects[index];
                              return Column(
                                children: [
                                  ProjectFavoriteCard(
                                    name: project.name,
                                    description: project.description,
                                    imagesUrl: project.imageUrl,
                                    userList: project.userList!,
                                    onPressedCard: () {
                                      context.go(
                                          '/projects/${project.id}?isFavorite=true');
                                    },
                                    onDeleteFavorite: () =>
                                        onDeleteProjectFromFavorite(
                                            project.id!),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              );
                            },
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}
