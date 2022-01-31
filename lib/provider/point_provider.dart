import 'package:flutter/material.dart';
import '../screens/login/sing_in.dart';

class PointProvider extends ChangeNotifier {
  int userPoint = currentUser.pointSum;

  addPoint(int point) {
    userPoint = currentUser.pointSum += point;
    notifyListeners();
  }

  subPoint(int point) {
    userPoint = currentUser.pointSum -= point;
    notifyListeners();
  }
}
