import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'omikuji_content_widget.dart';

// 画面下からおみくじの結果が出てくる
class OmikujiBottomSheet extends StatefulWidget {
  final Map<String, dynamic> omikuji;

  const OmikujiBottomSheet({
    Key? key,
    required this.omikuji,
  }) : super(key: key);

  @override
  State<OmikujiBottomSheet> createState() => _OmikujiBottomSheetState();
}

class _OmikujiBottomSheetState extends State<OmikujiBottomSheet>
    with TickerProviderStateMixin {
  // ２つのアニメーション
  // アニメーションに必要なミックスイン

  late AnimationController _controller; // アニメーションのコントローラー
  late Animation<double> _slideAnimation; // スライドアップ用
  late Animation<double> _pathAnimation; // パス描画用
  bool _canStartTextAnimation = false; // テキストアニメーション開始フラグ
  // 光彩アニメーション用の変数を追加
  double _currentScaleX = 1.0;
  double _currentScaleY = 1.0;
  // 回転用のアニメーションコントローラーを追加
  late AnimationController _rotationController;
  //late Animation<double> _rotationAnimation;

  late AnimationController _pulseController;
  late AnimationController _moveController; // 移動アニメーション用
  late Animation<double> _pulseAnimation;
  late Animation<double> _moveAnimation; // 移動用
  late Animation<Offset> _positionAnimation; // 位置移動用
  bool _isTypingText = false;

  final Random _random = Random(); // 光彩アニメーション用

  @override
  void initState() {
    super.initState();

    // 移動アニメーション (0.5秒)
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // イージングを使用して最初は早く、最後はゆっくりに
    _moveAnimation = CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeOut,
    );

    // 中央から上部への移動
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0), // 画面中央
      end: const Offset(0.0, -0.3), // 画面上部（調整可能）
    ).animate(_moveAnimation);

    // コントローラーの設定
    _controller = AnimationController(
      duration: const Duration(seconds: 4), // アニメーションの長さ
      vsync: this,
    );

    // スライドアップアニメーション(0-1秒)
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut), // 最初の30%
    );

    // 一筆書きアニメーション(1秒-3秒)
    _pathAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.linear),
    ));

    // 10秒周期の脈動アニメーション
    _pulseController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 0.6,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // 回転アニメーションの設定を追加
    _rotationController = AnimationController(
      duration: const Duration(seconds: 60), // 1回転の時間
      vsync: this,
    ); // 継続的な回転

    // アニメーション順序の制御
    _moveController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _controller.forward();
        _pulseController.repeat(reverse: true);
        _rotationController.repeat();
      });
    });

    /*_rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159, // 2π (1回転)
    ).animate(_rotationController);*/

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _canStartTextAnimation = true;
          // スライドアニメーション完了時に回転を開始
          //_rotationController.repeat();
        });
      }
    });
