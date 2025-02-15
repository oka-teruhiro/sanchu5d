import 'package:flutter/material.dart';
import 'dart:math';

import 'omikuji_bottom_sheet.dart';
import 'omikuji_service.dart';

class OmikujiPrayerScreen extends StatefulWidget {
  const OmikujiPrayerScreen({super.key});

  @override
  State<OmikujiPrayerScreen> createState() => _OmikujiPrayerScreenState();
}

class _OmikujiPrayerScreenState extends State<OmikujiPrayerScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController; // 初期拡大用
  late AnimationController _rotationController; // 回転用
  late AnimationController _pulseController; // 脈動用
  late AnimationController _moveController; // 追加：移動用
  late Animation<double> _scaleAnimation; // 0→300のスケール
  late Animation<double> _pulseAnimation; // 1.0→0.8の脈動
  late Animation<Offset> _positionAnimation; // 追加：位置用
  bool _showOmikujiButton = false; // おみくじボタン表示制御
  bool _isMoving = false; // 追加：移動中フラグ

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

    // 移動アニメーション (0.5秒)を追加
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 中心から上部への移動
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -0.4),
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeOut,
    ));

    // 回転アニメーション (60秒/1回転)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );

    // 脈動アニメーション (10秒周期)
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
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
    Future.delayed(const Duration(milliseconds: 300), () {
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
    _moveController.dispose(); // 追加
    super.dispose();
  }

  void _onOmikujiTap() async {
    setState(() {
      _isMoving = true;
    });

    await _moveController.forward();

    // ここでおみくじを表示
    if (mounted) {
      try {
        // ローディング表示
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent,
              ),
            );
          },
        );

        // データ取得
        final omikujiService = OmikujiService();
        final result =
            await omikujiService.selectOmikujiByTiming(DateTime.now());

        if (mounted) Navigator.pop(context);

        if (mounted) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.transparent,  // 背景を透明に設定
            transitionAnimationController: AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: Navigator.of(context),
            ),
            builder: (BuildContext context) {
              return OmikujiBottomSheet(
                omikuji: result['data'],
              );
            },
          );
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
//}

  @override
  Widget build(BuildContext context) {
    // buildメソッドをクラス内に移動
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
                _moveController,
              ]),
              builder: (context, child) {
                final scale = _isMoving
                    ? (300.0 / 400.0) * _pulseAnimation.value
                    : _scaleAnimation.value * _pulseAnimation.value / 300;

                return Transform.translate(
                  offset: _positionAnimation.value *
                      MediaQuery.of(context).size.height,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(scale)
                      ..rotateZ(_rotationController.value * 2 * pi),
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: Image.asset(
                        'assets/images/omikuji/光彩.jpg',
                        fit: BoxFit.cover,
                      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 左側：祈ってください/おみくじを引くボタン
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _showOmikujiButton
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: _onOmikujiTap,
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
  } // buildメソッドの終わり
} // クラスの終わり
