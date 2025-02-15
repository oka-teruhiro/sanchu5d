import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OmikujiContentWidget extends StatefulWidget {
  final Map<String, dynamic> omikuji;
  final double contentHeight;
  final double contentWidth;
  final bool canStartAnimation; // アニメーション開始制御用のフラグを追加
  final VoidCallback? onCharacterDisplay;
  final VoidCallback? onLineComplete;

  const OmikujiContentWidget({
    Key? key,
    required this.omikuji,
    required this.contentHeight,
    required this.contentWidth,
    required this.canStartAnimation, // 新しいプロパティ
    this.onCharacterDisplay,
    this.onLineComplete,
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

  //final content = List<String>.from(widgetFactory.omikuji['content']);

  /*@override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }*/

  @override
  void didUpdateWidget(OmikujiContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // canStartAnimationがtrueになった時点でアニメーションを開始
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
          // 追加
          widget.onLineComplete!();
        } // 追加
      });

      await Future.delayed(const Duration(milliseconds: 500)); // 改行時間
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), // 改行移動時間
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

  @override
  Widget build(BuildContext context) {
    final content = List<String>.from(widget.omikuji['content']);

    // 水平方向のパディングと行間係数を変数化
    final double gk = 1.0; // 行間係数（要調整）：フォントサイズの何倍にするか
    final double webk;
    if (kIsWeb) {
      webk = 20; // web用　有効幅をこの数引いて計算する
    } else {
      webk = 0; // Android用
    }

    // 利用可能な幅と高さを計算
    //final availableWidth = screenSize.width - (70 + lk * 2);
    final availableWidth = widget.contentWidth - webk;
    final availableHeight = widget.contentHeight - 380; // 上下のパディングを考慮
    //final availableHeight = widget.contentHeight; // 上下のパディングを考慮

    // 最大文字数を取得
    final maxLength = content.fold<int>(
      0,
      (maxLen, line) => line.length > maxLen ? line.length : maxLen,
    );
    //print('availableWidth:$availableWidth');
    //print('maxLength:$maxLength');
    // フォントサイズを計算
    final calculatedFontSize = (availableWidth / maxLength) * 1.0; // 係数を1.0に調整
    final baseFontSize = calculatedFontSize.clamp(13.0, 60.0);
    //print('fontSize:$baseFontSize・$calculatedFontSize');

    // 1行の高さを計算（フォントサイズ + 行間）
    final lineHeight = baseFontSize * (1 + gk);

    // 最大表示可能行数を計算
    final maxVisibleLines = (availableHeight / lineHeight).floor();

    // 全行数
    final totalLines = content.length;

    // 上下の余白を計算
    final double verticalPadding = totalLines <= maxVisibleLines
        ? (availableHeight - (totalLines * lineHeight)) / 2 // 中央寄せの場合の余白
        : 0; // スクロールが必要な場合は余白なし

    /*// デバッグ出力
    print('Screen width: ${screenSize.width}');
    print('Available width: $availableWidth');
    print('Available height: $availableHeight');
    print('Available height: $availableHeight');
    print('Max length: $maxLength');
    print('Font size: $baseFontSize');
    print('Line height: $lineHeight');
    print('Max visible lines: $maxVisibleLines');
    print('Total lines: $totalLines');
    print('Vertical padding: $verticalPadding');*/

    return LayoutBuilder(
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
            child: Stack(
              // Stackを使用して左余白を固定
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 0, right: 0, top: verticalPadding),
                  child: Container(
                    color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._displayedContent.map((text) {
                          if (text.isEmpty) {
                            return SizedBox(height: lineHeight);
                          }
                          return Text(
                            text,
                            style: TextStyle(
                              fontSize: baseFontSize,
                              color: Colors.white,
                              height: 1 + gk,
                            ),
                            textAlign: TextAlign.left,
                          );
                        }),
                        if (_currentLine < content.length)
                          Container(
                            alignment: Alignment.centerLeft, // 左揃えを強制
                            child: Text(
                              _currentText,
                              style: TextStyle(
                                fontSize: baseFontSize,
                                color: Colors.white,
                                height: 1 + gk,
                              ),
                              //textAlign: TextAlign.left,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: verticalPadding),
              ],
            ),
          ),
        );
      },
    );
  }
}
