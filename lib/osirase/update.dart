import 'package:flutter/material.dart';

//import '../osirase/profile.dart';
import '../osirase/update1.dart';
import '../osirase/update2.dart';
import '../osirase/update2a.dart';
import '../osirase/update3.dart';
import '../osirase/update3a.dart';
import '../osirase/update4.dart';
import '../osirase/update4a.dart';
import '../osirase/update4b.dart';
import '../osirase/update4c.dart';
import '../osirase/update4d.dart';
import '../osirase/update4e.dart';
import '../osirase/update5a.dart';
//import '../osirase/update5b.dart';

class Update extends StatelessWidget {
  const Update({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'アップデート情報',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const Divider(
                  color: Colors.blue,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('第6.1版　次の機能追加の準備として、UIを全面的に整理しました。'
                        '（2024.7.27更新）'),
                    /*trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update5b(),
                          ));
                    },*/
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('第5.1版　動画をwebへ移動し、アプリ容量が減少しました。'
                        '（2024.7.17更新）'),
                    /*trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update5b(),
                          ));
                    },*/
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第5.0版　動画で解説を加え、使いやすくしました。'
                        '（2024.2.1更新）'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update5a(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第4.5版　通変星の解説(総論)を追加しました。'
                        '（2023.11.30更新）'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4e(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第4.4版　今日の運勢ページで明日をはじめとして過去・未来の運勢を'
                        '確認できるようになりました。（2023.9.2更新）'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4d(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                        '第4.3版　1901.1.1〜2199.12.31に対応できるようにしました。（2023/6/22 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4c(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第4.2版　命式チャートページを追加しました。（2023/6/16 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4b(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                        '第4.1版　天運の年ページに節入り時刻前ボタンを追加しました。（2023/5/10 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4a(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第4版　命式を表示できるようになりました。（2023/4/26 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update4(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第3.1版　コンセプト変更によるデザインの変更。（2022/4/18 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update3a(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                        '第3版　今日の運勢がわかるようになりました。「易占検定」を追加しました。（2021/8/8 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update3(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第2.1版　軽微な修正（2021/4/18 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update2a(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('第2版　天運の年がわかるようになりました。（2021/3/31 更新)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update2(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                        '第1版　生年月日を入力し、日干を算出し、おおよその性格を表示します。(2021/2/22 公開)'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Update1(),
                          ));
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text('プロフィール'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ));
                    },
                  ),
                ),*/
                ElevatedButton(
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
                const ListTile(
                  title: Text(''),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
