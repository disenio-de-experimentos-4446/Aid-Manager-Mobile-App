import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/organization_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/tutorial_screen.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:aidmanager_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/posts_screen.dart';
import 'package:aidmanager_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_create_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_dashboard_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_goals_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_payment_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_task_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_tasks_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/projects_screen.dart';
import 'package:aidmanager_mobile/features/social/presentation/screens/social_screen.dart';
import 'package:aidmanager_mobile/shared/main_wrapper.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/tutorial',
      name: TutorialScreen.name,
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      path: '/organization',
      builder: (context, state) {
        final directorInfo = state.extra as DirectorData;
        return OrganizationScreen(
            directorInfo: directorInfo); // Mandamos info a la ruta
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainWrapper(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: HomeScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/social',
          name: SocialScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SocialScreen(),
          ),
        ),
        GoRoute(
          path: '/projects',
          name: ProjectsScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProjectsScreen(),
          ),
        ),
        GoRoute(
          path: '/projects/new',
          name: ProjectCreateFormScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProjectCreateFormScreen(),
          ),
        ),
        GoRoute(
          path: '/projects/:projectId',
          name: ProjectDetailScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectDetailScreen(projectId: projectId),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard',
          name: ProjectDashboardScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName = state.uri.queryParameters['name']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectDashboardScreen(projectId: projectId, projectName: projectName),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard/edit-payments',
          name: ProjectPaymentFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectPaymentFormScreen(projectId: projectId),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard/edit-goals',
          name: ProjectGoalsFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectGoalsFormScreen(projectId: projectId),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/tasks',
          name: ProjectTasksScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName = state.uri.queryParameters['name']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectTasksScreen(projectId: projectId, projectName: projectName,),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/tasks/new',
          name: ProjectTaskFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectTaskFormScreen(projectId: projectId),
            );
          },
        ),
        GoRoute(
          path: '/calendar',
          name: CalendarScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const CalendarScreen(),
          ),
        ),
        GoRoute(
          path: '/posts',
          name: PostsScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PostsScreen(),
          ),
        ),
        GoRoute(
          path: '/posts/:postId',
          name: PostDetailScreen.name,
          pageBuilder: (context, state) {
            final postId = state.pathParameters['postId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: PostDetailScreen(postId: int.parse(postId)),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          name: ProfileScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
      ],
    ),
  ],
);
