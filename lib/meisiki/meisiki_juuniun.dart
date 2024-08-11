import 'package:flutter/material.dart';
import '../kansuu.dart';
import '../meisiki/meisiki_juuniun_kyoujaku.dart';
import 'meisiki_juuniun_kaisetu.dart';
import 'meisiki_juuniun_syousai.dart';

class MeisikiJuuniun extends StatefulWidget {
  final int seinenInt;
  final int seigatuInt;
  final int seinitiInt;
  final int aiteInt;  //6.1.16
  final int hasira;   // 0:日柱 1:月柱 2:年柱 // 6.1.26

  const MeisikiJuuniun({
    super.key,
    required this.seinenInt,
    required this.seigatuInt,
    required this.seinitiInt,
    required this.aiteInt,  //6.1.16
    required this.hasira    //6.1.26
  });

  @override
  MeisikiJuuniunState createState() => MeisikiJuuniunState();
}

class MeisikiJuuniunState extends State<MeisikiJuuniun> {
  late int seinenInt = 2000; // 6.1.15
  late int seigatuInt = 1; //   6.1.15
  late int seinitiInt = 1; //   6.1.15
  late int aiteInt = 0;   //6.1.16
  late int hasira = 0;
  late final  List<bool> _listExpanded = [false, false, false, false, false];

  void _togglePanel(int index) {
    setState(() {
      if (index == 0) {
        _listExpanded[0] = !_listExpanded[0];
      } else if (index == 1) {
        _listExpanded[1] = !_listExpanded[1];
      } else if (index == 2) {
        _listExpanded[2] = !_listExpanded[2];
      } else if (index == 3) {
        _listExpanded[3] = !_listExpanded[3];
      } else  {
        _listExpanded[4] = !_listExpanded[4];
      }
    });
  }

  void _closePanel(int index) {
    setState(() {
      _listExpanded[index] = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    seinenInt = widget.seinenInt; // 6.1.15
    seigatuInt = widget.seigatuInt; // 6.1.15
    seinitiInt = widget.seinitiInt; // 6.1.15
    aiteInt = widget.aiteInt; // 6.1.16
    hasira = widget.hasira; //6.1.26

    List<Widget> nsu = [
      nsu0,
      nsu1,
      nsu2,
      nsu3,
      nsu4,
      nsu5,
      nsu6,
      nsu7,
      nsu8,
      nsu9,
      nsu10,
      nsu11,
    ];
    List<Widget> nss = [
      nss0,
      nss1,
      nss2,
    ];
    List<Widget> nsss = [
      nsss0,
      nsss1,
      nsss2,
    ];
    int unLevel = 0;

    String aiteMoji = '相手';
    if (aiteInt == 0) {
      aiteMoji = 'あなた';
    } else {
      aiteMoji = '相手';
    }

    // 生年月日から日干No.を算出する
    var nkMoji = meisikiA(seinenInt, seigatuInt, seinitiInt).substring(4, 5); // 日干を取り出す
    var nsMoji = meisikiA(seinenInt, seigatuInt, seinitiInt).substring(5, 6); // 日支を取り出す
    var gsMoji = meisikiA(seinenInt, seigatuInt, seinitiInt).substring(3, 4); // 月支を取り出す
    var ysMoji = meisikiA(seinenInt, seigatuInt, seinitiInt).substring(1, 2); // 月支を取り出す
    var jnuMoji = juuNiUnMoji(nkMoji, nsMoji);
    var jnuMojiG = juuNiUnMoji(nkMoji, gsMoji);
    var jnuMojiY = juuNiUnMoji(nkMoji, ysMoji);
    var jnuNo = juuNiUnNo(jnuMoji);
    var jnuNoG = juuNiUnNo(jnuMojiG);
    var jnuNoY = juuNiUnNo(jnuMojiY);
    var jnuMojiA = juuNiUnMojiA(jnuMoji);
    var jnuMojiAG = juuNiUnMojiA(jnuMojiG);
    var jnuMojiAY = juuNiUnMojiA(jnuMojiY);
    var jnuYomi = juuNiUnYomi(jnuMoji);
    var jnuYomiG = juuNiUnYomi(jnuMojiG);
    var jnuYomiY = juuNiUnYomi(jnuMojiY);
    // 四旺・四平・四衰を算出する
    var siouSisui = juuNiUnSiou(jnuMoji);
    //var siouSisuiG = juuNiUnSiou(jnuMojiG);
    //var siouSisuiY = juuNiUnSiou(jnuMojiY);
    var siouSisuiNo = juuNiUnSiouNo(jnuMoji);
    var siouSisuiNoG = juuNiUnSiouNo(jnuMojiG);
    var siouSisuiNoY = juuNiUnSiouNo(jnuMojiY);
    var siouSisuiA = juuNiUnSiouA(jnuMoji);
    var siouSisuiAG = juuNiUnSiouA(jnuMojiG);
    var siouSisuiAY = juuNiUnSiouA(jnuMojiY);

    // 運勢の強さをポイントとして算出する
    var unPoint = unseiPoint(siouSisuiNo, siouSisuiNoG, siouSisuiNoY);
    if(unPoint > 69){
      unLevel = 0;
    }else if(unPoint > 20){
      unLevel = 1;
    }else {
      unLevel = 2;
    }

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$seinenInt.$seigatuInt.$seinitiInt 生　$aiteMojiの十二運',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '　　　　　　　日柱　　月柱　　年柱',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '運勢の特徴　　 $jnuMoji　　　$jnuMojiG　　　$jnuMojiY ',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '運勢の強さ　　$siouSisuiA　　$siouSisuiAG　　$siouSisuiAY',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Text(
              '十二運の影響　 60%　　 30%　　 10%',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Divider(
              color: Colors.blue,
            ),
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int panelIndex, bool isExpanded) {
                      _togglePanel(panelIndex);
                    },
                    animationDuration: const Duration(seconds: 1),
                    children: [
                      // ToDo:■■■■■　日柱の十二運　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[0],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              '日柱の十二運　$jnuMojiA の特徴',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            ListTile(
                              title: Text(
                                '　日柱の十二運は、$jnuMoji（$jnuYomi）です。',
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            nsu[jnuNo], // Todo: 十二運No.を計算していれる
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(0),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　月柱の十二運　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[1],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              '月柱の十二運　$jnuMojiAG の特徴',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                '　月柱の十二運は、$jnuMojiG（$jnuYomiG）です。',
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            nsu[jnuNoG],
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(1),
                            ),
                          ],
                        ),
                      ),
                      // Todo:■■■■■　年柱の十二運　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[2],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              '年柱の十二運　$jnuMojiAY の特徴',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                '　年柱の十二運は、$jnuMojiY（$jnuYomiY）です。',
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            nsu[jnuNoY],
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(2),
                              //child: const Text('閉じる'),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　運勢の強さ　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[3],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return  ListTile(
                            title: Text(
                              '運勢の強さ $unPointポイント',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            nsss[unLevel],
                            ListTile(
                              title: Text(
                                 '　運勢の強さは、で$siouSisuiです。',
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                  '　一番影響を与える日柱の通変星が「$siouSisuiA」、'
                                      '多少影響を与える月柱の通変星が「$siouSisuiAG」、'
                                      'わずかに影響を与える年柱の通変星が「$siouSisuiAY」なので、'
                                      '総合的には、「$siouSisui」になります。',
                              ),
                            ),
                            nss[siouSisuiNo],
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(3),
                              //child: const Text('閉じる'),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　通変星解説　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[4],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return  const ListTile(
                            title: Text(
                              '通変星解説',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            jnuk0,
                            jnuk,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
      ),
    );
  }
}
