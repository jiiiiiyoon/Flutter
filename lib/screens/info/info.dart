import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/size.dart';
import '../../custom_widget/expandable_fab.dart';
import '../login/sing_in.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _authInstance = FirebaseAuth.instance;
  dynamic loggedUser;

  void getCurrentUser() {
    try {
      final user = _authInstance.currentUser;
      if (user != null) {
        loggedUser = user;

        print(loggedUser.email);
      }
      print(currentUser.missions.length);
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _authInstance.signOut();
    super.dispose();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('main info page')),
      body: Column(
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
                color: Palette.mintColor,
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
            child: ListView(
              // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
              scrollDirection: Axis.horizontal,
              // 컨테이너들을 ListView의 자식들로 추가
              children: <Widget>[
                Container(
                  width: 600 * getScaleWidth(context),
                  color: Colors.red,
                ),
                Container(
                  width: 35 * getScaleWidth(context),
                ),
                Container(
                  width: 600 * getScaleWidth(context),
                  color: Colors.blue,
                ),
                Container(
                  width: 35 * getScaleWidth(context),
                ),
                Container(
                  width: 600 * getScaleWidth(context),
                  color: Colors.green,
                ),
                Container(
                  width: 35 * getScaleWidth(context),
                ),
                Container(
                  width: 600 * getScaleWidth(context),
                  color: Colors.yellow,
                ),
                Container(
                  width: 35 * getScaleWidth(context),
                ),
                Container(
                  width: 600 * getScaleWidth(context),
                  color: Colors.orange,
                )
              ],
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
      floatingActionButton: expandableFab(context, widget.key),
    );
  }
}