/*
    // 新しい伸縮アニメーションを追加
    _scaleXAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_controller);

    _scaleYAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_controller);

    // テキストアニメーションのタイミングで伸縮を更新
    _controller.addListener(() {
      if (_canStartTextAnimation) {
        setState(() {
          _scaleXAnimation = Tween<double>(
            begin: 1.0,
            end: 1.0 + (_random.nextDouble() * 0.1 - 0.05), // ±5%のランダムな伸縮
          ).animate(_controller);

          _scaleYAnimation = Tween<double>(
            begin: 1.0,
            end: 1.0 + (_random.nextDouble() * 0.1 - 0.05), // ±5%のランダムな伸縮
          ).animate(_controller);
        });
      }
    });*/

    // アニメーション開始
    _controller.forward(); //Todo:
  }

  // 文字表示時のコールバック
  void _onCharacterDisplay() {
    if (mounted) {
      setState(() {
        _isTypingText = true; // フラグ設定を追加
        _currentScaleX = 1.0 + (_random.nextDouble() * 0.2 - 0.1);
        _currentScaleY = _currentScaleX;
        //_currentScaleY = 1.0 + (_random.nextDouble() * 0.4 - 0.2);
      });
    }
  }

  // 行の表示が終わった時の処理を追加
  void _onLineComplete() {
    if (mounted) {
      setState(() {
        _isTypingText = false;
      });
    }
  }

  // 光彩画像のビルド部分を修正
  Widget _buildKosaiImage() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _moveController,
        _pulseController,
        _rotationController,
      ]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0,
              _positionAnimation.value.dy * MediaQuery.of(context).size.height),
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..scale(_isTypingText
                    ? _pulseAnimation.value * _currentScaleX
                    : _pulseAnimation.value)
                ..rotateZ(_rotationController.value * 2 * pi),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/omikuji/光彩.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // コントローラーの破棄
    _rotationController.dispose(); // 回転コントローラーの破棄を追加
    _pulseController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w0 = MediaQuery.of(context).size.width;
    double h0 = MediaQuery.of(context).size.height;
    double hTop = 24; // 80
    double hBottom = 56; // 戻るボタンエリヤの高さ
    double wKazari = 50; //飾り枠pad幅
    double h1 = h0 - hTop;
    double h2 = 100; // 光彩のぞき窓の高さ

    return SizeTransition(
      // サイズ変更アニメーション
      sizeFactor: _slideAnimation,
      axis: Axis.vertical,
      child: SizedBox(
        width: w0,
        height: h1 - h2, // おみくじシートの高さ
        child: Container(
          color: Colors.teal.withAlpha(50), // おみくじシートに色をつけ透かす
          child: Stack(
            children: [
              // 光彩画像のレイヤー
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildKosaiImage(),
                ],
              ),
              // 飾り枠のレイヤー
              Transform.translate(
                offset: const Offset(0, 0),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _pathAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: BorderPainter(_pathAnimation.value),
                          size: Size(w0, h1 - h2 - hBottom), // 飾り枠の高さ決める
                        );
                      },
                    ),
                  ],
                ),
              ),

              // メインコンテンツ領域
              Transform.translate(
                offset: const Offset(0, 100),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(wKazari),
                        child: OmikujiContentWidget(
                          omikuji: widget.omikuji,
                          contentHeight:
                              h0 - hTop - hBottom - wKazari * 2 - 100 - 66,
                          contentWidth: w0 - wKazari * 2,
                          canStartAnimation: _canStartTextAnimation,
                          // フラグを渡す
                          onCharacterDisplay: _onCharacterDisplay, // コールバックを追加
                          onLineComplete: _onLineComplete, // 追加
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 戻るボタン
              Transform.translate(
                offset: Offset(0, h1 - h2 - hBottom),
                child: SizedBox(
                  height: hBottom,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            '戻る',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final double progress;
  final Paint _paint;

  BorderPainter(this.progress)
      : _paint = Paint()
          ..color = const Color(0xFF64FFDA)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double w0 = size.width;
    double h1 = size.height;

    var path = Path();
    path.moveTo(10, 100);
    path.lineTo(10, 50);
    path.lineTo(30, 50);
    path.lineTo(30, 10);
    path.lineTo(40, 10);
    path.lineTo(40, 20);
    path.lineTo(10, 20);
    path.lineTo(10, 10);
    path.lineTo(20, 10);
    path.lineTo(20, 40);
    path.lineTo(10, 40);
    path.lineTo(10, 30);
    path.lineTo(50, 30);
    path.lineTo(50, 10);
    path.lineTo(w0 - 50, 10);
    path.lineTo(w0 - 50, 30);
    path.lineTo(w0 - 10, 30);
    path.lineTo(w0 - 10, 40);
    path.lineTo(w0 - 20, 40);
    path.lineTo(w0 - 20, 10);
    path.lineTo(w0 - 10, 10);
    path.lineTo(w0 - 10, 20);
    path.lineTo(w0 - 40, 20);
    path.lineTo(w0 - 40, 10);
    path.lineTo(w0 - 30, 10);
    path.lineTo(w0 - 30, 50);
    path.lineTo(w0 - 10, 50);
    path.lineTo(w0 - 10, h1 - 50 );
    path.lineTo(w0 - 30, h1 - 50 );
    path.lineTo(w0 - 30, h1 - 10 );
    path.lineTo(w0 - 40, h1 - 10 );
    path.lineTo(w0 - 40, h1 - 20 );
    path.lineTo(w0 - 10, h1 - 20 );
    path.lineTo(w0 - 10, h1 - 10 );
    path.lineTo(w0 - 20, h1 - 10 );
    path.lineTo(w0 - 20, h1 - 40 );
    path.lineTo(w0 - 10, h1 - 40 );
    path.lineTo(w0 - 10, h1 - 30 );
    path.lineTo(w0 - 50, h1 - 30 );
    path.lineTo(w0 - 50, h1 - 10 );
    path.lineTo(50, h1 - 10 );
    path.lineTo(50, h1 - 30 );
    path.lineTo(10, h1 - 30 );
    path.lineTo(10, h1 - 40 );
    path.lineTo(20, h1 - 40 );
    path.lineTo(20, h1 - 10 );
    path.lineTo(10, h1 - 10 );
    path.lineTo(10, h1 - 20 );
    path.lineTo(40, h1 - 20 );
    path.lineTo(40, h1 - 10 );
    path.lineTo(30, h1 - 10 );
    path.lineTo(30, h1 - 50 );
    path.lineTo(10, h1 - 50 );
    path.lineTo(10, 100);

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, _paint);
    }
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
