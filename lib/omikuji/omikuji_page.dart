//import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchu5d/omikuji/omikuji_siyouhou.dart';

import 'omikuji_bottom_sheet.dart';
import 'omikuji_prayer_screen.dart';
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
  //bool _showOmikujiButton = false; // おみくじボタンの表示状態を管理
  //bool _showInori = false; // 祈り中を管理
  late final DateTime _pageLoadTime; // ページ表示時刻

  @override
  void initState() {
    super.initState();
    _pageLoadTime = DateTime.now(); // ページ表示時刻を記録
  }

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
  void _onPrayButtonTapped() async {
    setState(() {
      _showPrayButton = false;
    });

    await Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) => const OmikujiPrayerScreen()),
    );
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
                        headerBuilder: (BuildContext context, bool isExpanded) {
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
                              onTap: () => _closePanel(1),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　初詣　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[2],
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
      final result = await _omikujiService.selectOmikujiByTiming(_pageLoadTime);

      if (mounted) Navigator.pop(context);
      // おみくじ表示
      if (mounted) {
        // おみくじ表示
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,  // 背景を透明に設定
          transitionAnimationController: AnimationController(
            duration: const Duration(milliseconds: 500),
            vsync: Navigator.of(context),
          ),
          // 画面遷移を維持したまま表示
          routeSettings: const RouteSettings(name: '/omikuji_result'),
          builder: (BuildContext context) {
            return OmikujiBottomSheet(
              omikuji: result['data'],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
