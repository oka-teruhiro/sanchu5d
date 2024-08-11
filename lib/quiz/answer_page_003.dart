import 'package:flutter/material.dart';
import '../input_page.dart';
import '../quiz/quiz_page_004.dart';

class AnswerPage003 extends StatelessWidget {
  final String apptitle;
  const AnswerPage003({
    super.key,
    required this.apptitle,
  });

  final bool quizLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('3. 四柱推命の始まり'),
        ),
        body: Container(
            color: Colors.black,
            child: ListView(children: <Widget>[
              Column(children: [
                ListTile(
                  title: Image.asset('assets/images/quiz/Q003/A0030.png'),
                ),
                ListTile(
                  title: Image.asset('assets/images/quiz/Q003/A0031.png'),
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
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizPage004(
                                          apptitle: apptitle,
                                            ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ])))
              ]),
            ])));
  }
}
