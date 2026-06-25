import 'package:flutter/material.dart';
import '../../core/responsive/responsive_breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/gradient_background.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final List<NavigationDestination>? destinations;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationChanged;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.bottomNavigationBar,
    this.drawer,
    this.destinations,
    this.selectedIndex,
    this.onDestinationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final screenType = ResponsiveBreakpoints.getScreenType(width);

        return GradientBackground(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context, screenType),
            drawer: screenType == ScreenType.mobile ? drawer : null,
            body: SafeArea(
              child: Row(
                children: [
                  if (screenType == ScreenType.tablet && destinations != null)
                    NavigationRail(
                      selectedIndex: selectedIndex ?? 0,
                      onDestinationSelected: onDestinationChanged ?? (_) {},
                      backgroundColor: Colors.transparent,
                      indicatorColor: AppColors.primary.withAlpha(51),
                      destinations: destinations!
                          .map((d) => NavigationRailDestination(
                                icon: d.icon,
                                selectedIcon: d.selectedIcon,
                                label: Text(d.label),
                              ))
                          .toList(),
                    ),
                  if (screenType == ScreenType.desktop && destinations != null)
                    SizedBox(
                      width: 80,
                      child: NavigationRail(
                        selectedIndex: selectedIndex ?? 0,
                        onDestinationSelected: onDestinationChanged ?? (_) {},
                        backgroundColor: Colors.transparent,
                        indicatorColor: AppColors.primary.withAlpha(51),
                        labelType: NavigationRailLabelType.all,
                        destinations: destinations!
                            .map((d) => NavigationRailDestination(
                                  icon: d.icon,
                                  selectedIcon: d.selectedIcon,
                                  label: Text(d.label),
                                ))
                            .toList(),
                      ),
                    ),
                  Expanded(child: body),
                ],
              ),
            ),
            bottomNavigationBar:
                screenType == ScreenType.mobile ? bottomNavigationBar : null,
          ),
        );
      },
    );
  }

  PreferredSizeWidget? _buildAppBar(
      BuildContext context, ScreenType screenType) {
    if (title == null && !showBackButton && (actions == null || actions!.isEmpty)) {
      return null;
    }
    return AppBar(
      title: title != null ? Text(title!) : null,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
