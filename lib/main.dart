import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../meisiki_page.dart';

//import '../page_g.dart';
import '../seikaku_page.dart';
import '../tenun_page.dart';
import '../meisiki_chart_page.dart';
import 'kyou_unsei_page.dart';
import 'input_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 追加

  try {
    // Firebase初期化を追加
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
    // Firebase が既に初期化されている場合は続行
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // テキストスケーリングを制御するbuilderを追加
      builder: (context, child) {
        return MediaQuery(
          // システムの文字サイズ設定を無視するように設定
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      // DatePickerを日本語化する
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      locale: const Locale('ja', 'JP'),
      // 日本語化ここまで
      title: '天運三柱推命',
      theme: ThemeData.dark(),
      home: const MyHomePage(
        apptitle: '天運三柱推命 ver6.3.27',
        // Todo: 修正したらバージョンをあげる
        seinenInt: 2000,
        // 6.1.2
        seigatuInt: 1,
        // 6.1.2
        seinitiInt: 1,
        // 6.1.2
        aiteInt: 0, //6.1.16
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final String apptitle; //6.1.35
  final int seinenInt; // 6.1.2
  final int seigatuInt; // 6.1.2
  final int seinitiInt; // 6.1.2
  final int aiteInt; // 6.1.16

  const MyHomePage({
    super.key,
    this.currentIndex = 0,
    required this.apptitle, // 6.1.35
    required this.seinenInt, // 6.1.2
    required this.seigatuInt, // 6.1.2
    required this.seinitiInt, // 6.1.2
    required this.aiteInt, // 6.1.16
  }); // currentIndexを追加

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late int _currentIndex;
  late int _seinenInt; // 6.1.2
  late int _seigatuInt; // 6.1.2
  late int _seinitiInt; // 6.1.2
  late int _aiteInt; // 6.1.16

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _seinenInt = widget.seinenInt; // 6.1.2
    _seigatuInt = widget.seigatuInt; // 6.1.2
    _seinitiInt = widget.seinitiInt; // 6.1.2
    _aiteInt = widget.aiteInt; // 6.1.16
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      InputPage(
        apptitle: widget.apptitle, // 6.1.35
      ),
      KyouUnseiPage(
        seinenInt: _seinenInt, // 6.1.2
        seigatuInt: _seigatuInt, // 6.1.2
        seinitiInt: _seinitiInt, // 6.1.2
        aiteInt: _aiteInt, // 6.1.16
      ),
      SeikakuPage(
        seinenInt: _seinenInt, // 6.1.15
        seigatuInt: _seigatuInt, // 6.1.15
        seinitiInt: _seinitiInt, // 6.1.15
        aiteInt: _aiteInt, // 6.1.16
      ),
      TenunPage(
        seinen: _seinenInt, // 6.1.12
        seigatu: _seigatuInt, // 6.1.12
        seiniti: _seinitiInt, // 6.1.12
      ),
      MeisikiPage(
        // 6.1.9
        seinen: _seinenInt, // 6.1.9
        seigatu: _seigatuInt, // 6.1.9
        seiniti: _seinitiInt,
        aiteInt: _aiteInt, // 6.1.9
      ), // 6.1.9
      MeisikiChartPage(
        // 6.1.8
        seinenInt: _seinenInt, // 6.1.8
        seigatuInt: _seigatuInt, // 6.1.8
        seinitiInt: _seinitiInt, // 6.1.8
      ),
      //const PageG(),//todo 相性ページはここに追加
    ];
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: _currentIndex == 0
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black12,
              selectedItemColor: Colors.greenAccent,
              unselectedItemColor: Colors.white30,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.cake),
                  label: '誕生日',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up),
                  label: '運勢',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '性格',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: '天運年',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart),
                  label: '命式表',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart),
                  label: 'ﾁｬｰﾄ',
                ),
                /*BottomNavigationBarItem(  //todo 相性ページはここに追加
                  icon: Icon(Icons.supervisor_account),
                  label: '相性',
                ),*/
              ],
            ),
    );
  }
}
