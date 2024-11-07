import 'package:aidmanager_mobile/config/router/app_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/providers/calendar_provider.dart';
import 'package:aidmanager_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:aidmanager_mobile/features/posts/infraestructure/datasources/comment_datasource_impl.dart';
import 'package:aidmanager_mobile/features/posts/infraestructure/datasources/post_datasource_impl.dart';
import 'package:aidmanager_mobile/features/posts/infraestructure/repositories/comment_repository_impl.dart';
import 'package:aidmanager_mobile/features/posts/infraestructure/repositories/post_repository_impl.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/datasources/user_datasource_impl.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:aidmanager_mobile/features/profile/infrastructure/repositories/user_repository_impl.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/dashboards_repository.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/datasources/dashboards_datasource_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/datasources/projects_datasource_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/datasources/tasks_datasource_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/repositories/dasboards_repository_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/repositories/projects_repository_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/repositories/tasks_repository_impl.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/dashboard_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/task_provider.dart';
import 'package:aidmanager_mobile/features/social/presentation/providers/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // creamos las instancias de los repositorios con sus datasources
  final userRepository = UserRepositoryImpl(datasource: UserDatasourceImpl());
  final authRepository = AuthRepositoryImpl(datasource: AuthDatasourceImpl());
  final projectRepository = ProjectsRepositoryImpl(datasource: ProjectsDatasourceImpl());
  final tasksRepository = TasksRepositoryImpl(datasource: TasksDatasourceImpl());
  final postsRepository = PostRepositoryImpl(datasource: PostDatasourceImpl());
  final dashboardRepository = DasboardsRepositoryImpl(datasource: DashboardsDatasourceImpl());
  final commentsRepository = CommentRepositoryImpl(datasource: CommentDatasourceImpl());

  runApp(
    MultiProvider(
      providers: [
        // proveemos las instancias de los repositorios, asi permitimos
        // que cualquier widget en el árbol de widgets pueda acceder a estas instancias
        Provider<UserRepository>.value(value: userRepository),
        Provider<AuthRepository>.value(value: authRepository),
        Provider<ProjectsRepository>.value(value: projectRepository),
        Provider<TasksRepository>.value(value: tasksRepository),
        //Provider<PostsRepository>.value(value: postsRepository),
        Provider<DashboardsRepository>.value(value: dashboardRepository),

        // hay que proveer una instancia de AuthProvider
        // AuthProvider necesita instancias de UserRepository y AuthRepository
        // que se inyectan mediante el contexto
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            userRepository: context.read<UserRepository>(),
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
          create: (context) => HomeProvider(
            projectsRepository: projectRepository,
            userRepository: userRepository,
            tasksRepository: tasksRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, homeProvider) =>
              homeProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProjectProvider>(
          create: (context) => ProjectProvider(
            projectsRepository: projectRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, projectProvider) =>
              projectProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, DashboardProvider>(
          create: (context) => DashboardProvider(
            dashboardsRepository: dashboardRepository,
            tasksRepository: tasksRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, dashboardProvider) =>
              dashboardProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, TaskProvider>(
          create: (context) => TaskProvider(
            userRepository: userRepository,
            tasksRepository: tasksRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, taskProvider) =>
              taskProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, CalendarProvider>(
          create: (context) => CalendarProvider(
            tasksRepository: tasksRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, calendarProvider) =>
              calendarProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
          create: (context) => ProfileProvider(
            userRepository: userRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (_, authProvider, userProvider) =>
              userProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, PostProvider>(
          create: (context) => PostProvider(
            postsRepository: postsRepository,
            commentRepository: commentsRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, authProvider, postProvider) =>
              postProvider!..authProvider = authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, SocialProvider>(
          create: (context) => SocialProvider(
            userRepository: userRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, authProvider, socialProvider) =>
              socialProvider!..authProvider = authProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AidManager',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
