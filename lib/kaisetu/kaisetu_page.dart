import 'package:flutter/material.dart';
import '../kaisetu/kaisetu_hajimeni.dart';
import '../kaisetu/kaisetu_tuuhenbosi.dart';
import '../kaisetu/kaisetu_zoukan.dart';
import '../meisiki/meisiki_juuniun_kaisetu.dart';
class KaisetuPage extends StatefulWidget {

  const KaisetuPage({
    super.key,
  });

  @override
  KaisetuPageState createState() => KaisetuPageState();
}

class KaisetuPageState extends State<KaisetuPage> {
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
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '鑑定士を目指す方へ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int panelIndex, bool isExpanded) {
                      _togglePanel(panelIndex);
                    },
                    animationDuration: const Duration(seconds: 1),
                    children: [
                      // ToDo:■■■■■　はじめに　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[0],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              'はじめに',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            kaisetuHajimeni,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(0),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　十二運とは　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[1],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              '十二運とは',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            jnuk,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(1),
                            ),
                          ],
                        ),
                      ),
                      // Todo:■■■■■　蔵干とは　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[2],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              '蔵干とは',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            kaisetuZoukan,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(2),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　通変星とは　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[3],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return  const ListTile(
                            title: Text(
                              '通変星とは',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            kaisetuTuuhenbosi,
                            ListTile(
                              trailing: const Icon(Icons.expand_less),
                              onTap: () => _closePanel(3),
                            ),
                          ],
                        ),
                      ),
                      // ToDo:■■■■■　支合支冲　■■■■■
                      ExpansionPanel(
                        isExpanded: _listExpanded[4],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return  const ListTile(
                            title: Text(
                              '支合支冲とは',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                           // jnuk,
                            const ListTile(
                              title: Text(
                                '　工事中',
                                style: TextStyle(
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
