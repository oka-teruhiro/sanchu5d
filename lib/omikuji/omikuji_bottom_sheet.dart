import 'dart:ui';
import 'package:flutter/material.dart';
import 'omikuji_content_widget.dart';

// 画面下からおみくじの結果が出てくる
class OmikujiBottomSheet extends StatefulWidget {
  final Map<String, dynamic> omikuji;
  final VoidCallback? onCharacterDisplay; // 追加
  final VoidCallback? onLineComplete; // 追加
  final Offset? centralPoint; // 追加

  const OmikujiBottomSheet({
    Key? key,
    required this.omikuji,
    this.onCharacterDisplay, // 追加
    this.onLineComplete, // 追加
    this.centralPoint, // 追加
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
      curve: const Interval(0.2, 1.0, curve: Curves.linear),
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _canStartTextAnimation = true;
        });
      }
    });

    // アニメーション開始
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // コントローラーの破棄
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w0 = MediaQuery.of(context).size.width;
    double h0 = MediaQuery.of(context).size.height;
    double hTop = 0; // 80
    double hBottom = 56; // 戻るボタンエリヤの高さ
    double wKazari = 50; //飾り枠pad幅
    double h1 = h0 - hTop;
    double h2 = 100; // 光彩のぞき窓の高さ
    double h5 = h0 - hTop - h2 - hBottom - (wKazari * 2);
    double w5 = w0 - (wKazari * 2);

    return SizeTransition(
      // サイズ変更アニメーション
      sizeFactor: _slideAnimation,
      axis: Axis.vertical,
      child: SizedBox(
        width: w0,
        height: h1 - h2, // おみくじシートの高さ
        child: Container(
          color: Colors.black.withAlpha(150), // おみくじシートに色をつけ透かす
          child: Stack(
            children: [
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
                offset: Offset(wKazari, wKazari),
                child: Column(
                  children: [
                    SizedBox(
                      height: h5,
                      width: w5,
                      child: OmikujiContentWidget(
                        omikuji: widget.omikuji,
                        contentHeight: h5,
                        contentWidth: w5,
                        canStartAnimation: _canStartTextAnimation, // フラグを渡す
                        onCharacterDisplay: widget.onCharacterDisplay, // コールバックを追加
                        onLineComplete: widget.onLineComplete , // 追加
                        centralPoint: widget.centralPoint, // 追加
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
                              fontSize: 16,
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
    path.lineTo(w0 - 10, h1 - 50);
    path.lineTo(w0 - 30, h1 - 50);
    path.lineTo(w0 - 30, h1 - 10);
    path.lineTo(w0 - 40, h1 - 10);
    path.lineTo(w0 - 40, h1 - 20);
    path.lineTo(w0 - 10, h1 - 20);
    path.lineTo(w0 - 10, h1 - 10);
    path.lineTo(w0 - 20, h1 - 10);
    path.lineTo(w0 - 20, h1 - 40);
    path.lineTo(w0 - 10, h1 - 40);
    path.lineTo(w0 - 10, h1 - 30);
    path.lineTo(w0 - 50, h1 - 30);
    path.lineTo(w0 - 50, h1 - 10);
    path.lineTo(50, h1 - 10);
    path.lineTo(50, h1 - 30);
    path.lineTo(10, h1 - 30);
    path.lineTo(10, h1 - 40);
    path.lineTo(20, h1 - 40);
    path.lineTo(20, h1 - 10);
    path.lineTo(10, h1 - 10);
    path.lineTo(10, h1 - 20);
    path.lineTo(40, h1 - 20);
    path.lineTo(40, h1 - 10);
    path.lineTo(30, h1 - 10);
    path.lineTo(30, h1 - 50);
    path.lineTo(10, h1 - 50);
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
