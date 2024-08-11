import 'package:flutter/material.dart';
import '../input_page.dart';
import '../quiz/answer_page_007.dart';

// ignore: must_be_immutable
class QuizPage007 extends StatelessWidget {
  final String apptitle;
  QuizPage007({
    super.key,
    required this.apptitle,
  });

  bool quizLast = true;
  int seikai = 2;
  String kotae = 'x';
  String kotaeMoji = '全問終了しました。次のアップデートでさらに問題を追加しますので、またチャレンジしてください。お疲れ様でした。';

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
                title: Image.asset('assets/images/quiz/Q007/Q007.png'),
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
                                builder: (context) => AnswerPage007(
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
                                builder: (context) => AnswerPage007(
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
                            fontSize: 16,
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
                            fontSize: 16,
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
