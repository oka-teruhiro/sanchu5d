import 'package:flutter/material.dart';
import '../quiz/quiz_page_002.dart';
import '../input_page.dart';

class AnswerPage001 extends StatelessWidget {
  final String apptitle;
  const AnswerPage001({
    super.key,
    required this.apptitle,
  });

  final bool quizLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('1. 易とは'),
        ),
        body: Container(
            color: Colors.black,
            child: ListView(children: <Widget>[
              Column(children: [
                ListTile(
                  title: Image.asset('assets/images/quiz/Q001/A0010.png'),
                ),
                ListTile(
                  title: Image.asset('assets/images/quiz/Q001/A0011.png'),
                ),
                ListTile(
                  title: Image.asset('assets/images/quiz/Q001/A0012.png'),
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
                                    //quizNoMoji = (quizNo + 2).toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizPage002(
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
