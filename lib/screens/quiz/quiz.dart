import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandable_fab.dart';
import 'package:shallwe_app/data/firebase_data_control.dart';
import 'package:shallwe_app/model/quiz.dart';
import 'package:shallwe_app/provider/point_provider.dart';
import 'package:shallwe_app/screens/login/sing_in.dart';
import 'package:shallwe_app/size.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  final int i;
  QuizScreen({Key? key, required this.i}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PointProvider _pointProvider;

  final _authInstance = FirebaseAuth.instance;
  bool flagO = false;
  bool flagX = false;

  late QuizList quiz;
  late Future _getQuiz;

  PageController _controller = PageController(initialPage: 0);
  bool isPressed = false;
  Color isTrue = Colors.green;
  Color isFalse = Colors.red;
  Color btnColor = Palette.mintColor;
  int score = 0;
  bool randFlag = false;
  String resultStr = "";
  List<int> currentQuizList = [];

  @override
  void initState() {
    super.initState();

    _getQuiz = getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz",
            style: const TextStyle(
              color: const Color(0xff191919),
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.left),
      ),
      body: ChangeNotifierProvider(
        create: (context) => PointProvider(),
        builder: (context, child) {
          _pointProvider = Provider.of<PointProvider>(context, listen: false);
          return FutureBuilder(
            future: _getQuiz,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                if (!randFlag) {
                  quiz = snapshot.data;

                  //랜덤 인덱스 5개

                  while (true) {
                    //1~퀴즈의 수 중 랜덤 숫자 하나 고름
                    var rand = Random().nextInt(quiz.quizList.length);

                    //중복 제거
                    if (!currentQuizList.contains(rand)) {
                      currentQuizList.add(rand);
                    }

                    //만약 크기가 5개면 그만
                    if (currentQuizList.length == 5) {
                      print("인덱스의 값 ${currentQuizList}");
                      break;
                    }
                  }

                  randFlag = true;
                }

                return PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (page) {
                    setState(() {
                      isPressed = false;
                    });
                  },
                  itemCount: currentQuizList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 104 * getScaleHeight(context),
                        ),
                        Container(
                          width: 670 * getScaleWidth(context),
                          height: 946 * getScaleHeight(context),
                          decoration: BoxDecoration(
                            color: const Color(0xfff1f1f5),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                      height: 46 * getScaleHeight(context)),
                                  Row(
                                    children: [
                                      Container(
                                        width: 94 * getScaleWidth(context),
                                        height: 80 * getScaleHeight(context),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  200 * getScaleWidth(context),
                                              height:
                                                  80 * getScaleHeight(context),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffdbdbdb),
                                                    width: 1),
                                                color: const Color(0xffa8d9d6),
                                              ),
                                              child: Text(
                                                "문항",
                                                style: const TextStyle(
                                                  color:
                                                      const Color(0xff191919),
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ),
                                            //수정할 부분
                                            Text(
                                              "5 개",
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xff191919),
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 17.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 82 * getScaleWidth(context),
                                        height: 80 * getScaleHeight(context),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  200 * getScaleWidth(context),
                                              height:
                                                  80 * getScaleHeight(context),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffdbdbdb),
                                                    width: 1),
                                                color: const Color(0xffa8d9d6),
                                              ),
                                              child: Text(
                                                "현재 문항",
                                                style: const TextStyle(
                                                  color:
                                                      const Color(0xff191919),
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${index + 1} 번",
                                              style: const TextStyle(
                                                color: const Color(0xff191919),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 17.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 38 * getScaleHeight(context),
                                  ),
                                  Container(
                                    width: 400 * getScaleWidth(context),
                                    height: 92 * getScaleHeight(context),
                                    child: Text(
                                      quiz.quizList[currentQuizList[index]]
                                          .question,
                                      style: const TextStyle(
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 120 * getScaleHeight(context),
                                  ),
                                  for (int i = 0;
                                      i <
                                          quiz.quizList[currentQuizList[index]]
                                              .answerList.length;
                                      ++i)
                                    Container(
                                      width: 600 * getScaleWidth(context),
                                      height: 80 * getScaleHeight(context),
                                      margin: EdgeInsets.only(bottom: 18.0),
                                      child: MaterialButton(
                                        child: Text(
                                          quiz.quizList[currentQuizList[index]]
                                              .answerList[i].content,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (!isPressed) {
                                            setState(() {
                                              isPressed = true;
                                            });

                                            if (quiz
                                                .quizList[
                                                    currentQuizList[index]]
                                                .answerList[i]
                                                .check) {
                                              score += 1;
                                              resultStr += "O";
                                            } else {
                                              resultStr += "X";
                                            }

                                            if (currentQuizList.length ==
                                                index + 1) {
                                              await FlutterDialog()
                                                  .whenComplete(() async {
                                                if (score > 0) {
                                                  await _pointProvider
                                                      .addPoint(4 * score);
                                                  updateUserPoint(_authInstance,
                                                      currentUser.pointSum);
                                                }
                                                Navigator.of(context).pop();
                                              });
                                            } else {
                                              Timer(Duration(seconds: 1), () {
                                                _controller.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.ease,
                                                );
                                              });
                                            }
                                          }
                                        },
                                        shape: StadiumBorder(),
                                        color: !isPressed
                                            ? Palette.mintColor
                                            : quiz
                                                    .quizList[
                                                        currentQuizList[index]]
                                                    .answerList[i]
                                                    .check
                                                ? isTrue
                                                : isFalse,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: expandableFab(context, widget.key),
    );
  }

  Future<void> FlutterDialog() async {
    print('dialog');
    await showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          print('build start');
          return Dialog(
            child: Container(
              width: 600 * getScaleWidth(context),
              height: 368 * getScaleHeight(context),
              child: Column(
                children: [
                  Container(
                    height: 15 * getScaleHeight(context),
                    color: Palette.mintColor,
                  ),
                  Container(
                    height: 1 * getScaleHeight(context),
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 37 * getScaleHeight(context),
                  ),
                  Container(
                    width: 268 * getScaleWidth(context),
                    height: 74 * getScaleHeight(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int n = 0; n < 5; ++n)
                          resultStr[n].toString() == 'O'
                              ? Container(
                                  width: 50 * getScaleWidth(context),
                                  height: 50 * getScaleHeight(context),
                                  child: Image.asset(
                                    'assets/O.png',
                                  ),
                                )
                              : Container(
                                  width: 50 * getScaleWidth(context),
                                  height: 50 * getScaleHeight(context),
                                  child: Image.asset(
                                    'assets/X.png',
                                  ),
                                )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36.5 * getScaleHeight(context),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 17.0),
                            text: "5"),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            text: "문항 중 "),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 17.0),
                            text: score.toString()),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            text: "문항을 맞추셨습니다.")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 46 * getScaleHeight(context),
                  ),
                  Container(
                    width: 400 * getScaleWidth(context),
                    height: 62 * getScaleHeight(context),
                    child: MaterialButton(
                      child: Text(
                        "메인화면으로",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () async {
                        //누르면 메인화면으로 가기 & 유저 점수 저장
                        print('pressed');

                        Navigator.pop(context);
                      },
                      shape: StadiumBorder(),
                      color: Palette.mintColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
