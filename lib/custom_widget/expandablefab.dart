import 'package:flutter/material.dart';
import 'package:shallwe_app/screens/quiz/quiz.dart';
import './parent_fab.dart';
import './child_fab.dart';
import '../screens/mission/mission.dart';
// import '../screens/quiz/';

ParentActionButton expandableFab(BuildContext context) {
  return ParentActionButton(
    distance: 70,
    children: [
      ChildActionButton(
          onpressed: () {
            print('mission buttom clicked');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Mission()),
            );
          },
          icon: Icon(Icons.emoji_flags_outlined)),
      ChildActionButton(
          onpressed: () {
            print('home buttom clicked');
          },
          icon: Icon(Icons.house_outlined)),
      ChildActionButton(
          onpressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => QuizScreen(1)),
            );
            print('quiz buttom clicked');
          },
          icon: Icon(Icons.quiz_outlined))
    ],
  );
}
