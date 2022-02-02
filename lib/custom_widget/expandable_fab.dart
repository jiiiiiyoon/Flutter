import 'package:flutter/material.dart';
import 'package:shallwe_app/screens/quiz/quiz.dart';
import './parent_fab.dart';
import './child_fab.dart';
import '../screens/mission/mission.dart';

final UniqueKey _missionKey = UniqueKey();
final UniqueKey _quizKey = UniqueKey();
ParentActionButton expandableFab(BuildContext context, Key? key) {
  return ParentActionButton(
    distance: 70,
    children: [
      ChildActionButton(
          onpressed: () {
            print('mission buttom clicked');
            print(context.widget.key);
            if (key == _quizKey) {
              print('quiz -> mission');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Mission(key: _missionKey)));
            } else if (_missionKey != key) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Mission(key: _missionKey)),
              );
            }
          },
          icon: Icon(Icons.emoji_flags_outlined)),
      ChildActionButton(
          onpressed: () {
            print('home buttom clicked');
            if (key == _missionKey || key == _quizKey) {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.house_outlined)),
      ChildActionButton(
          onpressed: () {
            print('quiz buttom clicked');
            if (key == _missionKey) {
              print('mission -> mission');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizScreen(key: _quizKey, i: 1)));
            } else if (_quizKey != key) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => QuizScreen(key: _quizKey, i: 1)),
              );
            }
          },
          icon: Icon(Icons.quiz_outlined))
    ],
  );
}
