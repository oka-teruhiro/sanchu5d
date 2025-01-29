import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  late Animation<double> _slideAnimation; // スライドアップ用
  late Animation<double> _fadeAnimation; // フェードイン用


  @override
  void initState() {
    super.initState();

    // コントローラーの設定
    _controller = AnimationController(
      duration: const Duration(seconds: 2),// アニメーションの長さ
      vsync: this,
    );

    // スライドアップアニメーション(0-1秒)
    _slideAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // フェードインアニメーション(1-2秒)
    _fadeAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    /*
    // アニメーションの設定
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // アニメーションの動き方
        //curve: Curves.elasticIn, // アニメーションの動き方
    );
    */

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
    double h2 = h0 * 0.1;


    return SizeTransition( // サイズ変更アニメーション
      sizeFactor: _slideAnimation,
      axis: Axis.vertical,
      child: SizedBox(
        width: w0,
        height: h1,
        child: Container(
          color: Colors.blueGrey,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SvgPicture.string(
              '''
      <svg width= w0 height= h1 viewBox="0 0 $w0 $h1">
                  
                  <path
            d="M 10 100
              L 10 50
              L 30 50
              L 30 10
              L 40 10
              L 40 20
              L 10 20
              L 10 10
              L 20 10
              L 20 40
              L 10 40
              L 10 30
              L 50 30
              L 50 10
              L ${w0-50} 10
              L ${w0-50} 30
              L ${w0-10} 30
              L ${w0-10} 40
              L ${w0-20} 40
              L ${w0-20} 10
              L ${w0-10} 10
              L ${w0-10} 20
              L ${w0-40} 20
              L ${w0-40} 10
              L ${w0-30} 10
              L ${w0-30} 50
              L ${w0-10} 50
              L ${w0-10} ${h1-50-h2}
              L ${w0-30} ${h1-50-h2}
              L ${w0-30} ${h1-10-h2}
              L ${w0-40} ${h1-10-h2}
              L ${w0-40} ${h1-20-h2}
              L ${w0-10} ${h1-20-h2}
              L ${w0-10} ${h1-10-h2}
              L ${w0-20} ${h1-10-h2}
              L ${w0-20} ${h1-40-h2}
              L ${w0-10} ${h1-40-h2}
              L ${w0-10} ${h1-30-h2}
              L ${w0-50} ${h1-30-h2}
              L ${w0-50} ${h1-10-h2}
              L ${50} ${h1-10-h2}
              L ${50} ${h1-30-h2}
              L ${10} ${h1-30-h2}
              L ${10} ${h1-40-h2}
              L ${20} ${h1-40-h2}
              L ${20} ${h1-10-h2}
              L ${10} ${h1-10-h2}
              L ${10} ${h1-20-h2}
              L ${40} ${h1-20-h2}
              L ${40} ${h1-10-h2}
              L ${30} ${h1-10-h2}
              L ${30} ${h1-50-h2}
              L ${10} ${h1-50-h2}
              L 10 100"
            stroke="#64FFDA"
            stroke-width="2"
            
            fill="none"
                    />
                
                </svg>
                ''',
              width: w0,
              height: h1,
            ),
          ),
        ),
      ),
    );
  }
}
