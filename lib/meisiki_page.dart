import 'package:flutter/material.dart';
import '../kaisetu/kaisetu_page.dart';
import '../meisiki/meisiki_nitikan.dart';
//import '../tuuhenbosi/tuhen_kaisetu.dart';
import 'kansuu.dart';
import 'meisiki/meisiki_juuniun.dart';

class MeisikiPage extends StatefulWidget {
  final int seinen; //生年
  final int seigatu; //生月
  final int seiniti; //生日
  final int aiteInt; //相手
  const MeisikiPage({
    super.key,
    required this.seinen,
    required this.seigatu,
    required this.seiniti,
    required this.aiteInt,
  });

  @override
  State<MeisikiPage> createState() => _MeisikiPageState();
}

class _MeisikiPageState extends State<MeisikiPage> {
  String nenchuW = '甲子'; //6.1.10
  String gechuW = '甲子'; //6.1.10
  String nichuW = '甲子'; //6.1.10
  String setuirinenW = '甲子'; //6.1.10
  String setuirigatuW = '甲子'; //6.1.10
  String setuirinitiW = '甲子'; //6.1.10
  String setuirijiW = '17'; //6.1.10
  String setuirihunW = '30'; //6.1.10
  String setuirinitisuuW = '10'; //6.1.10
  int setuirinitisuu = 10; //6.1.10
  int _counter = 0;
  String nenchu = '甲子'; //widget内で使う年柱
  String gechu = '甲子'; //widget内で使う月柱
  String nichu = '甲子'; //widget内で使う日柱
  String nenchuH = '甲子'; //画面表示で使う年柱
  String gechuH = '甲子'; //画面表示で使う月柱
  String nichuH = '甲子'; //画面表示で使う日柱
  String nenkan = '甲';
  String nensi = '子';
  String gatukan = '甲';
  String gatusi = '子';
  String nitikan = '甲';
  String nitisi = '子';
  int nenKanNo = 0;
  int nenSiNo = 0;
  int gatuKanNo = 0;
  int gatuSiNo = 0;
  int nitiKanNo = 0;
  int nitiSiNo = 0;
  String zouKanNen = '甲';
  String zouKanTuki = '甲';
  String zouKanNiti = '甲';
  int zouKanNenNo = 0;
  int zouKanGatuNo = 0;
  int zouKanNitiNo = 0;
  String rokujukkansi = //60干支
      "甲子乙丑丙寅丁卯戊辰己巳庚午辛未壬申癸酉"
      "甲戌乙亥丙子丁丑戊寅己卯庚辰辛巳壬午癸未"
      "甲申乙酉丙戌丁亥戊子己丑庚寅辛卯壬辰癸巳"
      "甲午乙未丙申丁酉戊戌己亥庚子辛丑壬寅癸卯"
      "甲辰乙巳丙午丁未戊申己酉庚戌辛亥壬子癸丑"
      "甲寅乙卯丙辰丁巳戊午己未庚申辛酉壬戌癸亥"; //
  String tuuhenbosi = //通変星
      "比肩劫敗食神傷官偏財正財偏官正官倒食印綬" //甲
      "劫敗比肩傷官食神正財偏財正官偏官印綬倒食" //乙
      "倒食印綬比肩劫敗食神傷官偏財正財偏官正官" //丙
      "印綬倒食劫敗比肩傷官食神正財偏財正官偏官" //丁
      "偏官正官倒食印綬比肩劫敗食神傷官偏財正財" //戊
      "正官偏官印綬倒食劫敗比肩傷官食神正財偏財" //己
      "偏財正財偏官正官倒食印綬比肩劫敗食神傷官" //庚
      "正財偏財正官偏官印綬倒食劫敗比肩傷官食神" //辛
      "食神傷官偏財正財偏官正官倒食印綬比肩劫敗" //壬
      "傷官食神正財偏財正官偏官印綬倒食劫敗比肩"; //癸
  String tuuhenbosiNenKan = '比肩';
  String tuuhenbosiNenSi = '比肩';
  String tuuhenbosiGetuKan = '比肩';
  String tuuhenbosiGetuSi = '比肩';
  String tuuhenbosiNitiKan = '比肩';
  String tuuhenbosiNitiSi = '比肩';
  String juuniUn = //12運
      '沐冠建帝衰病死墓絶胎養長' //甲
      '病衰帝建冠沐長養胎絶墓死' //乙
      '胎養長沐冠建帝衰病死墓絶' //丙
      '絶墓死病衰帝建冠沐長養胎' //丁
      '胎養長沐冠建帝衰病死墓絶' //戊
      '絶墓死病衰帝建冠沐長養胎' //己
      '死墓絶胎養長沐冠建帝衰病' //庚
      '長養胎絶墓死病衰帝建冠沐' //辛
      '帝衰病死墓絶胎養長沐冠建' //壬
      '建冠沐長養胎絶墓死病衰帝'; //癸
  String juuniUnNiti = '胎';
  String juuniUnGetu = '胎';
  String juuniUnNen = '胎';
  double fs = 20; //フォントサイズ
  double hi = 45.0;
  double w1 = 74;
  double w2 = 60;
  String color1 = 'pinkAccent';
  double setuiriButtonWidth = 0;
  int iroPink = 0xFFEC407A;
  int iroWhite = 0xFFFFFFFF;
  int iroTeal = 0xFF80CBC4;
  int iroGreenAccent = 0xFF69F0AE;
  int iroSetuiri = -1;
  int seinenInt = 1900;
  int seigatuInt = 1;
  int seinitiInt = 1;
  int setuirinenInt = 1900;
  int setuirigatuInt = 1;
  int setuirinitiInt = 1;
  int setuirijiInt = 0;
  int setuirihunInt = 0;
  int setuirinitisuuInt = 2;
  int zenGo = 2; //0:節入り時刻後　1:節入り時刻前 2:節入り日以外
  List<int> iroBotan = [-14575885, -12627531, -14575885];
  List<int> iroTitle = [-5767189, -1294214, -5767189];
  List<String> botanMoji = ['節入り時刻前', '節入り時刻後', '節入り時刻前'];
  List<String> meisikiTitle = ['節入り時刻後の命式', '節入り時刻前の命式', 'あなたの命式は'];
  List<int> nenchuNo = [1, 0, 1];
  List<int> gechuNo = [1, 0, 1];
  List<int> nichuNo = [1, 0, 1];
  int aiteInt = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      zenGo = _counter % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    //生年月日をwidgetで使えるようにする
    seinenInt = widget.seinen;
    seigatuInt = widget.seigatu;
    seinitiInt = widget.seiniti;
    aiteInt = widget.aiteInt;

