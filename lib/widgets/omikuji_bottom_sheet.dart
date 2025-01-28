import 'package:flutter/material.dart';

// 画面下からおみくじの結果が出てくる
class OmikujiBottomSheet extends StatefulWidget {
  const OmikujiBottomSheet({Key? key}) : super(key: key);

  @override
  State<OmikujiBottomSheet> createState() => _OmikujiBottomSheetState();
}

class _OmikujiBottomSheetState extends State<OmikujiBottomSheet>
  with SingleTickerProviderStateMixin {  // アニメーションに必要なミックスイン

  late AnimationController _controller; // アニメーションのコントローラー
  late Animation<double> _animation; // アニメーションの値

  @override
  void initState() {
    super.initState();

    // コントローラーの設定
    _controller = AnimationController(
      duration: const Duration(seconds: 2),// アニメーションの長さ
      vsync: this,
    );

    // アニメーションの設定
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // アニメーションの動き方
        //curve: Curves.elasticIn, // アニメーションの動き方
    );

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
    double h1 = h0 * 0.9;

    return FadeTransition( // フェードインさせる
      opacity: _animation,
      child: SizeTransition( // サイズ変更アニメーション
        sizeFactor: _animation,
        axis: Axis.vertical,
        child: SizedBox(
          width: w0,
          height: h1,
          child: Container(
            color: Colors.blueGrey,
            child: Text('おみくじ'),
          ),
        ),
      ),
    );
  }
}
