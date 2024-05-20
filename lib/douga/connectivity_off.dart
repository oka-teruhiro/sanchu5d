import 'package:flutter/material.dart';

class ConnectivityOff extends StatelessWidget {
  const ConnectivityOff({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("not connection"),
      content: SizedBox(
        width: 200,
        height: 160,
        child: Text("インターネットに接続されていません。"
            "インターネットに接続してから、アプリのスタート画面に戻り、"
            "再度「このアプリの使い方を見る」ボダンをタップして下さい。"),
      ),
    );
  }
}