    nenchuW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(0, 2); //6.1.10
    gechuW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(2, 4); //6.1.10
    nichuW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(4, 6); //6.1.10
    setuirinenW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(6, 10); //6.1.10
    setuirigatuW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(10, 12); //6.1.10
    setuirinitiW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(12, 14); //6.1.10
    setuirijiW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(14, 16); //6.1.10
    setuirihunW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(17, 19); //6.1.10
    setuirinitisuuW =
        meisikiA(seinenInt, seigatuInt, seinitiInt).substring(19, 21); //6.1.10
    nenchu = nenchuW; // 6.1.10
    gechu = gechuW; // 6.1.10
    nichu = nichuW; // 6.1.10
    setuirinenInt = int.parse(setuirinenW); // 6.1.10
    setuirigatuInt = int.parse(setuirigatuW); // 6.1.10
    setuirinitiInt = int.parse(setuirinitiW); // 6.1.10
    setuirijiInt = int.parse(setuirijiW); // 6.1.10
    setuirihunInt = int.parse(setuirihunW); // 6.1.10
    setuirinitisuu = int.parse(setuirinitisuuW); // 6.1.10

    nenchuNo[0] = rokujuKansiNoA(nenchu);
    if (seigatuInt == 2) {
      nenchuNo[1] = (nenchuNo[0] - 1) % 60;
    } else {
      nenchuNo[1] = nenchuNo[0];
    }
    nenchuNo[2] = nenchuNo[0];

