import 'dart:math' as math;

import 'package:customer_app/shared/constants/app_assets.dart';
import 'package:customer_app/shared/widgets/brand_gradient_background.dart';
import 'package:customer_app/shared/widgets/brand_mark.dart';
import 'package:flutter/material.dart';

class BrandSplashScreen extends StatefulWidget {
  const BrandSplashScreen({super.key});

  @override
  State<BrandSplashScreen> createState() => _BrandSplashScreenState();
}

class _BrandSplashScreenState extends State<BrandSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoWidthAnimation;
  late Animation<double> _bikeProgressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward(); // AnimationController
    _logoWidthAnimation = Tween<double>(begin: 0.8, end: 0.6).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _bikeProgressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              // return const WelcomeScreen();
              return const Placeholder();
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bikeWidth = size.width * 0.35;
    return Scaffold(
      body: BrandGradientBackground(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final progress = _bikeProgressAnimation.value;
            // Travel from fully off-screen left to fully off-screen right.
            final bikeLeft = -bikeWidth + progress * (size.width + bikeWidth);
            // Small vertical bob so the ride feels less flat.
            final bikeBob = math.sin(progress * math.pi * 4) * 6;
            return Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: size.width * _logoWidthAnimation.value,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: BrandMark(height: 80, onDark: true),
                    ), // FittedBox
                  ), // SizedBox
                ), // Center
                Positioned(
                  left: bikeLeft,
                  top: size.height * 0.62 + bikeBob,
                  child: Image.asset(AppAssets.bike, width: bikeWidth),
                ), // Positioned
              ],
            ); // Stack
          }, // AnimatedBuilder
        ), // BrandGradientBackground
      ), // Scaffold
    );
  }
}
