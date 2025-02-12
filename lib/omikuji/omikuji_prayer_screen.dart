import 'package:flutter/material.dart';
import 'dart:math';

class OmikujiPrayerScreen extends StatefulWidget {
  const OmikujiPrayerScreen({super.key});

  @override
  State<OmikujiPrayerScreen> createState() => _OmikujiPrayerScreenState();
}

class _OmikujiPrayerScreenState extends State<OmikujiPrayerScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;    // 初期拡大用
  late AnimationController _rotationController; // 回転用
  late AnimationController _pulseController;    // 脈動用
  late Animation<double> _scaleAnimation;       // 0→300のスケール
  late Animation<double> _pulseAnimation;       // 1.0→0.8の脈動
  bool _showOmikujiButton = false;             // おみくじボタン表示制御

  @override
  void initState() {
    super.initState();

    // 初期拡大アニメーション (0→300 / 2秒)
    _scaleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ));

    // 回転アニメーション (60秒/1回転)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );

    // 脈動アニメーション (10秒周期)
    _pulseController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // 1秒後に拡大開始
    Future.delayed(const Duration(seconds: 1), () {
      _scaleController.forward();
    });

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.repeat();
        _pulseController.repeat(reverse: true);
      }
    });

    // 3秒後におみくじボタンを表示
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showOmikujiButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 光彩アニメーション
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _scaleController,
                _rotationController,
                _pulseController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(
                      _scaleAnimation.value * _pulseAnimation.value / 300,
                    )
                    ..rotateZ(_rotationController.value * 2 * pi),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'assets/images/omikuji/光彩.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          // 下部のボタン配置
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左側：祈ってください/おみくじを引くボタン
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _showOmikujiButton
                        ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        // おみくじを引く処理
                        Navigator.pop(context, true);
                      },
                      child: const Text(
                        'おみくじを引く',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                        : const Text(
                      '祈ってください',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // 右側：戻るボタン
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      '戻る',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}