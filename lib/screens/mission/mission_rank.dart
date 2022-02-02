import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shallwe_app/data/firebase_data_control.dart';
import 'package:shallwe_app/provider/rank_provider.dart';
import 'package:shallwe_app/screens/login/sing_in.dart';
import '../../size.dart';

class MissionRank extends StatefulWidget {
  MissionRank({Key? key}) : super(key: key);

  @override
  State<MissionRank> createState() => _MissionRankState();
}

class _MissionRankState extends State<MissionRank> {
  StreamController streamctrl = StreamController();
  late RankProvider _rankProvider;
  late int userRank = 0;
  @override
  Widget build(BuildContext context) {
    _rankProvider = Provider.of<RankProvider>(context, listen: false);
    return StreamBuilder(
      stream: getRankStream(),
      // initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          print('rank snapshot has not data');
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null && snapshot.hasError) {
          print('rank snapshot has error');
          return Text('Error');
        }

        Map rankMap = snapshot.data.data() as Map;
        List<Map> rankList = [];
        rankMap.forEach((key, value) => rankList.add(value)); //리스트로 형식을 바꾸고 정렬
        rankList.sort((a, b) => b['point_sum'].compareTo(a['point_sum']));

        return _duildListView(rankList);
      },
    );
  }

  ListView _duildListView(List rankList) {
    return ListView.builder(
      itemCount: rankList.length,
      itemBuilder: (context, idx) {
        //빌드하며 유저의 랭크를 찾음
        if (rankList[idx]['name'] == currentUser.name) {
          print('change user rank');
          userRank = idx + 1;
          customSST();
        }
        return _listTile(idx, rankList[idx]);
      },
    );
  }

  customSST() async {
    //비동기로 틱을 미뤄 빌드가 끝나고 notifyListener가 실행되게 한다.
    await Duration(seconds: 0);
    _rankProvider.changeRank(userRank);
  }

  Widget _listTile(int idx, Map rank) {
    return Column(
      children: [
        Container(
          width: 616 * getScaleWidth(context),
          height: 100 * getScaleHeight(context),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff707070), width: 1),
            color: const Color(0xffffffff),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                40 * getScaleWidth(context), 0, 20 * getScaleWidth(context), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildText((idx + 1).toString(), context),
                _buildText(rank['name'], context),
                _buildText('${rank['point_sum']}', context),
              ],
            ),
          ),
        ),
        SizedBox(height: 35 * getScaleHeight(context)),
      ],
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
}
