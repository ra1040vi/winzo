import 'package:customer_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// The Wingo brand lockup, drawn in code so it stays crisp at any size and
/// adapts to light or dark backgrounds.
///
/// The mark is a speed badge: motion lines trailing a disc that holds a
/// chevron "W", echoing a rider pulling away from the kerb.
class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.height = 40,
    this.onDark = false,
    this.showWordmark = true,
  });

  /// Height of the mark; the wordmark scales from it.
  final double height;

  /// Set when the mark sits on the brand gradient or any dark surface.
  final bool onDark;

  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          width: height * 1.22,
          child: CustomPaint(painter: _BrandMarkPainter(onDark: onDark)),
        ), // SizedBox
        if (showWordmark) ...[
          SizedBox(width: height * 0.22),
          Text(
            'Wingo',
            style: TextStyle(
              fontSize: height * 0.68,
              fontWeight: FontWeight.w800,
              letterSpacing: -height * 0.015,
              height: 1.0,
              color: onDark ? Colors.white : AppColors.ink,
            ), // TextStyle
          ), // Text
        ],
      ],
    ); // Row
  }
}

class _BrandMarkPainter extends CustomPainter {
  const _BrandMarkPainter({required this.onDark});

  final bool onDark;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.height;
    final center = Offset(size.width - s * 0.5, s * 0.5);
    final radius = s * 0.5;

    final discPaint = Paint();
    if (onDark) {
      discPaint.color = Colors.white;
    } else {
      discPaint.shader = AppColors.ctaGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    }
    canvas.drawCircle(center, radius, discPaint);

    // Motion lines trail the disc; the middle one runs longest for rake.
    const trails = [
      (y: 0.3, len: 0.52),
      (y: 0.5, len: 0.8),
      (y: 0.7, len: 0.46),
    ];
    final trailColor = onDark ? Colors.white : AppColors.primary;
    for (final trail in trails) {
      final endX = center.dx - radius * 0.95;
      final startX = endX - s * trail.len * 0.5;
      canvas.drawLine(
        Offset(startX.clamp(0.0, size.width), s * trail.y),
        Offset(endX, s * trail.y),
        Paint()
          ..strokeCap = StrokeCap.round
          ..strokeWidth = s * 0.085
          ..color = trailColor.withValues(alpha: trail.len),
      );
    }

    _paintChevronW(canvas, center, s);
  }

  /// A "W" built from chevron strokes so it reads as forward motion.
  void _paintChevronW(Canvas canvas, Offset center, double s) {
    final w = s * 0.46;
    final h = s * 0.3;
    final left = center.dx - w / 2;
    final top = center.dy - h / 2;

    final path = Path()
      ..moveTo(left, top)
      ..lineTo(left + w * 0.28, top + h)
      ..lineTo(left + w * 0.5, top + h * 0.34)
      ..lineTo(left + w * 0.72, top + h)
      ..lineTo(left + w, top);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = s * 0.11
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = onDark ? AppColors.primary : Colors.white,
    );
  }

  @override
  bool shouldRepaint(_BrandMarkPainter oldDelegate) =>
      oldDelegate.onDark != onDark;
}
