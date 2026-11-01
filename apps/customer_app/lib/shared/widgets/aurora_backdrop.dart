import 'package:customer_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Soft out-of-focus colour washes that keep flat brand backgrounds alive.
class AuroraBackdrop extends StatelessWidget {
  const AuroraBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -size.width * 0.34,
            right: -size.width * 0.28,
            child: _Glow(
              diameter: size.width * 0.92,
              color: AppColors.primary.withValues(alpha: 0.26),
            ), // _Glow
          ), // Positioned
          Positioned(
            top: size.height * 0.26,
            left: -size.width * 0.34,
            child: _Glow(
              diameter: size.width * 0.78,
              color: AppColors.accent.withValues(alpha: 0.20),
            ), // _Glow
          ), // Positioned
          Positioned(
            bottom: -size.width * 0.3,
            right: -size.width * 0.2,
            child: _Glow(
              diameter: size.width * 0.8,
              color: AppColors.teal.withValues(alpha: 0.18),
            ), // _Glow
          ), // Positioned
        ],
      ), // Stack
    ); // IgnorePointer
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ), // RadialGradient
      ), // BoxDecoration
    ); // Container
  }
}
