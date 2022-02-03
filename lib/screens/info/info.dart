import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandable_fab.dart';
import 'package:shallwe_app/data/firebase_data_control.dart';
import 'package:shallwe_app/model/news.dart';
import 'package:shallwe_app/size.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _authInstance = FirebaseAuth.instance;
  dynamic loggedUser;
  late NewsList news;
  PageController _controller =
      PageController(initialPage: 1, viewportFraction: 0.8);

  late Future _getQuiz;
  void launchURL(url) async {
    await launch(url, forceWebView: true, forceSafariVC: true);
  }

  @override
  void initState() {
    _getQuiz = getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('main info page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50 * getScaleHeight(context),
            ),
            Row(
              children: [
                Container(
                  height: 160 * getScaleHeight(context),
                  width: 53 * getScaleWidth(context),
                ),
                Container(
                  height: 160 * getScaleHeight(context),
                  width: 322 * getScaleWidth(context),
                  child: Text("현재\n날씨 정보",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 27),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
            SizedBox(
              height: 21 * getScaleHeight(context),
            ),
            Row(
              children: [
                Container(
                  height: 500 * getScaleHeight(context),
                  width: 40 * getScaleWidth(context),
                ),
                Container(
                  width: 670 * getScaleWidth(context),
                  height: 500 * getScaleHeight(context),
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40 * getScaleHeight(context),
            ),
            Container(
              // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 20픽세의 마진 삽입
              margin: EdgeInsets.symmetric(vertical: 20.0),
              // 컨테이너의 높이를 200으로 설정
              height: 168 * getScaleWidth(context),
              // 리스트뷰 추가
              child: FutureBuilder(
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
                    news = snapshot.data;
                    return PageView.builder(
                      // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
                      scrollDirection: Axis.horizontal,
                      itemCount: news.newsList.length,
                      controller: _controller,

                      itemBuilder: (BuildContext context, int index) {
                        return newsContainer(index);
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 62 * getScaleHeight(context),
            ),
            Row(
              children: [
                Container(
                  width: 75 * getScaleWidth(context),
                ),
                Container(
                  height: 250 * getScaleHeight(context),
                  width: 300 * getScaleWidth(context),
                  color: Palette.mintColor,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: expandableFab(context, widget.key),
    );
  }

  Widget newsContainer(int index) {
    return Container(
      height: 168 * getScaleHeight(context),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xfff1f1f5),
              fixedSize: Size(
                570 * getScaleWidth(context),
                168 * getScaleHeight(context),
              ),
              elevation: 0.3,
            ),
            onPressed: () {
              launchURL(news.newsList[index].url);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    news.newsList[index].pubCompany,
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0),
                  ),
                ),
                Text(
                  news.newsList[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: "NotoSansCJKkr",
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0),
                ),
                Container(
                  height: 28.5 * getScaleHeight(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 17,
                          ),
                          Text(
                            news.newsList[index].reporter,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      news.newsList[index].date,
                      style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
