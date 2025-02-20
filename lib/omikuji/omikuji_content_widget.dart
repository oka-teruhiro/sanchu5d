import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
typedef OnCharacterPositionCallback = void Function(Offset position);

class OmikujiContentWidget extends StatefulWidget {
  final Map<String, dynamic> omikuji;
  final double contentHeight;
  final double contentWidth;
  final bool canStartAnimation; // アニメーション開始制御用のフラグを追加
  final VoidCallback? onCharacterDisplay;
  final VoidCallback? onLineComplete;
  final OnCharacterPositionCallback? onCharacterPosition; // タイプアウトしている文字の中心点を渡す

  const OmikujiContentWidget({
    Key? key,
    required this.omikuji,
    required this.contentHeight,
    required this.contentWidth,
    required this.canStartAnimation, // 新しいプロパティ
    this.onCharacterDisplay,
    this.onLineComplete,
    this.onCharacterPosition,
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
  final GlobalKey _contentKey = GlobalKey();
  late TextStyle _textStyle;

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

      _notifyCharacterPosition();

      // ここでアニメーションコントローラーに通知
      if (widget.onCharacterDisplay != null) {
        widget.onCharacterDisplay!();
      }
    });

    await Future.delayed(const Duration(milliseconds: 150));

    await Future.delayed(const Duration(milliseconds: 40)); // 50 文字間隔
    _animateText();
  }

  // パディング計算用のメソッドを追加
  double _calculateVerticalPadding(List<String> content, TextStyle style) {
    final fontSize = style.fontSize ?? 20;
    final height = style.height ?? 1.0;
    final totalTextHeight = content.length * fontSize + (content.length - 1) * fontSize * (height - 1);
    return ((widget.contentHeight - totalTextHeight) / 2).clamp(0.0, double.infinity);
  }

  // レーザービームの終点を求める
  void _notifyCharacterPosition() {
    final callback = widget.onCharacterPosition;
    final context = _contentKey.currentContext;
    if (callback == null || context == null || !mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox containerBox = _contentKey.currentContext!.findRenderObject() as RenderBox;
        final containerPosition = containerBox.localToGlobal(Offset.zero);

        // 現在の文字列を取得
        final content = List<String>.from(widget.omikuji['content']);
        final currentLineText = content[_currentLine];
        final lineTextUpToCurrent = currentLineText.substring(0, _currentChar);
        final currentChar = _currentChar > 0 ? currentLineText[_currentChar - 1] : '';

        // 行の高さを計算
        final lineHeight = (_textStyle.fontSize ?? 20) * (_textStyle.height ?? 1.0);

        // パディング計算
        final verticalPadding = _calculateVerticalPadding(content, _textStyle);

        // これまでの文字列の幅を計算
        final textPainter = TextPainter(
          text: TextSpan(
            text: lineTextUpToCurrent.substring(0, lineTextUpToCurrent.length - 1),
            style: _textStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        // テキストの位置計算
        final currentCharPainter = TextPainter(
          text: TextSpan(
            text: currentChar,
            style: _textStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        currentCharPainter.layout();

        // 文字の中心位置を計算
        final charPosition = Offset(
          containerPosition.dx + textPainter.width + (currentCharPainter.width / 2),  // X座標：これまでの文字幅 + 現在の文字の中心
          containerPosition.dy + verticalPadding +
              (_currentLine * lineHeight) +  // 行数 × 行の高さ
              lineHeight / 2 -  // 行の高さの半分（文字の縦中心）
              _scrollController.offset,  // スクロール位置を引く
        );

        callback(charPosition);
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

    _textStyle = TextStyle(
      fontSize: baseFontSize,
      color: Colors.white,
      height: 1 + gk,
    );

    // 同じメソッドを使用してパディングを計算
    verticalPadding = _calculateVerticalPadding(content, _textStyle);

    print('Available width: $availableWidth');
    print('Available height: $availableHeight');
    print('Available height: $availableHeight');
    print('Max length: $maxLength');
    print('Font size: $baseFontSize');
    print('Total lines: $totalLines');
    print('Vertical padding: $verticalPadding');
    print('hPadTop: $hPadTop');

    return Container(
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
    );
  }
}
