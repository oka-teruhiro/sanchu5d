import 'package:flutter/material.dart';
import '../input_page.dart';
import '../quiz/answer_page_005.dart';
import '../quiz/quiz_page_006.dart';

// ignore: must_be_immutable
class QuizPage005 extends StatelessWidget {
  final String apptitle;
  QuizPage005({
    super.key,
    required this.apptitle,
  });

  bool quizLast = false;
  int seikai = 1;
  String kotae = 'x';
  String kotaeMoji = 'a';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('5. 五行説とは'),
        ),
        body: Container(
            color: Colors.black,
            child: Column(children: [
              ListTile(
                title: Image.asset('assets/images/quiz/Q005/Q005.png'),
              ),
              SizedBox(
                height: 60,
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
                        onPressed: () {
                          if (seikai == 1) {
                            kotae = 'o';
                          } else {
                            kotae = 'x';
                          }
                          _showKotae(context);
                        },
                        child: const Text('1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          if (seikai == 2) {
                            kotae = 'o';
                          } else {
                            kotae = 'x';
                          }
                          _showKotae(context);
                        },
                        child: const Text('2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          if (seikai == 3) {
                            kotae = 'o';
                          } else {
                            kotae = 'x';
                          }
                          _showKotae(context);
                        },
                        child: const Text('3',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)),
                  ],
                ),
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
                                      builder: (context) => QuizPage006(
                                        apptitle: apptitle,
                                          ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ])))
            ])));
  }

  _showKotae(BuildContext context) {
    if (kotae == 'o') {
      kotaeMoji = 'すばらしい！正解です。';
    } else {
      kotaeMoji = '残念！不正解です。';
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.blue,
            height: 120,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
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
                          if (kotae == 'o') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnswerPage005(
                                  apptitle: apptitle,
                                    ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          if (kotae == 'o') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnswerPage005(
                                  apptitle: apptitle,
                                    ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
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
