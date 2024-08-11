import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'プロフィール',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Image.asset('assets/images/main/taxi.png'),
          ),
          const ListTile(
            title: Text(
              '　私は東京のタクシー運転手です。63歳です。'
              '2016年にタクシー運転手になりました。'
              '2020年4月コロナ禍で失業し、7月再就職しました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　タクシー運転手をしてみると、こんなアプリがあったらいいなと思うことが多々'
              'ありました。失業中、ネットでスマホのアプリを初心者でも作れることを知'
              'り、スマホアプリに挑戦してみました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　主にYouTubeの「KBOYのFlutter大学の基礎」を何度も繰り返し見ながら、'
              'わからないところはQiitaで調べながら、例題をこなすなかで、ふと浮か'
              'んだのが、「占い」アプリです。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　私は、2011年に公益社団法人日本易学連合会の藤懸庚汪先生から'
              '四柱推命を学んだ経験があります。人間関係で悩んでいる方々の相談にのっ'
              'てあげたこともありました。まず、自分を知って、相手を知ることによって、ど'
              'のように関わっていったらいいかのアドバスをしました。自分の心の持ち方が'
              '変わることで解決した方も多くいました。みるべきところは色々ありますが、'
              '今回は、日干（にっかん）に絞って表示するようにしました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　日干は、甲・乙・丙・丁・戊・己・庚・辛・壬・癸　の順に10日間で巡って'
              'きます。西暦1900年1月1日は「甲」なので、1900年1月1日から生年月日までの'
              '日数を出し、１０で割った余りを算出します。余りが０なら甲、余りが１なら乙、'
              '・・・、余りが９なら癸になります。余りの数字に従って画面遷移させています。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　6/22、環境構築から始まって、①画面に文字や画像を配置し、②ボタ'
              'ンを押したら画面遷移し、③生年月日を入れたら日干を計算し、画面遷移する。'
              'ところまでできたところで、7/14、新しいタクシー会社に入社しました。同期入'
              '社の方が、IT会社のSEを経験された方でした。その方から、「GooglePlayに上'
              'げたらいいですよ」とアドバイスを頂き、今回のリリースとなりました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　日干から見る大まかな性格がわかるだけでも、けっこう有効です'
              'が、どのような関係性があるかについてはまだ記述してないので、今後追加し'
              'てバージョンアップしていこうと思います。ズブの素人が初めて作成したもの'
              'です。温かい目で見ていただけるとありがたいです。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　また、タクシー運転手としてもまだまだ未熟です。未熟ゆえにこん'
              'な支援機能があったらいいなと思うことが沢山あります。今後もプログラムを'
              '学びながら実現していきたいと思っています。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　　(2021.2.22)',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const Divider(
            color: Colors.blue,
          ),
          ListTile(
            title: SizedBox(
              height: 120,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/main/hai1.jpg'),
                  Image.asset('assets/images/main/hai2.jpg'),
                ],
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　2022.5.1 咳をしたときに、スーパーボールのようなタンがでたあと、２回目の咳をしたら、'
                  '激しい胸の痛みで、息ができなくなりました。息は吐けるのですか、'
                  '少しでも吸おうとすると、痛みが増し、呼吸困難、身体がみるみる硬直していきました。'
                  '救命救急で搬送され、激痛が続く一晩を過ごしました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　翌日、肺感染症、膿胸と判明しました。今はすっかり回復しましたが、'
                  '誤嚥が原因のようなので、油断して急いで食べたりすると、いつ再発してもおかしくありません。'
                  'なので、あの時死んでたと思うと、今、天に生かされている間に、世の為、人の為に生きたい。'
                  'そして、確かに生きてこの世に存在したという証しを残したいと思うようになりました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　そんな動機から、僅かな広告費をもらって何になるのだろかと思い、アプリの広告を入れるためのスペースを撤去しました。'
                  'もちろんアプリは以前から無料です。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　私は、タクシードライバになる前、すでに2,000名以上鑑定していましたが、師匠からは、'
                  '「90分で1万円ぐらいとっても良いくらいだね」と言われていました。'
                  'しかし、私は、占い師ではありませんし、予言者でもありません。'
                  '人の人生に対してこうしなさいとはとても言えません。'
                  '学んだ内容を、コツコツと計算し、「計算では、こうなっています。」と伝えしかありませんでした。'
                  'しかしそれでも相談者は、自ら何かを悟り、'
                  '「スッキリしました」と喜んで帰って行くことを経験していました。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　ならば、計算結果を伝えるだけならば、アプリにして、計算結果をわかりやすく、伝える、'
                  'それで、多くの方の、救い、人助けになればと考えました。'
                  'そして、私に相談を持ち込んだ方の悩みは、'
                  '100%人間関係でした。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　そこで、ver.6では,以前から課題であった、人間関係を鑑定できるようにしていこうと思います。'
                  '今回その機能を折り込むために、UIを整理して、大改造を行いました。'
                  '今までどうり、ゲーム感覚で性格の占いっ子するのもいいですし、'
                  '今日の運勢を見て、今日は慎重に過ごそうとか、大胆に挑戦してみようとか参考にするのもいいです。'
                  '天運の年を前に、着々と準備をするのもいいです。'
                  'いろいろな場面で皆様のお役にたてば幸いです。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　なお、Firebaseというサーバーを借りています。できるだけサーバーを使わないようにしています。'
                  'サーバーを使わない分だけ、アプリ容量が増えます。'
                  '現在、サーバーの使用量が少ないので無料ですが、'
                  '今後、使用量が増えた場合は、有料にせざるを得ないことご了承下さい。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　皆様が、幸福な人生を過ごせるように、お祈りいたします。',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　　(2024.7.27)',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              '　',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          const ListTile(
            title: Text(''),
          ),
          ElevatedButton(
            child: const Text('戻る',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const ListTile(
            title: Text(''),
          ),
        ],
      ),
    );
  }
}
