import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const FadeTransitionWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      child: child,
    );
  }
}
