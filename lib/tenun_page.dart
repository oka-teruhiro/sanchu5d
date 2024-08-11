import 'package:flutter/material.dart';
import 'kansuu.dart';

class TenunPage extends StatefulWidget {
  final int seinen; //生年
  final int seigatu; //生月
  final int seiniti; //生日
  const TenunPage({
    super.key,
    required this.seinen,
    required this.seigatu,
    required this.seiniti,
  });

  @override
  State<TenunPage> createState() => _TenunPageState();
}

class _TenunPageState extends State<TenunPage> {
  //■■　変数初期設定　■■
  int seinenInt = 1900;  // 6.1.12
  int seigatuInt = 1;    // 6.1.12
  int seinitiInt = 1;    // 6.1.12
  String x ='';          //6.1.12
  int nikkan = -1;
  String jukkan = "甲乙丙丁戊己庚辛壬癸"; //十干リスト
  String jukkanYomi = "甲【きのえ】　乙【きのと】　丙【ひのえ】　丁【ひのと】　戊【つちのえ】"
      "己【つちのと】庚【かのえ】　辛【かのと】　壬【みずのえ】癸【みずのと】"; //十干リスト【よみ】
  String juunisi = "子丑寅卯辰巳午未申酉戌亥"; //十二支リスト
  String rokujukkansi = "甲子乙丑丙寅丁卯戊辰己巳庚午辛未壬申癸酉"
      "甲戌乙亥丙子丁丑戊寅己卯庚辰辛巳壬午癸未"
      "甲申乙酉丙戌丁亥戊子己丑庚寅辛卯壬辰癸巳"
      "甲午乙未丙申丁酉戊戌己亥庚子辛丑壬寅癸卯"
      "甲辰乙巳丙午丁未戊申己酉庚戌辛亥壬子癸丑"
      "甲寅乙卯丙辰丁巳戊午己未庚申辛酉壬戌癸亥"; //
  int seinen = 1920;
  int seigatu = 1;
  int seiniti = 1;
  int setuirinen = 1920;
  int setuirigatu = 1;
  int setuiriniti = 1;
  int setuiriji = 0;
  int setuirihun = 0;
  int setuirinitisuu = 0;
  String nenchu = '甲子';
  String gechu = '甲子';
  String nichu = '甲子';
  int nichuNo = 0;
  List<int> tenun = [0, 0, 0, 0, 0, 0, 0];
  List<int> tenunNen = [1900, 1901, 1902, 1903, 1904, 1905, 1906];
  List<int> tenunNenrei = [0, 0, 0, 0, 0, 0, 0];
  List<int> tenunMei = [1, 1, 1, 1, 1, 1, 1];
  List<String> tenunMeiMoji = [
    '干支併臨',
    '干支併臨',
    '干支併臨',
    '干支併臨',
    '干支併臨',
    '干支併臨',
    '干支併臨'
  ];
  List<String> tenunKansi = ['甲子', '甲子', '甲子', '甲子', '甲子', '甲子', '甲子'];
  List<String> tenunText = ['1', '2', '3', '4', '5', '6', '7'];
  String seinenMoji = '1900';
  String seigatuMoji = '01';
  String seinitiMoji = '01';
  String seinengappiMoji = '1900-01-01';
  String jukkanNameYomi = 'きのえ';
  String nikkanMoji = "甲";
  String nissiMoji = '子';
  String tokugouTenMoji = '甲';
  String tokugouTiMoji = '子';
  String tentiTokugouMoji = '甲子';
  int nissi = -1;

  // statefullWidget に変更するため追加
  int _counter = 0;
  double setuiriButtonWidth = 0;
  int zenGo = 2; //0:節入り時刻後　1:節入り時刻前 2:節入り日以外
  List<int> iroBotan = [-14575885, -12627531, -14575885];
  List<int> iroTitle = [-5767189, -1294214, -5767189];
  List<String> botanMoji = ['節入り時刻前', '節入り時刻後', '節入り時刻前'];
  List<int> nenchuNo = [1, 0, 1];
  List<int> gechuNo = [1, 0, 1];
  int nenchuNoH = 0;
  int gechuNoH = 0;
  String nenchuS = '甲子';
  String gechuS = '甲子';

