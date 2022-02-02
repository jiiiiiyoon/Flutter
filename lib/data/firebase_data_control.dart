import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shallwe_app/model/news.dart';
import 'package:shallwe_app/model/quiz.dart';
import '../screens/login/sing_in.dart';
import '../model/user.dart';

final userRef = FirebaseFirestore.instance.collection('user');
final missionRef = FirebaseFirestore.instance.collection('mission');
final quizRef = FirebaseFirestore.instance.collection('quiz');
final newsRef = FirebaseFirestore.instance.collection('news');
final rankRef = FirebaseFirestore.instance.collection('rank');

//로그인한 유저의 정보를 가져와 전역변수에 저장
setCurrentUser(FirebaseAuth _authInstance, String? userName) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();
  print('get user data');

  if (!docSnapshot.exists) {
    print('no user data -> start create user DB');
    await createUserData(_authInstance, userName!);
    docSnapshot = await userRef.doc(_authInstance.currentUser!.uid).get();
  }

  currentUser = cUser.fromDocument(docSnapshot);
}

//회원가입 후 유저 db생성
createUserData(FirebaseAuth _authInstance, String userName) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();
  QuerySnapshot<Map<String, dynamic>> missionSnapshot = await missionRef.get();

  Map<String, dynamic> missions = {};
  int docIdx = 0;
  missionSnapshot.docs.forEach((element) {
    missions.addAll({docIdx.toString(): element.data()});
    docIdx++;
  });
  if (!docSnapshot.exists) {
    print('create user DB');
    userRef.doc(_authInstance.currentUser!.uid).set({
      'point_sum': 0,
      'name': userName,
      'mission': missions,
    });
    print('create rank db');
    await rankRef.doc('rank').update({
      '${_authInstance.currentUser!.uid}': {
        'name': userName,
        'point_sum': 0,
      }
    });
  }
}

updateUserData(
    FirebaseAuth _authInstance, int idx, bool weekCheck, int userPoint) async {
  print('update user data(point and mission check');
  await userRef.doc(_authInstance.currentUser!.uid).update({
    'mission.${idx}.week_check': weekCheck, //중첩된 필드 업데이트
    'point_sum': userPoint,
  });
  await rankRef
      .doc('rank')
      .update({'${_authInstance.currentUser!.uid}.point_sum': userPoint});
}

//===================================
getQuizData() async {
  QuerySnapshot snapshots = await quizRef.get();
  print('get quiz data');
  return await QuizList.fromDocument(snapshots);
}

getNewsData() async {
  QuerySnapshot snapshots = await newsRef.get();
  print('get news data');
  return await NewsList.fromDocument(snapshots);
}

getRankStream() {
  print('start get stream');
  return rankRef.doc('rank').snapshots();
}
