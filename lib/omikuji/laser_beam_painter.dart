// laser_beam_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LaserBeamPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final double progress;
  final Color beamColor;

  LaserBeamPainter({
    required this.startPoint,
    required this.endPoint,
    required this.progress,
    this.beamColor = const Color(0xFF64FFDA),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    // メインビームのパス
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    // 現在のプログレスに基づいて終点を計算
    final currentEnd = Offset(
      startPoint.dx + (endPoint.dx - startPoint.dx) * progress,
      startPoint.dy + (endPoint.dy - startPoint.dy) * progress,
    );
    path.lineTo(currentEnd.dx, currentEnd.dy);

    // グラデーション効果
    final gradient = LinearGradient(
      colors: [
        beamColor.withOpacity(0.8),
        beamColor.withOpacity(0.1),
      ],
    );

    // メインビーム描画
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromPoints(startPoint, currentEnd))
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    // 光の粒子効果
    final particlePaint = Paint()
      ..color = beamColor.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);
    final particleCount = 5;

    for (var i = 0; i < particleCount; i++) {
      final t = random.nextDouble() * progress;
      final particlePosition = Offset(
        startPoint.dx + (endPoint.dx - startPoint.dx) * t,
        startPoint.dy + (endPoint.dy - startPoint.dy) * t,
      );

      canvas.drawCircle(
        particlePosition,
        random.nextDouble() * 2.0,
        particlePaint,
      );
    }

    // ビーム先端の光球効果
    if (progress > 0.9) {
      final glowPaint = Paint()
        ..color = beamColor.withOpacity((progress - 0.9) * 5)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(currentEnd, 4.0, glowPaint);
    }
  }

  @override
  bool shouldRepaint(LaserBeamPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.startPoint != startPoint ||
        oldDelegate.endPoint != endPoint;
  }
}

class LaserBeamWidget extends StatefulWidget {
  final Offset startPoint;
  final Offset endPoint;
  final VoidCallback? onComplete;
  final Duration duration;

  const LaserBeamWidget({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    this.onComplete,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<LaserBeamWidget> createState() => _LaserBeamWidgetState();
}

class _LaserBeamWidgetState extends State<LaserBeamWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: LaserBeamPainter(
            startPoint: widget.startPoint,
            endPoint: widget.endPoint,
            progress: _progressAnimation.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}