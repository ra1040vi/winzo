import 'package:customer_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Primary call-to-action: a gradient pill with a soft brand-coloured glow.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient = AppColors.ctaGradient,
    this.height = 58,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Gradient gradient;
  final double height;

  /// Shows an inline spinner in place of the icon while work is in flight.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);
    final enabled = onPressed != null;

    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: radius,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.38),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ), // BoxShadow
                ]
              : null,
        ), // BoxDecoration
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: radius,
            child: SizedBox(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ), // TextStyle
                  ), // Text
                  if (busy) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ), // CircularProgressIndicator
                    ), // SizedBox
                  ] else if (icon != null) ...[
                    const SizedBox(width: 10),
                    Icon(icon, color: Colors.white, size: 20),
                  ],
                ],
              ), // Row
            ), // SizedBox
          ), // InkWell
        ), // Material
      ), // DecoratedBox
    ); // Opacity
  }
}
