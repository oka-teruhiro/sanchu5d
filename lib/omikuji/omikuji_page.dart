import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchu5d/omikuji/omikuji_siyouhou.dart';

import 'omikuji_bottom_sheet.dart';
import 'omikuji_service.dart';

class OmikujiPage extends StatefulWidget {
  const OmikujiPage({super.key});

  @override
  State<OmikujiPage> createState() => _OmikujiPageState();
}

class _OmikujiPageState extends State<OmikujiPage> {
  final OmikujiService _omikujiService = OmikujiService();
  late final List<bool> _listExpanded = [true, false, false, false, false];
  bool _showPrayButton = true; // 祈りボタンの表示状態を管理
  bool _showOmikujiButton = false; // おみくじボタンの表示状態を管理
  bool _showInori = false; // 祈り中を管理

  void _togglePanel(int index) {
    setState(() {
      _listExpanded[index] = !_listExpanded[index];
    });
  }

  void _closePanel(int index) {
    setState(() {
      _listExpanded[index] = false;
    });
  }

  // 祈りボタンがタップされたときの処理
  void _onPrayButtonTapped() {
    setState(() {
      _showPrayButton = false;
      _showInori = true;
    });

    // 1秒後におみくじボタンを表示
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showInori = false;
          _showOmikujiButton = true;
        });
      }
    });
  }

  // おみくじボタンがタップされた時の処理
  void _onOmikujiButtonTapped() {
    setState(() {
      _showOmikujiButton = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text(
            'おみくじ（工事中）',
            style: const TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int panelIndex, bool isExpanded) {
                      _togglePanel(panelIndex);
                    },
                    animationDuration: const Duration(seconds: 10),
                    children: [
                      // ToDo:■■■■■　使用方法　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[0],
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              '使用方法',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            omikujiSiyouhou,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(0),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　東洋五術　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[1],
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
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
                              onTap: () => _closePanel(1),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　初詣　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[2],
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
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
                              onTap: () => _closePanel(2),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　精誠　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[3],
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
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
                              onTap: () => _closePanel(3),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　精誠　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[4],
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
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
                              onTap: () => _closePanel(4),
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
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_showPrayButton)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent,
                        ),
                        onPressed: _onPrayButtonTapped,
                        child: const Text(
                          '祈りを捧げる',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    if (_showOmikujiButton)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // 青色に変更
                        ),
                        onPressed: () {
                          _onOmikujiButtonTapped();
                          _showOmikuji(context);
                          },
                        child: const Text(
                          'おみくじを引く',
                          style: TextStyle(
                            color: Colors.white, // 青背景に合わせて文字色を白に
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    if (_showInori)
                      Text('祈りを捧げてください'),
                    ElevatedButton(
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
                  ],
                ),
              ),
            ),
          ],
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