    gechuNo[0] = rokujuKansiNoA(gechu);
    gechuNo[1] = (gechuNo[0] - 1) % 60;
    gechuNo[2] = gechuNo[0];

    nichuNo[0] = rokujuKansiNoA(nichu);
    nichuNo[1] = nichuNo[0];
    nichuNo[2] = nichuNo[0];

    nenchuH =
        rokujukkansi.substring(nenchuNo[zenGo] * 2, (nenchuNo[zenGo]) * 2 + 2);
    gechuH =
        rokujukkansi.substring(gechuNo[zenGo] * 2, (gechuNo[zenGo]) * 2 + 2);
    nichuH =
        rokujukkansi.substring(nichuNo[zenGo] * 2, (nichuNo[zenGo]) * 2 + 2);

    //節入り日の時節入り時刻前ボタンを表示する
    if (setuirinitisuu == 1) {
      // 6.1.17
      setuiriButtonWidth = 80;
      iroSetuiri = iroPink;
    } else {
      setuiriButtonWidth = 0;
      iroSetuiri = iroTeal;
    }
    //年柱・月柱・日柱から年干・年支・月干・月支・日干・日支を作成する
    nenkan = nenchuH.substring(0, 1);
    nensi = nenchuH.substring(1, 2);
    gatukan = gechuH.substring(0, 1);
    gatusi = gechuH.substring(1, 2);
    nitikan = nichuH.substring(0, 1);
    nitisi = nichuH.substring(1, 2);
    //蔵干を算出する
    zouKanNen = zouKan(nensi, setuirinitisuuInt);
    zouKanTuki = zouKan(gatusi, setuirinitisuuInt);
    zouKanNiti = zouKan(nitisi, setuirinitisuuInt);
    //通変星を算出する
    nitiKanNo = juKanNo(nitikan);
    gatuKanNo = juKanNo(gatukan);
    nenKanNo = juKanNo(nenkan);
    zouKanNitiNo = juKanNo(zouKanNiti);
    zouKanGatuNo = juKanNo(zouKanTuki);
    zouKanNenNo = juKanNo(zouKanNen);
    tuuhenbosiGetuKan = tuuhenbosi.substring(
        nitiKanNo * 20 + gatuKanNo * 2, nitiKanNo * 20 + gatuKanNo * 2 + 2);
    tuuhenbosiNenKan = tuuhenbosi.substring(
        nitiKanNo * 20 + nenKanNo * 2, nitiKanNo * 20 + nenKanNo * 2 + 2);
    tuuhenbosiNitiSi = tuuhenbosi.substring(nitiKanNo * 20 + zouKanNitiNo * 2,
        nitiKanNo * 20 + zouKanNitiNo * 2 + 2);
    tuuhenbosiGetuSi = tuuhenbosi.substring(nitiKanNo * 20 + zouKanGatuNo * 2,
        nitiKanNo * 20 + zouKanGatuNo * 2 + 2);
    tuuhenbosiNenSi = tuuhenbosi.substring(
        nitiKanNo * 20 + zouKanNenNo * 2, nitiKanNo * 20 + zouKanNenNo * 2 + 2);
    //十二運を算出する
    nitiSiNo = juuniSiNo(nitisi);
    gatuSiNo = juuniSiNo(gatusi);
    nenSiNo = juuniSiNo(nensi);
    juuniUnNiti = juuniUn.substring(
        nitiKanNo * 12 + nitiSiNo, nitiKanNo * 12 + nitiSiNo + 1);
    juuniUnGetu = juuniUn.substring(
        nitiKanNo * 12 + gatuSiNo, nitiKanNo * 12 + gatuSiNo + 1);
    juuniUnNen = juuniUn.substring(
        nitiKanNo * 12 + nenSiNo, nitiKanNo * 12 + nenSiNo + 1);

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            meisikiTitle[zenGo],
            style: TextStyle(
              color: Color(iroTitle[zenGo]),
              fontWeight: FontWeight.bold,
              fontSize: 20, // 6.1.17
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
                    elevation: 0,
                    shadowColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _incrementCounter();
                  },
                  child: Text(
                    botanMoji[zenGo],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.black,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              children: [
                ListTile(
                  title: Container(
                    color: Colors.black,
                    child: SizedBox(
                      height: 668,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 44,
                          child: Center(
                            child: Column(
                              children: [
                                //■■■■■■■■■生年月日の行■■■■■■■■■
                                SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          //color: Colors.black45,
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '$seinitiInt',
                                                  style: TextStyle(
                                                    fontSize: fs,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                                Text(
                                                  '日',
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '$seigatuInt',
                                                  style: TextStyle(
                                                    fontSize: fs,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                                Text(
                                                  '月',
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '$seinenInt',
                                                  style: TextStyle(
                                                    fontSize: fs,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                                Text(
                                                  '年',
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '生年',
                                                  style: TextStyle(
                                                    fontSize: fs - 6,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                                Text(
                                                  '月日',
                                                  style: TextStyle(
                                                    fontSize: fs - 6,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //■■■■■■■■■天干の行■■■■■■■■■
                                SizedBox(
                                  height: hi,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              child: Text(
                                                nitikan,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fs,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeisikiNitikan(
                                                              seinenInt:
                                                                  seinenInt,
                                                              seigatuInt:
                                                                  seigatuInt,
                                                              seinitiInt:
                                                                  seinitiInt,
                                                              aiteInt: aiteInt),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              gatukan,
                                              style: TextStyle(
                                                fontSize: fs,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              nenkan,
                                              style: TextStyle(
                                                fontSize: fs,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        //height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              '干',
                                              style: TextStyle(
                                                fontSize: fs - 2,
                                                color: Colors.cyanAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //■■■■■■■■■地支の行■■■■■■■■■
                                SizedBox(
                                  height: hi,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              nitisi,
                                              style: TextStyle(
                                                fontSize: fs,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              gatusi,
                                              style: TextStyle(
                                                fontSize: fs,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              nensi,
                                              style: TextStyle(
                                                fontSize: fs,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Text(
                                              '支',
                                              style: TextStyle(
                                                fontSize: fs - 2,
                                                color: Colors.cyanAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //■■■■■■■■■支合支冲の行■■■■■■■■■
                                SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1 * 3,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: w1 / 2,
                                                    child: Container(),
                                                  ),
                                                  SizedBox(
                                                    width: w1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: Colors
                                                                .tealAccent,
                                                            width: 1,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 0,
                                                  ),
                                                  SizedBox(
                                                    width: w1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: Colors
                                                                .tealAccent,
                                                            width: 1,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 60,
                                                  ),
                                                  SizedBox(
                                                    width: w1 * 3 - 60 * 2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: Colors
                                                                .tealAccent,
                                                            width: 1,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 60,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '支合',
                                                  style: TextStyle(
                                                    fontSize: fs - 4,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                                Text(
                                                  '支冲',
                                                  style: TextStyle(
                                                    fontSize: fs - 4,
                                                    color: Colors.cyanAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //■■■■■■■■■蔵干の行■■■■■■■■■
                                SizedBox(
                                  height: hi,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        //height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                              child: Text(
                                            zouKanNiti,
                                            style: TextStyle(
                                              fontSize: fs,
                                            ),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        //height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                              child: Text(
                                            zouKanTuki,
                                            style: TextStyle(
                                              fontSize: fs,
                                            ),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        //height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.tealAccent,
                                                width: 1,
                                              )),
                                          child: Center(
                                              child: Text(
                                            zouKanNen,
                                            style: TextStyle(
                                              fontSize: fs,
                                            ),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const KaisetuPage(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                '蔵干',
                                                style: TextStyle(
                                                  fontSize: fs - 4,
                                                  color: Colors.cyanAccent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //■■■■■■■■■通変星の行■■■■■■■■■
                                SizedBox(
                                  height: hi * 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  '', //日天
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  tuuhenbosiNitiSi, //日地
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  tuuhenbosiGetuKan, //月天
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  tuuhenbosiGetuSi, //月地
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  tuuhenbosiNenKan, //年天
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: hi,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.tealAccent,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                  tuuhenbosiNenSi, //年地
                                                  style: TextStyle(
                                                    fontSize: fs - 2,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  '通',
                                                  style: TextStyle(
                                                    fontSize: fs - 3,
                                                    color: Colors.cyanAccent,
                                                    height: 0.1,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const KaisetuPage(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    '変',
                                                    style: TextStyle(
                                                      fontSize: fs - 3,
                                                      color: Colors.cyanAccent,
                                                      height: 0.1,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '星',
                                                  style: TextStyle(
                                                    fontSize: fs - 3,
                                                    color: Colors.cyanAccent,
                                                    height: 0.1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //■■■■■■■■■12運の行■■■■■■■■■
                                SizedBox(
                                  height: hi,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              child: Text(
                                                juuniUnNiti, //12運日
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fs,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeisikiJuuniun(
                                                            seinenInt: seinenInt,
                                                            seigatuInt: seigatuInt,
                                                            seinitiInt: seinitiInt,
                                                            aiteInt: aiteInt,
                                                            hasira: 0,),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              child: Text(
                                                juuniUnGetu, //12運月
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fs,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeisikiJuuniun(
                                                            seinenInt: seinenInt,
                                                            seigatuInt: seigatuInt,
                                                            seinitiInt: seinitiInt,
                                                            aiteInt: aiteInt,
                                                            hasira: 1,),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              child: Text(
                                                juuniUnNen, //12運年
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fs,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeisikiJuuniun(
                                                            seinenInt: seinenInt,
                                                            seigatuInt: seigatuInt,
                                                            seinitiInt: seinitiInt,
                                                            aiteInt: aiteInt,
                                                            hasira: 2,),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w2,
                                        //height: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.pinkAccent,
                                                width: 2,
                                              )),
                                          child: Center(
                                            child: TextButton(
                                              child: Text(
                                                '十二運', //12運年
                                                style: TextStyle(
                                                  color: Colors.cyanAccent,
                                                  fontSize: fs - 10,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const KaisetuPage(),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 36,
                                      width: w1 * 3 + w2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Color(iroSetuiri),
                                              width: 2,
                                            )),
                                        child: Center(
                                          child: TextButton(
                                            child: Text(
                                              '節入り日（ $setuirigatuInt/$setuirinitiInt $setuirijiInt:$setuirihunInt ）から$setuirinitisuu日目',
                                              style: TextStyle(
                                                fontSize: fs - 6,
                                                color: Color(iroWhite),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              if (setuirinitisuu == 1) {
                                                _showSetuiri(context);
                                              } else {}
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //■■■■■■■■■取説の行■■■■■■■■■
                                SizedBox(
                                  height: 200,
                                  child: Container(
                                    color: Colors.black54,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '赤ワクのところを、タップすると、さらに詳しい説明をみることができます。',
                                            style: TextStyle(
                                              fontSize: fs - 6,
                                              color: Colors.greenAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSetuiri(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Container(
              color: Colors.blue,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      '節入り日に誕生しています。',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      '誕生時刻がわからない方は、「節入り時刻前」ボタンも押して2種類の命式表で鑑定し比べ、しっくりくる命式表を用いる必要があります。',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
