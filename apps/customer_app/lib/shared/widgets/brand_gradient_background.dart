import 'package:customer_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Full-bleed brand gradient used by the splash screens.
class BrandGradientBackground extends StatelessWidget {
  const BrandGradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.brandGradient),
      child: SizedBox.expand(child: child),
    ); // DecoratedBox
  }
}
