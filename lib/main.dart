import 'package:aidmanager_mobile/config/router/app_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/datasources/user_datasource_impl.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:aidmanager_mobile/features/auth/infrastructure/repositories/user_repository_impl.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/projects_repository.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/datasources/projects_datasource_impl.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/repositories/projects_repository_impl.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // creamos las instancias de los repositorios con sus datasources
  final userRepository = UserRepositoryImpl(datasource: UserDatasourceImpl());
  final authRepository = AuthRepositoryImpl(datasource: AuthDatasourceImpl());
  final projectRepository = ProjectsRepositoryImpl(datasource: ProjectsDatasourceImpl());

  runApp(
    MultiProvider(
      providers: [
        // proveemos las instancias de los repositorios, asi permitimos
        // que cualquier widget en el árbol de widgets pueda acceder a estas instancias
        Provider<UserRepository>.value(value: userRepository),
        Provider<AuthRepository>.value(value: authRepository),
        Provider<ProjectsRepository>.value(value: projectRepository),

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
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => ProjectProvider(
            projectsRepository: context.read<ProjectsRepository>(),
          ),
        )
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