// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shallwe_app/config/color_palette.dart';
// import 'package:shallwe_app/custom_widget/expandable_fab.dart';
// import 'package:shallwe_app/size.dart';

// class QuizScreen extends StatefulWidget {
//   final int i;
//   QuizScreen({Key? key, required this.i}) : super(key: key);

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   bool flagO = false;
//   bool flagX = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Quiz",
//             style: const TextStyle(
//               color: const Color(0xff191919),
//               fontWeight: FontWeight.w700,
//               fontFamily: "Roboto",
//               fontStyle: FontStyle.normal,
//             ),
//             textAlign: TextAlign.left),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 104 * getScaleHeight(context),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 25),
//             width: 670 * getScaleWidth(context),
//             height: 800 * getScaleHeight(context),
//             decoration: BoxDecoration(
//               color: const Color(0xfff1f1f5),
//             ),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(height: 46 * getScaleHeight(context)),
//                     Row(
//                       children: [
//                         Container(
//                           width: 94 * getScaleWidth(context),
//                           height: 80 * getScaleHeight(context),
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 200 * getScaleWidth(context),
//                                 height: 80 * getScaleHeight(context),
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(50)),
//                                   border: Border.all(
//                                       color: const Color(0xffdbdbdb), width: 1),
//                                   color: const Color(0xffa8d9d6),
//                                 ),
//                                 child: Text(
//                                   "문항",
//                                   style: const TextStyle(
//                                     color: const Color(0xff191919),
//                                     fontWeight: FontWeight.w700,
//                                     fontFamily: "NotoSansCJKkr",
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 17.0,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               //수정할 부분
//                               Text(
//                                 "5 개",
//                                 style: const TextStyle(
//                                     color: const Color(0xff191919),
//                                     fontWeight: FontWeight.w700,
//                                     fontFamily: "NotoSansCJKkr",
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 17.0),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 82 * getScaleWidth(context),
//                           height: 80 * getScaleHeight(context),
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 200 * getScaleWidth(context),
//                                 height: 80 * getScaleHeight(context),
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(50)),
//                                   border: Border.all(
//                                       color: const Color(0xffdbdbdb), width: 1),
//                                   color: const Color(0xffa8d9d6),
//                                 ),
//                                 child: Text(
//                                   "현재 문항",
//                                   style: const TextStyle(
//                                     color: const Color(0xff191919),
//                                     fontWeight: FontWeight.w700,
//                                     fontFamily: "NotoSansCJKkr",
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 17.0,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Text(
//                                 widget.i.toString() + " 번",
//                                 style: const TextStyle(
//                                   color: const Color(0xff191919),
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: "NotoSansCJKkr",
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 17.0,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: 38 * getScaleHeight(context),
//                     ),
//                     // EX) 계란 껍질은 일반쓰레기다?​
//                     Container(
//                       width: 400 * getScaleWidth(context),
//                       height: 92 * getScaleHeight(context),
//                       child: Text(
//                         "EX) 계란 껍질은 \n일반쓰레기다?​",
//                         style: const TextStyle(
//                           color: const Color(0xff000000),
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "SegoeUI",
//                           fontStyle: FontStyle.normal,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Container(
//                       height: 186 * getScaleHeight(context),
//                     ),
//                     Container(
//                       height: 80 * getScaleHeight(context),
//                       width: 600 * getScaleWidth(context),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             flagO = !flagO;
//                           });

//                           //3초 있다가 실행
//                           Timer(Duration(seconds: 3), () {
//                             Navigator.pop(context);
//                           });
//                         },
//                         child: Text("O",
//                             style: const TextStyle(
//                                 color: const Color(0xffffffff),
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "SegoeUI",
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 32.0),
//                             textAlign: TextAlign.center),
//                         style: ElevatedButton.styleFrom(
//                           primary: flagO ? Colors.red : Palette.mintColor,
//                           shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(30.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 48 * getScaleHeight(context),
//                     ),
//                     Container(
//                       height: 80 * getScaleHeight(context),
//                       width: 600 * getScaleWidth(context),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Timer(Duration(seconds: 3), () {
//                             print("Yeah, this line is printed after 3 seconds");
//                           });
//                           setState(() {
//                             flagX = !flagX;
//                           });
//                         },
//                         child: Text("X",
//                             style: const TextStyle(
//                                 color: const Color(0xffffffff),
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "SegoeUI",
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 32.0),
//                             textAlign: TextAlign.center),
//                         style: ElevatedButton.styleFrom(
//                           primary: flagX ? Colors.red : Palette.mintColor,
//                           shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(30.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: expandableFab(context, widget.key),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandable_fab.dart';
import 'package:shallwe_app/data/firebase_data_control.dart';
import 'package:shallwe_app/data/get_weather_svg.dart';
import 'package:shallwe_app/model/quiz.dart';
import 'package:shallwe_app/size.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  final int i;
  QuizScreen({Key? key, required this.i}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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

  void s() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz",
            style: const TextStyle(
              color: const Color(0xff191919),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.left),
      ),
      body: FutureBuilder(
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
                              SizedBox(height: 46 * getScaleHeight(context)),
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
                                          width: 200 * getScaleWidth(context),
                                          height: 80 * getScaleHeight(context),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            border: Border.all(
                                                color: const Color(0xffdbdbdb),
                                                width: 1),
                                            color: const Color(0xffa8d9d6),
                                          ),
                                          child: Text(
                                            "문항",
                                            style: const TextStyle(
                                              color: const Color(0xff191919),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "NotoSansCJKkr",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 17.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        //수정할 부분
                                        Text(
                                          "5 개",
                                          style: const TextStyle(
                                              color: const Color(0xff191919),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "NotoSansCJKkr",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 17.0),
                                          textAlign: TextAlign.left,
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
                                          width: 200 * getScaleWidth(context),
                                          height: 80 * getScaleHeight(context),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            border: Border.all(
                                                color: const Color(0xffdbdbdb),
                                                width: 1),
                                            color: const Color(0xffa8d9d6),
                                          ),
                                          child: Text(
                                            "현재 문항",
                                            style: const TextStyle(
                                              color: const Color(0xff191919),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "NotoSansCJKkr",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 17.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          "${index + 1} 번",
                                          style: const TextStyle(
                                            color: const Color(0xff191919),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "NotoSansCJKkr",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 17.0,
                                          ),
                                          textAlign: TextAlign.left,
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
                                    fontFamily: "SegoeUI",
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
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
                                    onPressed: () {
                                      if (!isPressed) {
                                        setState(() {
                                          isPressed = true;
                                        });

                                        if (quiz
                                            .quizList[currentQuizList[index]]
                                            .answerList[i]
                                            .check) {
                                          score += 1;
                                          resultStr += "O";
                                        } else {
                                          resultStr += "X";
                                        }

                                        if (currentQuizList.length ==
                                            index + 1) {
                                          FlutterDialog();
                                        } else {
                                          Timer(Duration(seconds: 1), () {
                                            _controller.nextPage(
                                              duration:
                                                  Duration(milliseconds: 200),
                                              curve: Curves.ease,
                                            );
                                          });
                                        }
                                      }
                                    },
                                    shape: StadiumBorder(),
                                    color: !isPressed
                                        ? Palette.mintColor
                                        : quiz.quizList[currentQuizList[index]]
                                                .answerList[i].check
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
      ),
      floatingActionButton: expandableFab(context, widget.key),
    );
  }

  void FlutterDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
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
                  Text(
                    resultStr,
                    style: const TextStyle(
                        color: Palette.mintColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 27.0),
                    textAlign: TextAlign.center,
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
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.0),
                            text: "5"),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            text: "문항 중 "),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.0),
                            text: score.toString()),
                        TextSpan(
                            style: const TextStyle(
                                color: const Color(0xff191919),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSansCJKkr",
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
                      onPressed: () {
                        //누르면 메인화면으로 가기 & 유저 점수 저장
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
