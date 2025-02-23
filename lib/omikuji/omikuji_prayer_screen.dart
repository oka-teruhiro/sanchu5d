import 'package:flutter/material.dart';
import 'dart:math';
import 'omikuji_bottom_sheet.dart';
import 'omikuji_service.dart';
import 'laser_beam_painter.dart';

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
  late AnimationController _buttonAnimController; //ボタン吸い込み用
  late Animation<double> _scaleAnimation; // 0→300のスケール
  late Animation<double> _pulseAnimation; // 1.0→0.8の脈動
  late Animation<Offset> _positionAnimation; // 追加：位置用
  bool _showOmikujiButton = false; // おみくじボタン表示制御
  bool _isMoving = false; // 追加：移動中フラグ
  bool _isTyping = false;
  double _typingScale = 1.0;
  final Random _random = Random();
  Offset _centralPoint = Offset.zero;
  final GlobalKey _kouroKey = GlobalKey(); // 光彩のキーを追加
  final List<LaserBeamWidget> _activeBeams = [];
  int? _currentCreatorId;  // 追加：creatorIDを保持するフィールド
  bool _isButtonAnimating = false;
  Offset _buttonStartPosition = Offset.zero;
  final GlobalKey _buttonKey = GlobalKey();

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

    // ボタンアニメーション用コントローラー
    _buttonAnimController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

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
    _buttonAnimController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _moveController.dispose(); // 追加
    super.dispose();
  }

  void _onOmikujiTap() async {
    // ボタンの位置を取得
    final RenderBox? buttonBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? kouroBox = _kouroKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonBox == null || kouroBox == null) return;

    _buttonStartPosition = buttonBox.localToGlobal(
        Offset(buttonBox.size.width / 2, buttonBox.size.height / 2)
    );

    setState(() {
      _isButtonAnimating = true;
    });

    // ボタンアニメーション
    await _buttonAnimController.forward();
    _buttonAnimController.reset();
    setState(() {
      _isButtonAnimating = false;
    });

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
        _currentCreatorId = result['data']['creatorId'] as int?;

        // デバッグ出力を追加
        print('Creator ID: $_currentCreatorId');  // creatorIdの値を確認

        if (mounted) Navigator.pop(context);

        if (mounted) {
          final creatorId = result['data']['creatorId'] as int?; // creatorIdを取得
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.transparent,
            // 背景を透明に設定
            transitionAnimationController: AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: Navigator.of(context),
            ),
            builder: (BuildContext context) {
              return OmikujiBottomSheet(
                omikuji: result['data'],
                onCharacterDisplay: onCharacterDisplay, // 追加
                onLineComplete: onLineComplete, // 追加
                onCharacterPosition: (position) {
                  _addLaserBeam(position, creatorId); // creatorIdを渡す
                },
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

  void _addLaserBeam(Offset targetPosition, int? creatorId) {
    final beamStart = _getKouroCenterPosition();
    //final int? creatorId = 1;  // ここは適切な形で取得する必要があります
    // 作成者IDに基づいて色を決定
    final Color beamColor = _getBeamColor(creatorId);
    setState(() {
      _activeBeams.add(
        LaserBeamWidget(
          startPoint: beamStart,
          endPoint: targetPosition,
          duration: const Duration(milliseconds: 100),
          color: beamColor,  // 色を指定
          onComplete: () {
            if (mounted) {
              setState(() {
                _activeBeams.removeAt(0);
              });
            }
          },
        ),
      );
    });
  }

  // 作成者IDに基づいて色を返すメソッド
  Color _getBeamColor(int? creatorId) {
    // デバッグ出力を追加
    print('Getting beam color for creator ID: $creatorId');
    if (creatorId == null) {
      print('Creator ID is null, using default color');
      return const Color(0xFF64FFDA);
    }


    // 作成者IDに基づいて色を決定
    switch (creatorId) {
      case 1:
        return Colors.purpleAccent;
      case 2:
        return Colors.lightBlueAccent;
      case 3:
        return Colors.lightGreenAccent;
      case 4:
        return Colors.yellowAccent;
      case 5:
        return Colors.red;
      default:
      // IDを使って色相を決定する方法
        return Colors.white;
    }
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

          // レーザービーム効果のレイヤー
          ..._activeBeams,

          Transform.translate(
            offset: Offset(0, h1 - hBottom - 10),
            child: SizedBox(
              child: Container(
                color: Colors.tealAccent,
              ),
            ),
          ),

          // 下部のボタン配置
          Transform.translate(
            offset: Offset(0, h1 - hBottom),
            child: SizedBox(
              height: hBottom,
              child: Container(
                color: Colors.black.withAlpha(120),
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
                                  '　おみくじを引く　',
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


          /*// アニメーション中のボタン
          if (_isButtonAnimating)
            AnimatedBuilder(
              animation: _buttonAnimController,
              builder: (context, child) {
                final targetPosition = _getKouroCenterPosition();
                final dx = _buttonStartPosition.dx +
                    (targetPosition.dx - _buttonStartPosition.dx) *
                        _buttonAnimController.value;
                final dy = _buttonStartPosition.dy +
                    (targetPosition.dy - _buttonStartPosition.dy) *
                        _buttonAnimController.value;
                final scale = 1.0 - _buttonAnimController.value;

                return Positioned(
                  left: dx - (50 * scale),  // ボタンの幅の半分
                  top: dy - (20 * scale),   // ボタンの高さの半分
                  child: Transform.scale(
                    scale: scale,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: null,
                      child: const Text(
                        'おみくじ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),*/
        ],
      ),
    );
  } // buildメソッドの終わり
} // クラスの終わり
