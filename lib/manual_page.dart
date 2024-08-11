import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'このアプリの使い方',
          style: TextStyle(
            fontSize: 20,
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(

        children: [
          const Divider(
            color: Colors.blue,
          ),
          ListTile(

            title: SizedBox(
              height: 250,
                child: Image.asset('assets/images/main/占い師天運.jpg'),
            ), // 52
          ),
          const ListTile(
            title: Text('　アプリの容量を減らすため、説明動画を YouTube に移動しました。'
                '下記のQRコードをスキャンすると動画のURLに入れます。'),
          ),
          ListTile(
            title: SizedBox(
              height: 150,
                child: Image.asset('assets/images/main/QR_v6_manual.png'),
            ), // 52
          ),
          const Divider(
            color: Colors.blue,
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text(
                '戻る',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
