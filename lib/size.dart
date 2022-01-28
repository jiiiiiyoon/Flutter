import 'package:flutter/material.dart';

double getScaleWidth(BuildContext context) {
  const designGuidWidth = 750;
  final width = MediaQuery.of(context).size.width / designGuidWidth;
  return width;
}

double getScaleHeight(BuildContext context) {
  const designGuidHeight = 1624;
  final height = MediaQuery.of(context).size.height / designGuidHeight;
  return height;
}
