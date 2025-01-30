import 'package:flutter/material.dart';

class OmikujiContentWidget extends StatefulWidget {
  final Map<String, dynamic> omikuji;
  final double contentHeight;

  const OmikujiContentWidget({
    Key? key,
    required this.omikuji,
    required this.contentHeight,
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

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 1000), () {
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
      });

      await Future.delayed(const Duration(milliseconds: 100));
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      await Future.delayed(const Duration(milliseconds: 400));
      _animateText();
      return;
    }

    setState(() {
      _currentText = content[_currentLine].substring(0, _currentChar + 1);
      _currentChar++;
    });

    await Future.delayed(const Duration(milliseconds: 50));
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }

    await Future.delayed(const Duration(milliseconds: 50));
    _animateText();
  }

  @override
  Widget build(BuildContext context) {
    final content = List<String>.from(widget.omikuji['content']);
    final screenSize = MediaQuery.of(context).size;

    // 水平方向のパディングを変数化
    final double hs = 5.0;  // この値を変更して調整

    // パディングを含めた実際の利用可能幅を計算
    final availableWidth = screenSize.width - (80 + (hs * 2));

    //final containerWidth = screenSize.width * 0.8; // 飾り枠内なので90%から80%に調整
    final maxLength = content.fold<int>(
      0,
      (maxLen, line) => line.length > maxLen ? line.length : maxLen,
    );

    // デバッグ用の出力
    print('Screen width: ${screenSize.width}');
    print('Available width: $availableWidth');
    print('Max length: $maxLength');
    print('Horizontal spacing: $hs');

    final calculatedFontSize = (availableWidth / maxLength) * 0.93; // 係数を1.0に調整
    final baseFontSize = calculatedFontSize.clamp(14.0, 42.0);

    // フォントサイズのデバッグ出力
    print('Calculated font size: $calculatedFontSize');
    print('Base font size: $baseFontSize');

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalLines = content.length;

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
              padding: EdgeInsets.symmetric(horizontal: hs), // 両端のスペース
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
                mainAxisAlignment: totalLines < 10
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  ..._displayedContent.map((text) {
                    if (text.isEmpty) {
                      return SizedBox(height: baseFontSize * 1.5);
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: baseFontSize * 0.4,
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: baseFontSize,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    );
                  }),
                  if (_currentLine < content.length)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: baseFontSize * 0.4,
                      ),
                      child: Text(
                        _currentText,
                        style: TextStyle(
                          fontSize: baseFontSize,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
