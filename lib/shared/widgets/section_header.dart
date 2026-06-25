import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final double bottomPadding;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.bottomPadding = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
