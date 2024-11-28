import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/project_user_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProjectsCreatedByUserScreen extends StatefulWidget {
  static const String name = "projects_created_by_user_screen";
  final String userId;
  final String userName;

  const ProjectsCreatedByUserScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<ProjectsCreatedByUserScreen> createState() =>
      _ProjectsCreatedByUserScreenState();
}

class _ProjectsCreatedByUserScreenState
    extends State<ProjectsCreatedByUserScreen> {
  @override
  void initState() {
    super.initState();
    _loadProjectsByCurrentUser();
  }

  Future<void> _loadProjectsByCurrentUser() async {
    final projectProvider = context.read<ProjectProvider>();

    await projectProvider.loadInitialProjects();
  }

  Future<void> onDeleteProject(int projectId) async {
    final projectProvider = context.read<ProjectProvider>();

    await projectProvider.deleteProjectById(projectId);
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
            context.go('/projects');
          },
        ),
        title: Text(
          'Your Projects',
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
                            text: ', check your projects created!',
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
                  child: projectsProvider.projects.isEmpty
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
                            itemCount: projectsProvider.projects.length,
                            itemBuilder: (context, index) {
                              final project = projectsProvider.projects[index];
                              return Column(
                                children: [
                                  ProjectUserCard(
                                    projectId: project.id!,
                                    name: project.name,
                                    description: project.description,
                                    imagesUrl: project.imageUrl,
                                    projectDate: project.projectDate,
                                    projectTime: project.projectTime,
                                    projectLocation: project.projectLocation,
                                    userList: project.userList!,
                                    onPressedCard: () {
                                      context.go(
                                          '/projects/${project.id}?isFavorite=${project.isFavorite}');
                                    },
                                    onDeleteFavorite: () =>
                                        onDeleteProject(project.id!),
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
