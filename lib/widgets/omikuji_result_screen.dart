// lib/widgets/omikuji_result_screen.dart を新規作成
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' show pi;
import '../models/omikuji.dart';              // 追加
import '../utils/fortune_level_utils.dart';    // 追加



class OmikujiResultScreen extends StatefulWidget {
  final Omikuji omikuji;

  const OmikujiResultScreen({
    Key? key,
    required this.omikuji,
  }) : super(key: key);

  @override
  State<OmikujiResultScreen> createState() => _OmikujiResultScreenState();
}

class _OmikujiResultScreenState extends State<OmikujiResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.tealAccent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.tealAccent,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      FortuneLevelUtils.getFortuneLevelText(widget.omikuji.fortuneLevel),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...widget.omikuji.content.map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        line,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          // コーナー装飾
          const Positioned(
            left: 0,
            top: 0,
            child: CornerDecoration(corner: 1),
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: CornerDecoration(corner: 2),
          ),
          const Positioned(
            left: 0,
            bottom: 0,
            child: CornerDecoration(corner: 3),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: CornerDecoration(corner: 4),
          ),
        ],
      ),
    );
  }
}

class CornerDecoration extends StatelessWidget {
  final double size;
  final int corner;

  const CornerDecoration({
    Key? key,
    this.size = 50.0,
    required this.corner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (corner - 1) * pi / 2,
      child: SvgPicture.string(
        '''
        <svg width="$size" height="$size" viewBox="0 0 100 100">
          <path
            d="M 10 90 C 40 90, 40 90, 40 60 C 40 40, 40 40, 60 40 C 90 40, 90 40, 90 10"
            stroke="#8B4513"
            stroke-width="4"
            fill="none"
          />
          <path
            d="M 20 80 C 35 80, 35 80, 35 65 C 35 50, 35 50, 50 50 C 80 50, 80 50, 80 20"
            stroke="#8B4513"
            stroke-width="4"
            fill="none"
          />
        </svg>
        ''',
        width: size,
        height: size,
      ),
    );
  }
}