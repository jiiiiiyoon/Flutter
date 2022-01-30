import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import '../size.dart';

class ChildActionButton extends StatelessWidget {
  final VoidCallback onpressed;
  final Icon icon;
  const ChildActionButton({required this.onpressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(45 * getScaleWidth(context)),
            primary: Palette.mintColor,
            elevation: 7,
            shadowColor: Palette.mintColor,
          ),
          onPressed: onpressed,
          child: null,
          clipBehavior: Clip.antiAlias,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(8 * getScaleHeight(context)),
            primary: Color(0xfff0f0f5),
          ),
          onPressed: onpressed,
          child: icon,
          clipBehavior: Clip.antiAlias,
        ),
      ],
    );
  }
}
