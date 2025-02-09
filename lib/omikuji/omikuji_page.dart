
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'omikuji_bottom_sheet.dart';
import 'omikuji_service.dart';

class OmikujiPage extends StatefulWidget {
  const OmikujiPage({super.key});

  @override
  State<OmikujiPage> createState() => _OmikujiPageState();
}

class _OmikujiPageState extends State<OmikujiPage> {

  final OmikujiService _omikujiService = OmikujiService();
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
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler:  const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black12,
            title: Text(
                'おみくじ',
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'おみくじ機能の使い方',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                      ),
                      child: const Text(
                        'おみくじを引く',
                        style: TextStyle(
                          //backgroundColor:
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        _showOmikuji(context);
                        //Navigator.pop(context);
                      },
                    ),
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
                            // ToDo:■■■■■　東洋五術　■■■■■
                            ExpansionPanel(
                              isExpanded: _listExpanded[0],
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                      '東洋五術からみた「おみくじ」',
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
                                          'おみくじを引く占術は、東洋五術の卜術に分類されます。・・・',
                                        style: const TextStyle(
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      trailing: const Icon(Icons.expand_less),
                                      onTap: () => _closePanel(0),
                                    ),
                                  ],
                                ),
                            ),
                            // ToDo:■■■■■　初詣　■■■■■
                            ExpansionPanel(
                              isExpanded: _listExpanded[1],
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    '初詣からみた「おみくじ」',
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
                                      '初詣でおみくじを引くと思いますが、・・・',
                                      style: const TextStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    trailing: const Icon(Icons.expand_less),
                                    onTap: () => _closePanel(1),
                                  ),
                                ],
                              ),
                            ),
                            // ToDo:■■■■■　精誠　■■■■■
                            ExpansionPanel(
                              isExpanded: _listExpanded[2],
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    '略式としての初詣',
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
                                      'なぜ、初詣の作法で恩恵が受けられるのかというと・・・',
                                      style: const TextStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    trailing: const Icon(Icons.expand_less),
                                    onTap: () => _closePanel(2),
                                  ),
                                ],
                              ),
                            ),
                            // ToDo:■■■■■　精誠　■■■■■
                            ExpansionPanel(
                              isExpanded: _listExpanded[3],
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    '「おみくじ」の精度を上げるには',
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
                                      '以上のことから、より「おみくじ」の精度を上げるには、次のことをすることをおすすめします。・・・',
                                      style: const TextStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    trailing: const Icon(Icons.expand_less),
                                    onTap: () => _closePanel(3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                ),
                const Divider(
                  color: Colors.blue,
                ),Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                      ),
                      child: const Text(
                        '戻る',
                        style: TextStyle(
                          color: Colors.black,
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
          ),
        ),
    );
  }

  // 画面下からおみくじの結果が出てくる
  void _showOmikuji(BuildContext context) async {
    try {
      // ローディング表示
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.tealAccent,
            ),
          );
        },
      );

      // データ取得
      final snapshot = await FirebaseFirestore.instance
          .collection('omikuji')
          .where('isActive', isEqualTo: true)
          .get();

      // ローディング終了
      if (mounted) Navigator.pop(context);

      // データ件数確認
      if (snapshot.docs.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('おみくじがありません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // ランダムにおみくじを1つ選択
      final random = Random();
      final randomDoc = snapshot.docs[random.nextInt(snapshot.docs.length)];
      final omikuji = randomDoc.data();

      // おみくじ表示
      if (mounted) {
        // おみくじ表示
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          transitionAnimationController: AnimationController(
            duration: const Duration(seconds: 1),
            vsync: Navigator.of(context),
          ),
          builder: (BuildContext context) {
            return OmikujiBottomSheet(
              omikuji: omikuji,
            );
          },
        );

        // 選択回数を更新
        await _omikujiService.incrementSelectedCount(randomDoc.id);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
