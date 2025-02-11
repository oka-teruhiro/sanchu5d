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
    with TickerProviderStateMixin {  // ２つのアニメーション
  // アニメーションに必要なミックスイン

  late AnimationController _controller; // アニメーションのコントローラー
  late Animation<double> _slideAnimation; // スライドアップ用
  late Animation<double> _pathAnimation; // パス描画用
  bool _canStartTextAnimation = false; // テキストアニメーション開始フラグ
  //late Animation<double> _scaleXAnimation; // 光彩アニメーション用ｘ軸
  //late Animation<double> _scaleYAnimation; // 光彩アニメーション用ｙ軸
  // 光彩アニメーション用の変数を追加
  double _currentScaleX = 1.0;
  double _currentScaleY = 1.0;
  // 回転用のアニメーションコントローラーを追加
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  Random _random = Random(); // 光彩アニメーション用

  // 文字表示時のコールバック
  void _onCharacterDisplay() {
    if (mounted) {
      setState(() {
        _currentScaleX = 1.0 + (_random.nextDouble() * 0.1 - 0.05);
        _currentScaleY = _currentScaleX;
        //_currentScaleY = 1.0 + (_random.nextDouble() * 0.4 - 0.2);
      });
    }
  }

  @override
  void initState() {
    super.initState();

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
      curve: const Interval(0.2, 0.95, curve: Curves.linear),
    ));

    // 回転アニメーションの設定を追加
    _rotationController = AnimationController(
      duration: const Duration(seconds: 60), // 1回転の時間
      vsync: this,
    ); // 継続的な回転

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159, // 2π (1回転)
    ).animate(_rotationController);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _canStartTextAnimation = true;
          // スライドアニメーション完了時に回転を開始
          _rotationController.repeat();
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
    _controller.forward();
  }

  // 光彩画像のビルド部分を修正
  Widget _buildKosaiImage() {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50), // アニメーションの持続時間
        transform: Matrix4.identity()
          ..scale(_currentScaleX, _currentScaleY)
          ..rotateZ(_rotationAnimation.value), // 回転を追加
        transformAlignment: Alignment.center,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          // color: Colors.orange, // デバッグ用
          image: DecorationImage(
            image: AssetImage('assets/images/omikuji/光彩.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // コントローラーの破棄
    _rotationController.dispose(); // 回転コントローラーの破棄を追加
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w0 = MediaQuery
        .of(context)
        .size
        .width;
    double h0 = MediaQuery
        .of(context)
        .size
        .height;
    double hTop = 24; // 80
    double hBottom = 56;
    double wKazari = 50; //飾り枠pad幅
    double h1 = h0 - hTop;

    return SizeTransition(
      // サイズ変更アニメーション
      sizeFactor: _slideAnimation,
      axis: Axis.vertical,
      child: SizedBox(
        width: w0,
        height: h1,
        child: Container(
          color: Colors.black, // todo:
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
                offset: const Offset(0, 100),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _pathAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: BorderPainter(_pathAnimation.value),
                          size: Size(w0, h1 - 100),
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
                          contentHeight: h0 - hTop - hBottom - wKazari * 2 -
                              100 - 66,
                          contentWidth: w0 - wKazari * 2,
                          canStartAnimation: _canStartTextAnimation,
                          // フラグを渡す
                          onCharacterDisplay: _onCharacterDisplay, // コールバックを追加
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              // 戻るボタン
              Transform.translate(
                offset: Offset(0, h1 - 60),
                child: SizedBox(
                  height: 60,
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
    double h2 = 56;

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
    path.lineTo(w0 - 10, h1 - 50 - h2);
    path.lineTo(w0 - 30, h1 - 50 - h2);
    path.lineTo(w0 - 30, h1 - 10 - h2);
    path.lineTo(w0 - 40, h1 - 10 - h2);
    path.lineTo(w0 - 40, h1 - 20 - h2);
    path.lineTo(w0 - 10, h1 - 20 - h2);
    path.lineTo(w0 - 10, h1 - 10 - h2);
    path.lineTo(w0 - 20, h1 - 10 - h2);
    path.lineTo(w0 - 20, h1 - 40 - h2);
    path.lineTo(w0 - 10, h1 - 40 - h2);
    path.lineTo(w0 - 10, h1 - 30 - h2);
    path.lineTo(w0 - 50, h1 - 30 - h2);
    path.lineTo(w0 - 50, h1 - 10 - h2);
    path.lineTo(50, h1 - 10 - h2);
    path.lineTo(50, h1 - 30 - h2);
    path.lineTo(10, h1 - 30 - h2);
    path.lineTo(10, h1 - 40 - h2);
    path.lineTo(20, h1 - 40 - h2);
    path.lineTo(20, h1 - 10 - h2);
    path.lineTo(10, h1 - 10 - h2);
    path.lineTo(10, h1 - 20 - h2);
    path.lineTo(40, h1 - 20 - h2);
    path.lineTo(40, h1 - 10 - h2);
    path.lineTo(30, h1 - 10 - h2);
    path.lineTo(30, h1 - 50 - h2);
    path.lineTo(10, h1 - 50 - h2);
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
