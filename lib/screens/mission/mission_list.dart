import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/custom_dialog.dart';
import 'package:shallwe_app/model/mission.dart';
import 'package:shallwe_app/screens/login/sing_in.dart';
import '../../data/firebase_data_control.dart';
import '../../size.dart';
import '../../provider/point_provider.dart';

class MissionList extends StatefulWidget {
  MissionList({Key? key}) : super(key: key);

  @override
  State<MissionList> createState() => _MissionListState();
}

class _MissionListState extends State<MissionList> {
  final _authInstance = FirebaseAuth.instance;
  late PointProvider _pointProvider;

  @override
  Widget build(BuildContext context) {
    _pointProvider = Provider.of<PointProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: currentUser.missions.length,
      itemBuilder: (context, idx) {
        Mission mission = currentUser.missions[idx];
        return GestureDetector(
          child: _listTile(context, idx, mission),
          onTap: () {
            print(mission.info); //클릭시 미션 정보 표시
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CustomDialog(idx: idx);
              },
            );
          },
        );
      },
    );
  }

  Widget _listTile(BuildContext context, int idx, Mission mission) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: 616 * getScaleWidth(context),
            height: 100 * getScaleHeight(context),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff707070), width: 1),
              color: const Color(0xffffffff),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(40 * getScaleWidth(context), 0,
                  20 * getScaleWidth(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildText((mission.point).toString(), context),
                  _buildText(mission.title, context),
                  _buildCheckBox(idx)
                ],
              ),
            ),
          ),
          SizedBox(height: 35 * getScaleHeight(context)),
        ],
      ),
    );
  }

  Text _buildText(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xff767676),
        fontWeight: FontWeight.w700,
        fontFamily: "NotoSansCJKkr",
        fontStyle: FontStyle.normal,
        fontSize: 25 * getScaleWidth(context),
      ),
    );
  }

  Widget _buildCheckBox(int idx) {
    //체크박스 빌드
    return SizedBox(
      width: 50 * getScaleWidth(context),
      height: 50 * getScaleHeight(context),
      child: Checkbox(
        shape: CircleBorder(),
        activeColor: Palette.checkColor,
        value: currentUser.missions[idx].weekCheck,
        onChanged: (bool? check) {
          setState(() {
            if (_authInstance.currentUser != null) {
              //로그인 상태 체크
              currentUser.missions[idx].weekCheck = check!;
              check ? _pointProvider.addPoint(5) : _pointProvider.subPoint(5);
              updateUserData(_authInstance, idx, check,
                  currentUser.pointSum); //유저, 랭킹 점수업데이트
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('로그인상태를 확인해주세요.')));
            }
          });
        },
      ),
    );
  }
}
