import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandablefab.dart';
import 'package:shallwe_app/size.dart';

class QuizScreen extends StatefulWidget {
  final int i;
  QuizScreen(this.i);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool flagO = false;
  bool flagX = false;

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
      body: Column(
        children: [
          SizedBox(
            height: 104 * getScaleHeight(context),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: 670 * getScaleWidth(context),
            height: 800 * getScaleHeight(context),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  border: Border.all(
                                      color: const Color(0xffdbdbdb), width: 1),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  border: Border.all(
                                      color: const Color(0xffdbdbdb), width: 1),
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
                                widget.i.toString() + " 번",
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
                    Container(
                      height: 38 * getScaleHeight(context),
                    ),
                    // EX) 계란 껍질은 일반쓰레기다?​
                    Container(
                      width: 400 * getScaleWidth(context),
                      height: 92 * getScaleHeight(context),
                      child: Text(
                        "EX) 계란 껍질은 \n일반쓰레기다?​",
                        style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "SegoeUI",
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 186 * getScaleHeight(context),
                    ),
                    Container(
                      height: 80 * getScaleHeight(context),
                      width: 600 * getScaleWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            flagO = !flagO;
                          });

                          //3초 있다가 실행
                          Timer(Duration(seconds: 3), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("O",
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "SegoeUI",
                                fontStyle: FontStyle.normal,
                                fontSize: 32.0),
                            textAlign: TextAlign.center),
                        style: ElevatedButton.styleFrom(
                          primary: flagO ? Colors.red : Palette.mintColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 48 * getScaleHeight(context),
                    ),
                    Container(
                      height: 80 * getScaleHeight(context),
                      width: 600 * getScaleWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          Timer(Duration(seconds: 3), () {
                            print("Yeah, this line is printed after 3 seconds");
                          });
                          setState(() {
                            flagX = !flagX;
                          });
                        },
                        child: Text("X",
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "SegoeUI",
                                fontStyle: FontStyle.normal,
                                fontSize: 32.0),
                            textAlign: TextAlign.center),
                        style: ElevatedButton.styleFrom(
                          primary: flagX ? Colors.red : Palette.mintColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: expandableFab(context),
    );
  }
}
