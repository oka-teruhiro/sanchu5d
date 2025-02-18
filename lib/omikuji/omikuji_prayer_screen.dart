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
  //bool _isTypingText = false;
  bool _isTyping = false;
  double _typingScale = 1.0;
  final Random _random = Random();
  Offset _centralPoint = Offset.zero;
  final GlobalKey _kouroKey = GlobalKey(); // 光彩のキーを追加

  @override
  void initState() {
    super.initState();

    // 初期拡大アニメーション (0→300 / 2秒)
    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
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

    final centralPoint = _getKouroCenterPosition();

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
                onCharacterDisplay: onCharacterDisplay,  // 追加
                onLineComplete: onLineComplete,          // 追加
                centralPoint: centralPoint, // 実際の光彩の中心位置を渡す
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

  void onCharacterDisplay() {
    setState(() {
      _isTyping = true;
      _typingScale = 1.0 - (_random.nextDouble() * 0.3); // 1.0-1.3の範囲で変化
    });
  }

  void onLineComplete() {
    setState(() {
      _isTyping = false;
      _typingScale = 1.0;
    });
  }

  // 光彩の中心位置を取得するメソッドを追加
  Offset _getKouroCenterPosition() {
    if (_kouroKey.currentContext == null) return Offset.zero;

    final RenderBox box = _kouroKey.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
        Offset(box.size.width / 2, box.size.height / 2)
    );
    return position;
  }



  @override
  Widget build(BuildContext context) {
    double h0 = MediaQuery.of(context).size.height;
    double hTop = 0; // 80
    double hBottom = 56; // 戻るボタンエリヤの高さ
    double h1 = h0 - hTop;
    final Size screenSize = MediaQuery.of(context).size;
    _centralPoint = Offset(
      screenSize.width / 2,
      (screenSize.height / 2) - (_positionAnimation.value.dy * screenSize.height),
    );

    // buildメソッドをクラス内に移動
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // 光彩アニメーション
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _scaleController,//todo
                _rotationController,
                _pulseController,
                _moveController,
              ]),
              builder: (context, child) {
                final baseScale = _isTyping
                    ? _typingScale
                    : (_isMoving
                      ? (300.0 / 400.0)
                      : _scaleAnimation.value / 300.0);  // 初期アニメーションを適用

                final scale = baseScale * _pulseAnimation.value;

                return Transform.translate(
                  offset: _positionAnimation.value *
                      MediaQuery.of(context).size.height,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(scale)
                      ..rotateZ(_rotationController.value * 2 * pi),
                    child: SizedBox(
                      key: _kouroKey, // キーを追加
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
          Transform.translate(
            offset: Offset(0, h1 - hBottom),
            child: SizedBox(
              height: hBottom,
              child: Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 左側：祈ってください/おみくじを引くボタン
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedSwitcher(
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
          ),
        ],
      ),
    );
  } // buildメソッドの終わり
} // クラスの終わり
