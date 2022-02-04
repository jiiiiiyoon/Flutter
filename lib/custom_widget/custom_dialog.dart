import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/screens/login/sing_in.dart';
import '../size.dart';

class CustomDialog extends StatefulWidget {
  final int idx;

  const CustomDialog({Key? key, required this.idx}) : super(key: key);
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      child: DialogBox(),
    );
  }

  Widget DialogBox() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 600 * getScaleWidth(context),
        height: 400 * getScaleHeight(context),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x1a000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
          color: const Color(0xffffffff),
        ),
        //다이얼로그 내용
        child: info(),
      ),
    );
  }

  Widget info() {
    return Padding(
      padding: EdgeInsets.all(8 * getScaleHeight(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 쓰레기 5개 줍기
          Text(currentUser.missions[widget.idx].title,
              style: TextStyle(
                color: const Color(0xff191919),
                fontWeight: FontWeight.w700,
                fontFamily: "IM_Hyemin",
                fontStyle: FontStyle.normal,
                fontSize: 36 * getScaleHeight(context),
              ),
              textAlign: TextAlign.center),
          Container(
            alignment: Alignment.center,
            height: 200 * getScaleHeight(context),
            child: SingleChildScrollView(
              child: Text(
                currentUser.missions[widget.idx].info,
                style: TextStyle(
                  color: const Color(0xff343435),
                  fontWeight: FontWeight.w400,
                  fontFamily: "IM_Hyemin",
                  fontStyle: FontStyle.normal,
                  fontSize: 30 * getScaleHeight(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //버튼 컨테이너
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400 * getScaleWidth(context),
                      50 * getScaleHeight(context)),
                  primary: Palette.mintColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                child: Text(
                  "돌아가기",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "IM_Hyemin",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
