import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandablefab.dart';
import 'package:shallwe_app/provider/point_provider.dart';
import 'package:shallwe_app/screens/mission/mission_list.dart';
import 'package:shallwe_app/size.dart';

class Mission extends StatefulWidget {
  Mission({Key? key}) : super(key: key);

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    print('mission init');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PointProvider>(
      create: (_) => PointProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Mission')),
        body: Padding(
          padding: EdgeInsets.fromLTRB(43 * getScaleWidth(context),
              75 * getScaleHeight(context), 43 * getScaleWidth(context), 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 664 * getScaleWidth(context),
                  height: 104 * getScaleHeight(context),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Palette.mintColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Text('미션 리스트'),
                      Text('랭킹'),
                    ],
                    onTap: (clidkedTab) {
                      setState(() {});
                      print(_tabController.index);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5 * getScaleHeight(context), 0,
                      86 * getScaleHeight(context)),
                  padding: EdgeInsets.fromLTRB(
                    24 * getScaleWidth(context),
                    32 * getScaleHeight(context),
                    24 * getScaleWidth(context),
                    0,
                  ),
                  width: 664 * getScaleWidth(context),
                  height: 880 * getScaleHeight(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xff707070),
                      width: 1,
                    ),
                    color: const Color(0xfff1f1f5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildContainer(
                              120, (_tabController.index == 0) ? '점수' : '등수'),
                          _buildContainer(
                              344, (_tabController.index == 0) ? '미션' : '이름'),
                          _buildContainer(
                              120, (_tabController.index == 0) ? '확인' : '점수'),
                        ],
                      ),
                      SizedBox(height: 20 * getScaleHeight(context)),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            MissionList(),
                            Text('rank'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildText(context),
              ],
            ),
          ),
        ),
        floatingActionButton: expandableFab(context),
      ),
    );
  }

  Column _buildText(BuildContext context) {
    //점수 / 랭킹 관련 택스트 출력
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (_tabController.index == 0) ? '당신의 점수는' : '당신의 랭킹은',
          style: TextStyle(
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontFamily: "NotoSansCJKkr",
              fontStyle: FontStyle.normal,
              fontSize: 32.0 * getScaleHeight(context)),
        ),
        Row(
          children: [
            SizedBox(width: 100 * getScaleWidth(context)),
            Consumer<PointProvider>(
              builder: (context, value, child) => Text(
                (_tabController.index == 0)
                    ? '${value.userPoint}'
                    : '${value.userPoint}', //추후 랭킹으로 교체
                style: TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSansCJKkr",
                  fontStyle: FontStyle.normal,
                  fontSize: 56.0 * getScaleHeight(context),
                ),
              ),
            ),
            Text(
              (_tabController.index == 0) ? '점 입니다' : '위 입니다',
              style: TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "NotoSansCJKkr",
                fontStyle: FontStyle.normal,
                fontSize: 32.0 * getScaleHeight(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _buildContainer(int width, String text) {
    return Container(
      width: width * getScaleWidth(context),
      height: 60 * getScaleHeight(context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: const Color(0xffa8d9d6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
