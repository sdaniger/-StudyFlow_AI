import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/tasks/presentation/screens/task_list_screen.dart';
import '../../features/tasks/presentation/screens/task_edit_screen.dart';
import '../../features/pomodoro/presentation/screens/pomodoro_screen.dart';
import '../../features/habits/presentation/screens/habit_screen.dart';
import '../../features/review/presentation/screens/review_screen.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter create() => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/',
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => AppShell(child: child),
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HomeScreen(),
                ),
              ),
              GoRoute(
                path: '/tasks',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const TaskListScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: const TaskEditScreen(),
                    ),
                  ),
                  GoRoute(
                    path: ':id/edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: const TaskEditScreen(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/pomodoro',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PomodoroScreen(),
                ),
              ),
              GoRoute(
                path: '/habits',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HabitScreen(),
                ),
              ),
              GoRoute(
                path: '/review',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ReviewScreen(),
                ),
              ),
              GoRoute(
                path: '/ai-planner',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen('AI Planner'),
                ),
              ),
              GoRoute(
                path: '/calendar-sync',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen('Calendar Sync'),
                ),
              ),
              GoRoute(
                path: '/drive-sync',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen('Drive Sync'),
                ),
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen('Settings'),
                ),
              ),
            ],
          ),
        ],
      );
}

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
