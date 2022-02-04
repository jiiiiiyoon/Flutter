import 'package:flutter/material.dart';
import '../config/color_palette.dart';
import '../size.dart';

Widget customElevatedButton(
    Function onPressed, String text, BuildContext context) {
  return ElevatedButton(
    onPressed: () => onPressed(),
    child: Text(text,
        style: TextStyle(
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w700,
          fontFamily: 'IM_Hyemin',
          fontStyle: FontStyle.normal,
          fontSize: 32.0 * getScaleHeight(context),
        )),
    style: ElevatedButton.styleFrom(
      minimumSize:
          Size(322 * getScaleWidth(context), 104 * getScaleHeight(context)),
      shadowColor: Palette.mintColor,
      elevation: 5.0,
    ),
  );
}
