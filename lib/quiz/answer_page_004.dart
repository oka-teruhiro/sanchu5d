import 'package:flutter/material.dart';
import '../input_page.dart';
import '../quiz/quiz_page_005.dart';

class AnswerPage004 extends StatelessWidget {
  final String apptitle;
  const AnswerPage004({
    super.key,
    required this.apptitle,
  });

  final bool quizLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('4. 運が良いとは'),
        ),
        body: Container(
            color: Colors.black,
            child: ListView(children: <Widget>[
              Column(children: [
                ListTile(
                  title: Image.asset('assets/images/quiz/Q004/A0040.png'),
                ),
                ListTile(
                  title: Image.asset('assets/images/quiz/Q004/A0041.png'),
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
                                        builder: (context) => QuizPage005(
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
