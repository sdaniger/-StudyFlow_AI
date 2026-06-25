import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/tasks/presentation/screens/task_list_screen.dart';
import '../../features/tasks/presentation/screens/task_edit_screen.dart';
import '../../features/small_steps/presentation/screens/small_steps_screen.dart';
import '../../features/pomodoro/presentation/screens/pomodoro_screen.dart';
import '../../features/habits/presentation/screens/habit_screen.dart';
import '../../features/review/presentation/screens/review_screen.dart';
import '../../features/ai_planner/presentation/screens/ai_planner_screen.dart';
import '../../features/calendar_sync/presentation/screens/calendar_sync_screen.dart';
import '../../features/drive_sync/presentation/screens/drive_sync_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../responsive/responsive_breakpoints.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(location: state.matchedLocation, child: child),
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
            GoRoute(
              path: ':id/steps',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                final taskTitle = state.uri.queryParameters['title'] ?? 'Small Steps';
                return MaterialPage(
                  key: state.pageKey,
                  child: SmallStepsScreen(taskId: id, taskTitle: taskTitle),
                );
              },
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
            child: const AiPlannerScreen(),
          ),
        ),
        GoRoute(
          path: '/calendar-sync',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const CalendarSyncScreen(),
          ),
        ),
        GoRoute(
          path: '/drive-sync',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DriveSyncScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenType = ResponsiveBreakpoints.getScreenType(width);
    final selectedIndex = _calculateIndex(location);

    if (screenType == ScreenType.mobile) {
      return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => _onNavigate(context, index),
          destinations: _destinations(context),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _onNavigate(context, index),
              labelType: screenType == ScreenType.desktop
                  ? NavigationRailLabelType.all
                  : NavigationRailLabelType.none,
              destinations: _railDestinations(context),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  int _calculateIndex(String location) {
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/pomodoro')) return 2;
    if (location.startsWith('/habits')) return 3;
    if (location.startsWith('/review')) return 4;
    if (location.startsWith('/ai-planner')) return 5;
    if (location.startsWith('/calendar-sync')) return 6;
    if (location.startsWith('/drive-sync')) return 7;
    if (location.startsWith('/settings')) return 8;
    return 0;
  }

  void _onNavigate(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/');
      case 1: context.go('/tasks');
      case 2: context.go('/pomodoro');
      case 3: context.go('/habits');
      case 4: context.go('/review');
      case 5: context.go('/ai-planner');
      case 6: context.go('/calendar-sync');
      case 7: context.go('/drive-sync');
      case 8: context.go('/settings');
    }
  }

  static List<NavigationDestination> _destinations(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l10n.navHome),
      NavigationDestination(icon: const Icon(Icons.task_alt_outlined), selectedIcon: const Icon(Icons.task_alt), label: l10n.navTasks),
      NavigationDestination(icon: const Icon(Icons.timer_outlined), selectedIcon: const Icon(Icons.timer), label: l10n.navFocus),
      NavigationDestination(icon: const Icon(Icons.checklist_outlined), selectedIcon: const Icon(Icons.checklist), label: l10n.navHabits),
      NavigationDestination(icon: const Icon(Icons.auto_stories_outlined), selectedIcon: const Icon(Icons.auto_stories), label: l10n.navReview),
      NavigationDestination(icon: const Icon(Icons.auto_awesome_outlined), selectedIcon: const Icon(Icons.auto_awesome), label: l10n.navAI),
      NavigationDestination(icon: const Icon(Icons.calendar_month_outlined), selectedIcon: const Icon(Icons.calendar_month), label: l10n.navCalendar),
      NavigationDestination(icon: const Icon(Icons.cloud_outlined), selectedIcon: const Icon(Icons.cloud), label: l10n.navDrive),
      NavigationDestination(icon: const Icon(Icons.settings_outlined), selectedIcon: const Icon(Icons.settings), label: l10n.navSettings),
    ];
  }

  static List<NavigationRailDestination> _railDestinations(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      NavigationRailDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: Text(l10n.navHome)),
      NavigationRailDestination(icon: const Icon(Icons.task_alt_outlined), selectedIcon: const Icon(Icons.task_alt), label: Text(l10n.navTasks)),
      NavigationRailDestination(icon: const Icon(Icons.timer_outlined), selectedIcon: const Icon(Icons.timer), label: Text(l10n.navFocus)),
      NavigationRailDestination(icon: const Icon(Icons.checklist_outlined), selectedIcon: const Icon(Icons.checklist), label: Text(l10n.navHabits)),
      NavigationRailDestination(icon: const Icon(Icons.auto_stories_outlined), selectedIcon: const Icon(Icons.auto_stories), label: Text(l10n.navReview)),
      NavigationRailDestination(icon: const Icon(Icons.auto_awesome_outlined), selectedIcon: const Icon(Icons.auto_awesome), label: Text(l10n.navAI)),
      NavigationRailDestination(icon: const Icon(Icons.calendar_month_outlined), selectedIcon: const Icon(Icons.calendar_month), label: Text(l10n.navCalendar)),
      NavigationRailDestination(icon: const Icon(Icons.cloud_outlined), selectedIcon: const Icon(Icons.cloud), label: Text(l10n.navDrive)),
      NavigationRailDestination(icon: const Icon(Icons.settings_outlined), selectedIcon: const Icon(Icons.settings), label: Text(l10n.navSettings)),
    ];
  }
}
