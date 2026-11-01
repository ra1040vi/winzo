import 'package:customer_app/features/splash/view/brand_splash_screen.dart';
import 'package:customer_app/shared/widgets/brand_gradient_background.dart';
import 'package:customer_app/shared/widgets/brand_mark.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BrandSplashScreen()),
      );
    }); // Future.delayed
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: BrandGradientBackground(
        child: Center(
          child: BrandMark(
            height: (screenWidth * 0.14).clamp(44.0, 72.0),
            onDark: true,
          ), // BrandMark
        ), // Center
      ), // BrandGradientBackground
    ); // Scaffold
  }
}
