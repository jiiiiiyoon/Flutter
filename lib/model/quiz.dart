import 'package:cloud_firestore/cloud_firestore.dart';

class QuizList {
  late List<Quiz> quizList;

  QuizList({
    required this.quizList,
  });

  factory QuizList.fromDocument(QuerySnapshot snapshots) {
    // print(snapshot.size);
    // snapshot에는 퀴즈 문서들이 담겨있음
    List<Quiz> quizList = [];
    for (var quizDoc in snapshots.docs) {
      //문서 하나하나를 꺼내 quizDoc 담는다
      Map getDocs = quizDoc.data() as Map; //docd에서 데이터를 꺼내 getDocs에 저장
      quizList
          .add(Quiz.fromDocument(getDocs)); //그걸 가지고 quiz모델을 생성 후 quizList에 저장
    }
    return QuizList(quizList: quizList);
  }
}

class Quiz {
  late String question;
  late List<Answer> answerList;

  Quiz({
    required this.question,
    required this.answerList,
  });

  factory Quiz.fromDocument(Map doc) {
    List<Answer> answerList = [];
    (doc['answer'] as Map).forEach((key, value) {
      answerList.add(Answer.fromDocument(value));
    });
    return Quiz(
      question: doc['question'],
      answerList: answerList,
    );
  }
}

class Answer {
  late bool check;
  late String content;

  Answer({
    required this.check,
    required this.content,
  });

  factory Answer.fromDocument(Map doc) {
    return Answer(check: doc['check'], content: doc['content']);
  }
}
