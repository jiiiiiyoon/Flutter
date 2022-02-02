import 'package:flutter/material.dart';

class RankProvider extends ChangeNotifier {
  late int userRank = 0;

  changeRank(int changeRank) {
    userRank = changeRank;
    notifyListeners();
  }
}
