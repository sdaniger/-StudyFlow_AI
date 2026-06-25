import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/tasks/presentation/screens/task_list_screen.dart';
import '../../features/tasks/presentation/screens/task_edit_screen.dart';
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
          destinations: _destinations,
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
              destinations: _railDestinations,
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

  static const _destinations = <NavigationDestination>[
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.task_alt_outlined), selectedIcon: Icon(Icons.task_alt), label: 'Tasks'),
    NavigationDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: 'Focus'),
    NavigationDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: 'Habits'),
    NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories), label: 'Review'),
    NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'AI'),
    NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Calendar'),
    NavigationDestination(icon: Icon(Icons.cloud_outlined), selectedIcon: Icon(Icons.cloud), label: 'Drive'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
  ];

  static const _railDestinations = <NavigationRailDestination>[
    NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
    NavigationRailDestination(icon: Icon(Icons.task_alt_outlined), selectedIcon: Icon(Icons.task_alt), label: Text('Tasks')),
    NavigationRailDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: Text('Focus')),
    NavigationRailDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: Text('Habits')),
    NavigationRailDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories), label: Text('Review')),
    NavigationRailDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: Text('AI')),
    NavigationRailDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: Text('Calendar')),
    NavigationRailDestination(icon: Icon(Icons.cloud_outlined), selectedIcon: Icon(Icons.cloud), label: Text('Drive')),
    NavigationRailDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: Text('Settings')),
  ];
}
