// lib/widgets/omikuji_result_screen.dart を新規作成
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:win32/win32.dart';
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
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),   // 画面下から開始
      end: const Offset(0.0, 0.0),     // 画面の上から20%の位置で停止
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
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
      backgroundColor: Colors.black87,
      body: SlideTransition(
        position: _slideAnimation,
        child: Stack(
          children: [
            FrameDecoration(
              width: (MediaQuery.of(context).size.width) * 1.0,
              height: (MediaQuery.of(context).size.height) * 1.0,
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),


                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      //const SizedBox(height: 20),
                      ...widget.omikuji.content.map((line) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
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
              top: 60,
              child: CornerDecoration(
                  corner: 1,
                  //style: 5
              ), // スタイル5を使用
            ),
            const Positioned(
              right: 0,
              top: 60,
              child: CornerDecoration(
                  corner: 2,
                  //style: 5
              ),
            ),
            const Positioned(
              left: 0,
              bottom: 80,
              child: CornerDecoration(
                  corner: 4,
                  //style: 6
              ), // スタイル6を使用
            ),
            const Positioned(
              right: 0,
              bottom: 80,
              child: CornerDecoration(
                  corner: 3,
                  //style: 6
              ),
            ),
            // 戻るボタンを追加
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    side: const BorderSide(
                      color: Colors.tealAccent,
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    '戻る',
                    style: TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CornerDecoration extends StatelessWidget {
  final double size;
  final int corner;
  //final int style; // 5または6を指定

  const CornerDecoration({
    Key? key,
    this.size = 80.0,
    required this.corner,
    //required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (corner - 1) * pi / 2,
      child: SvgPicture.string(
        '''
        <svg width="$size" height="$size" viewBox="0 0 100 100">
          <!-- メインの渦巻きパターン -->
          <path
            d="M 10 100
              L 10 30
              L 30 30
              L 30 10
              L 100 10"
            stroke="#64FFDA"
            stroke-width="2"
            
            fill="none"
          />
          <!-- サブの渦巻き -->
          <path
            d="M 10 10
               L 10 20
               L 40 20
               L 40 40
               L 20 40
               L 20 10
               L 10 10"
            stroke="#64FFDA"
            stroke-width="2"
            
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

class FrameDecoration extends StatelessWidget {
  final double width;
  final double height;

  const FrameDecoration({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''
      <svg width="$width" height="$height" viewBox="0 0 $width $height">
        
        <line
          x1="120" y1="69"
          x2="${width-120}" y2="69"
          stroke="#64FFDA"
          stroke-width="2"
        />
        <line
          x1="120" y1="${height-88}"
          x2="${width-120}" y2="${height-88}"
          stroke="#64FFDA"
          stroke-width="2"
        />

      </svg>
      ''',
      width: width,
      height: height,
    );
  }
}