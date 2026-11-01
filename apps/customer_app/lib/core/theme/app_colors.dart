import 'package:flutter/material.dart';

/// Brand palette sampled from the Wingo rider artwork: a vivid indigo-violet
/// core, warmed by the orange / magenta / teal accents of the parcel handoff
/// illustration.
class AppColors {
  AppColors._();

  // Core brand - the rider's scooter and helmet.
  static const primary = Color(0xFF4B3FE4);
  static const primaryDark = Color(0xFF241A8C);
  static const primaryLight = Color(0xFF7D6CFF);
  static const primarySurface = Color(0xFFEDEBFF);

  // Accents - the parcel handoff illustration.
  static const accent = Color(0xFFFF7A18);
  static const accentDark = Color(0xFFE2600A);
  static const accentSurface = Color(0xFFFFF0E3);
  static const magenta = Color(0xFFF31C87);
  static const teal = Color(0xFF00B3A6);
  static const amber = Color(0xFFFFC53D);

  // Neutrals.
  static const ink = Color(0xFF12103A);
  static const inkMuted = Color(0xFF6B6A8D);
  static const surface = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7F6FD);
  static const border = Color(0xFFE6E3F5);

  // Feedback.
  static const success = Color(0xFF17B26A);
  static const warning = Color(0xFFF79009);
  static const error = Color(0xFFE5484D);

  static const brandGradient = LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const ctaGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const accentGradient = LinearGradient(
    colors: [accent, magenta],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
