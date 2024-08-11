import 'package:flutter/material.dart';

class Update5b extends StatelessWidget {
  const Update5b({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> zu = [
      'assets/images/0.jpg',
      'assets/images/main/取説5a.jpg',
      'assets/images/main/取説5d.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
    ];
    List<double> takasaZu = [
      0,
      370,
      370,
      0,
      0,
      0,
      0,
    ];
    List<String> moji = [
      '概要',
      '',
      '詳細',
      '　動画をwebへ移動し、アプリ容量が減少しました。'
          '動画の解説をみるためには、インターネットの接続が必要です。',
      '',
    ];
    List<int> iroMoji = [
      -1407770,
      -1,
      -1407770,
      -1,
      -1,
      -1,
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '第5.1版（ver5.1.9)',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            //height: 400,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: takasaZu[index],
                      child: ListTile(
                        //tileColor: Colors.indigo,
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Image.asset(zu[index]),
                        ),
                        tileColor: Colors.black,
                      ),
                    ),
                    ListTile(
                      tileColor: Colors.black,
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          moji[index],
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            color: Color(iroMoji[index]),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 90,
              height: 36,
              child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
