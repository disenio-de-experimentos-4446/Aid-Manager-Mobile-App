import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/error_fetch_projects_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/principal_project_card.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatelessWidget {
  static const String name = "projects_screen";

  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ProjectsContent(),
        );
      },
    );
  }
}

class ProjectsContent extends StatefulWidget {
  const ProjectsContent({super.key});

  @override
  State<ProjectsContent> createState() => _ProjectsContentState();
}

class _ProjectsContentState extends State<ProjectsContent> {
  final TextEditingController searchController = TextEditingController();
  List<Project> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
    searchController.addListener(_filterProjects);
  }

  Future<void> _loadProjects() async {
    try {
      final projectProvider = Provider.of<ProjectProvider>(context, listen: false);
      await projectProvider.loadInitialProjects();

      // importante antes de act el estado verificar si ya se encuentra montado
      if (!mounted) return;

      setState(() {
        filteredProjects = projectProvider.projects;
      });
    } catch (e) {
      if(!mounted) return;
      ErrorFetchProjectsDialog.show(context);
    }
  }

  void _filterProjects() {
    final query = searchController.text.toLowerCase();
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    setState(() {
      filteredProjects = projectProvider.projects.where((project) {
        return project.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> onSubmitFavorite(int projectId) async {
    final projectProvider = context.read<ProjectProvider>();

    projectProvider.saveProjectAsFavorite(projectId);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProjects);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).user;
    final projectProvider = context.watch<ProjectProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                top: 25.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.fieldGrey,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15.0),
                            ),
                          ),
                        ),
                      ),
                      if ((currentUser?.role ?? 'No Role') == 'Manager') ...[
                        SizedBox(width: 16.0),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 32.0,
                            ),
                            onPressed: () {
                              context.go('/projects/new');
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Expanded(
                      child: projectProvider.projects.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.work_off_rounded,
                                      size: 50, color: Colors.grey),
                                  SizedBox(height: 15),
                                  Text(
                                    'No projects available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                  if ((currentUser?.role ?? 'No Role') ==
                                      'Manager') ...[
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.go('/projects/new');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.green,
                                        backgroundColor:
                                            CustomColors.lightGreen,
                                      ),
                                      child: Text(
                                        'Create new project',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredProjects.length,
                                itemBuilder: (context, index) {
                                  final project = filteredProjects[index];
                                  return Column(
                                    children: [
                                      PrincipalProjectCard(
                                        projectId: project.id!,
                                        name: project.name,
                                        description: project.description,
                                        imagesUrl: project.imageUrl,
                                        rating: project.rating!,
                                        userList: project.userList!,
                                        isFavorite: project.isFavorite,
                                        onPressedCard: () {
                                          context.go('/projects/${project.id}?isFavorite=${project.isFavorite}');
                                        },
                                        onSubmitFavorite: () async {
                                          if (project.id != null) {
                                            await onSubmitFavorite(project.id!);
                                            setState(() {
                                              project.isFavorite = true;
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  );
                                },
                              ),
                            )),
                ],
              ),
            ),
            if (projectProvider.initialLoading)
              Container(
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
              ),
          ],
        ),
      ),
    );
  }
}
