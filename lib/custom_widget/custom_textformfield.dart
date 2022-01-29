import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shallwe_app/config/color_palette.dart';
import '../size.dart';

Widget CustomTextField(ValueKey key, TextInputType textType, Function volidator,
    Function onSaved, String label, String hintText, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: const Color(0xff000000),
          fontWeight: FontWeight.w400,
          fontFamily: "NotoSansCJKkr",
          fontStyle: FontStyle.normal,
          fontSize: 28.0 * getScaleHeight(context),
        ),
      ),
      TextFormField(
        key: key,
        keyboardType: textType,
        autovalidateMode: AutovalidateMode.always,
        obscureText: textType.hashCode == TextInputType.visiblePassword.hashCode
            ? true
            : false,
        autofocus: false,
        validator: (value) => volidator(value),
        onSaved: (value) => onSaved(value),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_rounded),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xff999999),
            fontWeight: FontWeight.w400,
            fontFamily: "NotoSansCJKkr",
            fontStyle: FontStyle.normal,
            fontSize: 24.0 * getScaleHeight(context),
          ),
          fillColor: Palette.TextFieldColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderColor),
          ),
        ),
      ),
      SizedBox(height: 20 * getScaleHeight(context)),
    ],
  );
}
