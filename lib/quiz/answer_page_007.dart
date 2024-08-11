import 'package:flutter/material.dart';
import '../input_page.dart';
import '../quiz/quiz_page_007.dart';

class AnswerPage007 extends StatelessWidget {
  final String apptitle;
  const AnswerPage007({
    super.key,
    required this.apptitle,
  });

  final bool quizLast = true;
  final String kotaeMoji =
      '全問終了しました。次のアップデートでさらに問題を追加しますので、またチャレンジしてください。お疲れ様でした。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('7. 季節と五行'),
        ),
        body: Container(
            color: Colors.black,
            child: ListView(children: <Widget>[
              ListTile(
                title: Image.asset('assets/images/quiz/Q007/A0070.png'),
              ),
              ListTile(
                title: Image.asset('assets/images/quiz/Q007/A0071.png'),
              ),
              ListTile(
                title: Image.asset('assets/images/quiz/Q007/A0072.png'),
              ),
              SizedBox(
                  height: 60,
                  child: Container(
                      constraints: const BoxConstraints.expand(),
                      color: Colors.black,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: const Text('<< ホームページ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InputPage(
                                        apptitle: apptitle,
                                      ),
                                    ));
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: const Text('次の問題 >',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              onPressed: () {
                                if (quizLast == true) {
                                  _showQuizLast(context);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuizPage007(
                                        apptitle: apptitle,
                                          ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ]))),
            ])));
  }

  void _showQuizLast(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.blue,
            height: 250,
            child: Column(
              children: [
                SizedBox(
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          kotaeMoji,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputPage(
                                apptitle: apptitle,
                              ),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputPage(
                                apptitle: apptitle,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
