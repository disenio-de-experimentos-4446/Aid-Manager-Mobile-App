import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/organization_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/tutorial_screen.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:aidmanager_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/saved_posts_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/post_created_by_user_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/posts_screen.dart';
import 'package:aidmanager_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/favorite_projects_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_create_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_dashboard_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_edit_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_goals_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_payment_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_task_form_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/project_tasks_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/projects_created_by_user_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/projects_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/tasks_assigned_by_user_screen.dart';
import 'package:aidmanager_mobile/features/social/presentation/screens/members_deleted_screen.dart';
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
          path: '/projects/edit/:projectId',
          name: ProjectEditScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final project = state.extra as Project;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectEditScreen(projectId: projectId, project: project),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId',
          name: ProjectDetailScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final isFavorite =
                state.uri.queryParameters['isFavorite'] == 'true';
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectDetailScreen(
                projectId: projectId,
                isFavorite: isFavorite,
              ),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard',
          name: ProjectDashboardScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName =
                state.uri.queryParameters['name'] ?? 'No Project Name';
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectDashboardScreen(
                  projectId: projectId, projectName: projectName),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard/edit-payments',
          name: ProjectPaymentFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName =
                state.uri.queryParameters['name'] ?? 'No Project Name';
            final amountSummary = state.extra as List<double>? ?? [];

            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectPaymentFormScreen(
                projectId: projectId,
                projectName: projectName,
                amountSummary: amountSummary,
              ),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/dashboard/edit-goals',
          name: ProjectGoalsFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName =
                state.uri.queryParameters['name'] ?? 'No Project Name';
            final weeklySummary = state.extra as List<double>? ?? [];

            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectGoalsFormScreen(
                projectId: projectId,
                projectName: projectName,
                weeklySummary: weeklySummary,
              ),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/tasks',
          name: ProjectTasksScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName =
                state.uri.queryParameters['name'] ?? 'No projectName';
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectTasksScreen(
                projectId: projectId,
                projectName: projectName,
              ),
            );
          },
        ),
        GoRoute(
          path: '/projects/:projectId/tasks/new',
          name: ProjectTaskFormScreen.name,
          pageBuilder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final projectName =
                state.uri.queryParameters['name'] ?? 'No projectName';
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectTaskFormScreen(
                projectId: projectId,
                projectName: projectName,
              ),
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
            final isFavorite =
                state.uri.queryParameters['isFavorite'] == 'true';
            return NoTransitionPage(
              key: state.pageKey,
              child: PostDetailScreen(
                postId: postId,
                isFavorite: isFavorite,
              ),
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
        GoRoute(
          path: '/projects/user/:userId/tasks',
          name: TasksAssignedByUserScreen.name,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: TasksAssignedByUserScreen(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/posts/user/:userId',
          name: PostCreatedByUserScreen.name,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: PostCreatedByUserScreen(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/projects/user/:userId',
          name: ProjectsCreatedByUserScreen.name,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: ProjectsCreatedByUserScreen(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/posts/saved/user/:userId',
          name: SavedPostsScreen.name,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: SavedPostsScreen(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/projects/favorites/user/:userId',
          name: FavoriteProjectsScreen.name,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return NoTransitionPage(
              key: state.pageKey,
              child: FavoriteProjectsScreen(userId: userId),
            );
          },
        ),
        GoRoute(
          path: '/social/members-deleted',
          name: MembersDeletedScreen.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: MembersDeletedScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
