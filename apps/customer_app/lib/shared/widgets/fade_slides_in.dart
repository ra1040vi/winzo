import 'package:flutter/material.dart';

/// Fades and slides its child upward over a slice of [controller]'s timeline,
/// which lets a column of widgets animate in as a stagger.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    super.key,
    required this.controller,
    required this.start,
    required this.child,
    this.duration = 0.55,
    this.offset = 32,
  });

  final AnimationController controller;

  /// Where this child's animation begins on the 0..1 parent timeline.
  final double start;

  /// How much of the parent timeline this child's animation occupies.
  final double duration;

  /// Distance in logical pixels the child travels upward as it fades in.
  final double offset;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        start.clamp(0.0, 1.0),
        (start + duration).clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ), // Interval
    ); // CurvedAnimation

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * offset),
            child: child,
          ), // Transform.translate
        ); // Opacity
      },
    ); // AnimatedBuilder
  }
}
