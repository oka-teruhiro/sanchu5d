import 'package:flutter/material.dart';
import '../manual_page.dart';
import '../osirase/profile.dart';
import '../quiz/quiz_page_001.dart';
import 'osirase/update.dart';

class SideMenu extends StatelessWidget {
  final String apptitle; // 6.1.35
  const SideMenu({
    super.key,
    required this.apptitle,
  });

  @override
  Widget build(BuildContext context) {

     var header = DrawerHeader(
      child: Column(
        children: [
          ListTile(
            title: SizedBox(
              height: 70,
                child: Image.asset('assets/images/icon/icon_uranai_x1024.png'),
            ),
          ),
          Text(
            apptitle, // 6.1.35
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    final tileA = ListTile(
      title: const Text('プロフィール'),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Profile(),
            ));
      },
    );
    final tileB = ListTile(
      title: const Text('アップデート'),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Update(),
            ));
      },
    );
     final tileC = ListTile(
       title: const Text('このアプリの使い方'),
       onTap: () {
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => const ManualPage(),
             ));
       },
     );
     final tileD = ListTile(
       title: const Text('易占クイズ'),
       onTap: () {
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => QuizPage001(apptitle: apptitle),
             ));
       },
     );
    final list = ListView(
      children: [
        header,
        tileC,
        tileD,
        tileB,
        tileA,
      ],

    );
    return list;
  }
}