  void _incrementCounter() {
    setState(() {
      _counter++;
      zenGo = _counter % 2;
    });
  }
  // statefullWidget に追加するために追加　ここまで

  @override
  Widget build(BuildContext context) {
    //生年月日をwidgetで使えるようにする
    seinenInt = widget.seinen;
    seigatuInt = widget.seigatu;
    seinitiInt = widget.seiniti;


    //■■画面生成のための各種データを生成する■■
    //　受けっとった　生年月日をタイトル型から文字列に変換する
    seinenMoji = seinenInt.toString().padLeft(4,'0'); //6.1.12
    seigatuMoji = seigatuInt.toString().padLeft(2,'0'); //6.1.12
    seinitiMoji = seinitiInt.toString().padLeft(2,'0'); //6.1.12
    seinengappiMoji = '$seinenMoji-$seigatuMoji-$seinitiMoji'; //6.1.12

    // 新しい関数の試験をする
    seinen = int.parse(seinenMoji); // 生年 //6.1.12
    seigatu = int.parse(seigatuMoji); // 生月 //6.1.12
    seiniti = int.parse(seinitiMoji); // 生日 //6.1.12
    // 関数meisikiAで、命式・節入り年月日時分・節入り日からの日数を算出する
    x = meisikiA(seinenInt, seigatuInt, seinitiInt);  //6.1.12
    // 出力から必要データを取り出す
    nikkanMoji = x.substring(4, 5); // 日干の文字
    nissiMoji = x.substring(5, 6); // 日支の文字
    nikkan = juKanNo(nikkanMoji); // 日干No.
    nissi = juuniSiNo(nissiMoji); // 日支No.
    setuirinitisuu = int.parse(x.substring(19, 21)); // 節入り日からの日数
    nenchu = x.substring(0, 2); // 年柱の文字
    gechu = x.substring(2, 4); //  月柱の文字
    nichu = x.substring(4, 6); //  日柱の文字
    setuirinen = int.parse(x.substring(6, 10)); //   節入り年の数字
    setuirigatu = int.parse(x.substring(10, 12)); // 節入り月の数字
    setuiriniti = int.parse(x.substring(12, 14)); // 節入り日の数字
    setuiriji = int.parse(x.substring(14, 16)); //   節入り時の文字
    setuirihun = int.parse(x.substring(17, 19)); //  節入り分の文字
    nenchuNoH = rokujuKansiNoA(nenchu); // 年柱No.
    gechuNoH = rokujuKansiNoA(gechu); // 月柱No.
    nichuNo = rokujuKansiNoA(nichu); // 月柱No.

    // 十干の読み仮名を算出する
    jukkanNameYomi =
        jukkanYomi.substring(nikkan * 7, (nikkan + 1) * 7).trimRight();

    // statefullWidget に変更するために　追加
    // 節入り日の時節入り時刻前ボタンを表示する
    if (setuirinitisuu == 1) {
      setuiriButtonWidth = 90;
    } else {
      setuiriButtonWidth = 0;
    }

    nenchuNo[0] = nenchuNoH;
    if (seigatu == 2) {
      nenchuNo[1] = (nenchuNo[0] - 1) % 60;
    } else {
      nenchuNo[1] = nenchuNo[0];
    }
    nenchuNo[2] = nenchuNo[0];

    gechuNo[0] = gechuNoH;
    gechuNo[1] = (gechuNo[0] - 1) % 60;
    gechuNo[2] = gechuNo[0];

    //月柱の六十干支を算出する
    gechu =
        rokujukkansi.substring((gechuNo[zenGo] * 2), (gechuNo[zenGo] * 2) + 2);
    gechuS = rokujukkansi.substring((gechuNo[2] * 2), (gechuNo[2] * 2) + 2);
    //年柱の六十干支を算出する
    nenchu = rokujukkansi.substring(
        (nenchuNo[zenGo] * 2), (nenchuNo[zenGo] * 2) + 2);
    nenchuS = rokujukkansi.substring((nenchuNo[2] * 2), (nenchuNo[2] * 2) + 2);
    // 干支併臨(日)を算出する
    var nitiKansiHeirin = kansiHeirin(nichuNo, seinengappiMoji);
    var getuKansiHeirin = kansiHeirin(gechuNo[zenGo], seinengappiMoji);
    // 干支併臨(年)を算出する
    var nenKansiHeirin = kansiHeirin(nenchuNo[zenGo], seinengappiMoji);
    // statefullWidget に変更するために追加　ここまで

    // 天地徳合を算出する
    var tokugouTen = (nikkan + 5) % 10;
    var tokugouTi = (13 - nissi) % 12;
    tokugouTenMoji = jukkan.substring(tokugouTen, tokugouTen + 1);
    tokugouTiMoji = juunisi.substring(tokugouTi, tokugouTi + 1);
    tentiTokugouMoji = '$tokugouTenMoji$tokugouTiMoji';
    int tentiTokugouSuu = rokujuKansiNoA(tentiTokugouMoji);
    var tentiTokugou = kansiHeirin(tentiTokugouSuu, seinengappiMoji);
    // 干支併臨リスト・天地徳合リストから年と年齢を生成する
    List tenunList = tenUn(nenKansiHeirin, getuKansiHeirin, nitiKansiHeirin,
        tentiTokugou, seinengappiMoji);
    // 天運リストの要素数を7にするため0を追加する
    int tenunLength = tenunList.length;
    for (int i = 0; i < (7 - tenunLength); ++i) {
      tenunList.add(0);
    }
    // 天運リストの１番目のテキスト文を作成する
    for (int i = 0; i < 7; ++i) {
      tenun[i] = tenunList.removeAt(0);
      tenunNen[i] = tenun[i] ~/ 10000;
      tenunNenrei[i] = tenun[i] % 10000 ~/ 10;
      tenunMei[i] = tenun[i] % 10;
      if (tenunMei[i] == 1) {
        tenunMeiMoji[i] = '干支併臨';
        tenunKansi[i] = nenchu;
      } else if (tenunMei[i] == 2) {
        tenunMeiMoji[i] = '干支併臨';
        tenunKansi[i] = gechu;
      } else if (tenunMei[i] == 3) {
        tenunMeiMoji[i] = '干支併臨';
        tenunKansi[i] = nichu;
      } else if (tenunMei[i] == 4) {
        tenunMeiMoji[i] = '天地徳合';
        tenunKansi[i] = tentiTokugouMoji;
      } else {}

      tenunText[i] =
          '${tenunNen[i]}（${tenunKansi[i]}）年（${tenunNenrei[i]}歳）：${tenunMeiMoji[i]}';
    }

    List<String> meisikiTitle = ['節入り時刻後の天運の年', '節入り時刻前の天運の年', '$seinenInt.$seigatuInt.$seinitiInt 生　の天運の年'];

    List<String> zu = [
      'assets/images/0.jpg', //1
      'assets/images/tentitokugou/anehaturu1.jpg', //2
      'assets/images/tentitokugou/anehaturu.jpg', //3
      'assets/images/0.jpg', //4
      'assets/images/tentitokugou/天運の期間.jpg', //5
      'assets/images/0.jpg', //6
      'assets/images/tentitokugou/anehaturu2.jpg', //7
      'assets/images/0.jpg', //8
      'assets/images/0.jpg', //9
      'assets/images/0.jpg', //10
      'assets/images/0.jpg', //11
      'assets/images/0.jpg', //12
    ];
    List<double> takasaZu = [
      0, //1
      200, //2
      180, //3
      0, //4
      160, //5
      0, //6
      200, //7
      0, //8
      0, //9
      0, //10
      0, //11
      0, //12
    ];
    List<String> moji = [
      '　天運の年とは、人生における天の上昇気流(天の風)が吹き、大飛躍を遂げることが出来る大切な年を示します。', //1
      '　天の上昇気流はよく、アネハ鶴がヒマラヤ山脈を越えていく様子に例えられます。'
          '繁殖を終えたアネハ鶴は、越冬のためにシベリアやチベットからインドへと渡る際、'
          '8,000メートル級の山々が連なるヒマラヤ山脈を越えていかなければなりません。'
          '鶴自身の力だけではとても不可能ですが、渓谷に発生する台風並の強い上昇気流を'
          '巧みに利用して越えていきます。', //2
      '　同じように、人の努力だけでは越えられない壁も、この時吹く天の上昇気流に'
          'うまく乗ることによって、大きな飛躍を遂げることができるのです。', //3
      '　天運の年は、天地徳合（てんちとくごう）の年と、干支併臨（かんしへいりん）の年で構成されます。'
          '天地徳合は60年に一度、干支併臨は60年に三度存在し、この年と前後1年、'
          '合わせた3年間がその期間になります。', //4
      '　ところで易学の世界では、立春'
          '（年の節入日：おおよそ2月4日）を一年の始まり、節分（立春の一日前の日）を'
          '一年の終わりとみます。例えば天地徳合が2022年ならば、'
          '2021年立春～2023年節分（2021/2/3～2024/2/3)が天運の期間となります。', //5
      '　天の上昇気流が吹くからといって、自分の努力が不要になる訳ではありません。'
          '準備なく飛び込んだ鶴は風の強さにたじろぎ、上昇気流に飛び込めず、'
          'ケガをしてしまうこともあります。しかし、体力を蓄え再び挑戦し、'
          '強い上昇気流の中をさらに羽ばたいて高度を上げていくのです。', //6
      '　同様に、天運期間を迎えるにあたって、自身の準備を怠らないことが大切です。'
          '天運期間には、自分の努力ではなんともし難い、環境の大きな変化が予想されます。'
          'そこで躊躇することなく、チャンスととらえ、今までの苦労はこの時のためにあった'
          'ぐらいの気持ちで果敢にチャレンジしましょう。'
          'どこに天が準備した贈り物があるかわかりません。'
          '身の回りの小さな変化も見逃さず、ここに天の意向があるかもしれないと思って'
          '関心を持ちましょう。', //7
      '　なお、表示されている年齢は、天地徳合/干支併臨の立春日の満年齢を示しています。', //8
      '　あなたが、大飛躍を遂げることを、心からお祈りいたします。', //9
      '', //10
      '', //11
      '', //12
    ];

    //-1407770 薄いピンク[300]
    //-1294214 ピンク[400]
    //-1407770 ピンク[500]
    // -4056997 暗いピンク[700]

    List<int> iroMoji = [
      -1, //1
      -1, //2
      -1, //3
      -1, //4
      -1, //5
      -1, //6
      -1, //7
      -1, //8
      -1, //9
      -1, //10
      -1, //11
      -1, //12
    ];

    //■■　画面を生成する　■■

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.1)),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            meisikiTitle[zenGo],
            style: TextStyle(
              color: Color(iroTitle[zenGo]),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: setuiriButtonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(iroBotan[zenGo]),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: () {
                    _incrementCounter();
                  },
                  child: Text(
                    botanMoji[zenGo],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          tenunText[0],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[1],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[2],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[3],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[4],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[5],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tenunText[6],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const Divider(
                color: Colors.blue,
              ),
              Expanded(
                //height: 400,
                child: ListView.builder(
                  itemCount: 11,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: takasaZu[index],
                          child: ListTile(
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
              const Divider(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
