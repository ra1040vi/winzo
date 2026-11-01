import 'dart:math' as math;

import 'package:customer_app/core/theme/app_colors.dart';
import 'package:customer_app/shared/constants/app_assets.dart';
import 'package:customer_app/shared/widgets/aurora_backdrop.dart';
import 'package:customer_app/shared/widgets/brand_mark.dart';
import 'package:customer_app/shared/widgets/fade_slides_in.dart';
import 'package:customer_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward(); // AnimationController
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _openSignUp() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => const Placeholder()));
  }

  void _openSignIn() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => const Placeholder()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final heroHeight = (size.height * 0.27).clamp(170.0, 260.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AuroraBackdrop(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const verticalPadding = 44.0;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: math.max(
                        0,
                        constraints.maxHeight - verticalPadding,
                      ),
                    ), // BoxConstraints
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.0,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: BrandMark(height: 38),
                              ), // Align
                            ), // FadeSlideIn
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.12,
                              child: _HeroIllustration(height: heroHeight),
                            ), // FadeSlideIn
                            const SizedBox(height: 32),
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.24,
                              child: const _Headline(),
                            ), // FadeSlideIn
                            const SizedBox(height: 14),
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.32,
                              child: const Text(
                                'Send, track and receive parcels across town '
                                'with riders you can actually count on.',
                                style: TextStyle(
                                  fontSize: 15.5,
                                  height: 1.5,
                                  color: AppColors.inkMuted,
                                ), // TextStyle
                              ), // Text
                            ), // FadeSlideIn
                            const SizedBox(height: 28),
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.40,
                              child: const _FeatureStrip(),
                            ), // FadeSlideIn
                            const SizedBox(height: 36),
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.50,
                              child: GradientButton(
                                label: 'Get started',
                                icon: Icons.arrow_forward_rounded,
                                onPressed: _openSignUp,
                              ), // GradientButton
                            ), // FadeSlideIn
                            const SizedBox(height: 12),
                            FadeSlideIn(
                              controller: _entranceController,
                              start: 0.58,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: AppColors.inkMuted,
                                    ), // TextStyle
                                  ), // Text
                                  TextButton(
                                    onPressed: _openSignIn,
                                    child: const Text('Log in'),
                                  ), // TextButton
                                ],
                              ), // Wrap
                            ), // FadeSlideIn
                          ],
                        ), // Column
                      ), // ConstrainedBox
                    ), // Center
                  ), // ConstrainedBox
                ); // SingleChildScrollView
              },
            ), // LayoutBuilder
          ), // SafeArea
        ],
      ), // Stack
    ); // Scaffold
  }
}

/// The parcel-handoff artwork framed in a floating card.
class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.12),
            blurRadius: 36,
            offset: const Offset(0, 18),
          ), // BoxShadow
        ],
      ), // BoxDecoration
      child: Image.asset(AppAssets.welcomeHands, fit: BoxFit.contain),
    ); // Container
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'Every parcel,\nhanded over with '),
          TextSpan(
            text: 'care',
            style: TextStyle(color: AppColors.primary),
          ), // TextSpan
          TextSpan(text: '.'),
        ],
      ), // TextSpan
      style: TextStyle(
        fontSize: 32,
        height: 1.18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: AppColors.ink,
      ), // TextStyle
    ); // Text.rich
  }
}

class _FeatureStrip extends StatelessWidget {
  const _FeatureStrip();

  static const _features = [
    (
      icon: Icons.bolt_rounded,
      label: 'Instant\ndispatch',
      color: AppColors.accent,
    ),
    (
      icon: Icons.near_me_rounded,
      label: 'Live\ntracking',
      color: AppColors.teal,
    ),
    (
      icon: Icons.verified_user_rounded,
      label: 'Safe\nhandoff',
      color: AppColors.magenta,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final feature in _features)
          Expanded(
            child: _FeatureBadge(
              icon: feature.icon,
              label: feature.label,
              color: feature.color,
            ), // _FeatureBadge
          ), // Expanded
      ],
    ); // Row
  }
}

class _FeatureBadge extends StatelessWidget {
  const _FeatureBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(18),
          ), // BoxDecoration
          child: Icon(icon, color: color, size: 26),
        ), // Container
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12.5,
            height: 1.3,
            fontWeight: FontWeight.w600,
            color: AppColors.inkMuted,
          ), // TextStyle
        ), // Text
      ],
    ); // Column
  }
}
