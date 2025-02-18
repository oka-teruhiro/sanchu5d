import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'laser_beam_painter.dart';  // 新しく追加

class OmikujiContentWidget extends StatefulWidget {
  final Map<String, dynamic> omikuji;
  final double contentHeight;
  final double contentWidth;
  final bool canStartAnimation; // アニメーション開始制御用のフラグを追加
  final VoidCallback? onCharacterDisplay;
  final VoidCallback? onLineComplete;
  final Offset? centralPoint; // 光彩の中心点を受け取る

  const OmikujiContentWidget({
    Key? key,
    required this.omikuji,
    required this.contentHeight,
    required this.contentWidth,
    required this.canStartAnimation, // 新しいプロパティ
    this.onCharacterDisplay,
    this.onLineComplete,
    this.centralPoint, // 追加
  }) : super(key: key);

  @override
  State<OmikujiContentWidget> createState() => _OmikujiContentWidgetState();
}

class _OmikujiContentWidgetState extends State<OmikujiContentWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<String> _displayedContent = [];
  String _currentText = '';
  int _currentLine = 0;
  int _currentChar = 0;
  bool _isAnimationComplete = false;
  bool _hasStartedAnimation = false; // アニメーション開始状態の追跡
  final List<LaserBeamWidget> _activeBeams = [];
  final GlobalKey _contentKey = GlobalKey();
  late TextStyle _textStyle;
  //Offset? _lastCharPosition;

  /*void _updateLastCharPosition(String text, TextStyle style) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_contentKey.currentContext != null) {
        final RenderBox box = _contentKey.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        // テキストの位置を計算
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        _lastCharPosition = Offset(
          position.dx + textPainter.width,
          position.dy,
        );

        // レーザービームを追加
        if (widget.centralPoint != null) {
          setState(() {
            _activeBeams.add(
              LaserBeamWidget(
                startPoint: widget.centralPoint!,
                endPoint: _lastCharPosition!,
                duration: const Duration(milliseconds: 200),
                onComplete: () {
                  setState(() {
                    _activeBeams.removeAt(0);
                  });
                },
              ),
            );
          });
        }
      }
    });
  }*/

  @override
  void didUpdateWidget(OmikujiContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.canStartAnimation && !_hasStartedAnimation) {
      _hasStartedAnimation = true;
      _startAnimation();
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _animateText();
    });
  }

  void _animateText() async {
    final content = List<String>.from(widget.omikuji['content']);
    if (_currentLine >= content.length) {
      setState(() {
        _isAnimationComplete = true;
      });
      return;
    }

    if (_currentChar >= content[_currentLine].length) {
      setState(() {
        _displayedContent.add(_currentText);
        _currentText = '';
        _currentChar = 0;
        _currentLine++;
        if (widget.onLineComplete != null) {
          widget.onLineComplete!();
        } // 追加
      });

      await Future.delayed(const Duration(milliseconds: 700)); // 改行時間
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50), // 改行移動時間
          curve: Curves.easeOut,
        );
      }

      await Future.delayed(const Duration(milliseconds: 100)); // 100
      _animateText();
      return;
    }

    setState(() {
      _currentText = content[_currentLine].substring(0, _currentChar + 1);
      _currentChar++;

      // レーザービーム効果のトリガー
      if (widget.centralPoint != null) {
        _addLaserBeam();
      }

      // ここでアニメーションコントローラーに通知
      if (widget.onCharacterDisplay != null) {
        widget.onCharacterDisplay!();
      }
    });

    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }

    await Future.delayed(const Duration(milliseconds: 40)); // 50 文字間隔
    _animateText();
  }

  // 新しく追加するメソッド
  void _addLaserBeam() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_contentKey.currentContext != null) {
        final RenderBox box = _contentKey.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        final content = List<String>.from(widget.omikuji['content']);
        final lineText = content[_currentLine].substring(0, _currentChar);

        // 現在の文字の位置を計算
        final textPainter = TextPainter(
          text: TextSpan(
            text: lineText,
            style: _textStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        // 縦方向のパディングを計算
        final double verticalPadding = ((widget.contentHeight -
            ((content.length * (_textStyle.fontSize ?? 20)) +
                ((content.length - 1) * (_textStyle.fontSize ?? 20) * (_textStyle.height ?? 1.0)))) /
            2).clamp(0.0, double.infinity);

        final charPosition = Offset(
          position.dx + textPainter.width,
          position.dy + verticalPadding + (_currentLine * (_textStyle.fontSize ?? 20) * (_textStyle.height ?? 1.0)),  // 縦位置：パディング + 行数 * 行の高さ
        );

        setState(() {
          _activeBeams.add(
            LaserBeamWidget(
              startPoint: widget.centralPoint!,
              endPoint: charPosition,
              duration: const Duration(milliseconds: 200),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = List<String>.from(widget.omikuji['content']);

    // 水平方向のパディングと行間係数を変数化
    final double gk = 1.0; // 行間係数（要調整）：フォントサイズの何倍にするか
    final double webk = kIsWeb ? 20 : 0;
    double verticalPadding = 0;

    // 利用可能な幅と高さを計算
    final availableWidth = widget.contentWidth - webk;
    final availableHeight = widget.contentHeight; // 上下のパディングを考慮

    // 最大文字数を取得
    final maxLength = content.fold<int>(
      0,
      (maxLen, line) => line.length > maxLen ? line.length : maxLen,
    );
    // フォントサイズを計算
    final calculatedFontSize = (availableWidth / maxLength) * 1.0; // 係数を1.0に調整
    final baseFontSize = calculatedFontSize.clamp(13.0, 60.0);
    // 1行の高さを計算（フォントサイズ + 行間）
    final lineHeight = baseFontSize * (1 + gk);
    // 全行数
    final totalLines = content.length;

    final double hPadTop = ((availableHeight -
                ((totalLines * baseFontSize) +
                    ((totalLines - 1) * baseFontSize * gk))) /
            2) -
        (lineHeight / 2);

    verticalPadding = hPadTop > 0 ? hPadTop : 0;

    _textStyle = TextStyle(
      fontSize: baseFontSize,
      color: Colors.white,
      height: 1 + gk,
    );

    print('Available width: $availableWidth');
    print('Available height: $availableHeight');
    print('Available height: $availableHeight');
    print('Max length: $maxLength');
    print('Font size: $baseFontSize');
    print('Total lines: $totalLines');
    print('Vertical padding: $verticalPadding');
    print('hPadTop: $hPadTop');

    return Stack(
      children: [
        Container(
          key: _contentKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                physics: _isAnimationComplete
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  width: double.infinity, // 精一杯に広げる
                  child: Padding(
                        padding: EdgeInsets.only(
                          top: verticalPadding,
                          bottom: verticalPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._displayedContent.map((text) {
                              if (text.isEmpty) {
                                return SizedBox(height: lineHeight);
                              }
                              return Text(
                                text,
                                style: _textStyle,
                                textAlign: TextAlign.left,
                              );
                            }),
                            if (_currentLine < content.length)
                              Container(
                                alignment: Alignment.centerLeft, // 左揃えを強制
                                child: Text(
                                  _currentText,
                                  style: _textStyle,
                                ),
                              ),
                          ],
                        ),
                      ),

                  ),
              );
            },
          ),
        ),
        // レーザービーム効果のレイヤー
        ..._activeBeams,
      ],
    );
  }
}
