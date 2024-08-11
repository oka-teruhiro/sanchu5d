import 'package:flutter/material.dart';

class Update4c extends StatelessWidget {
  const Update4c({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> zu = [
      'assets/images/0.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
      'assets/images/0.jpg',
    ];
    List<double> takasaZu = [
      0,
      0,
      0,
      0,
      0,
    ];
    List<String> moji = [
      '概要',
      '　鑑定範囲を1921〜2029年から1901〜2199年に拡大しました。',
      '詳細',
      '　節入り日時をアプリ内部に保存しているので、ネット環境がなくとも命式やチャートを計算することができます。',
      '　実践鑑定の練習をする際に、すでに他界している有名人もみられるようになりました。',
    ];
    List<int> iroMoji = [
      -1407770,
      -1,
      -1407770,
      -1,
      -1,
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '第4.3版（ver.4.3.0)',
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
